using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI.WebControls;
using System.Net;
using System.IO;
using Newtonsoft.Json;
using System.Collections.Generic;

namespace PVFC
{
    public partial class CustomerDashboard : BasePage
    {
        string connectionString = ConfigurationManager.ConnectionStrings["PVFCConnectionString"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            CheckAccess(new string[] { "Customer", "Admin", "Manager", "Salesperson" });

            if (!IsPostBack)
            {
                LoadProducts();
                LoadCart();
                gvRecommendations.DataSource = null;
                gvRecommendations.DataBind();
                LoadReorderSuggestions();
            }
        }

        
        private void LoadProducts()
        {
            using (SqlConnection connect = new SqlConnection(connectionString))
            {
                string sqlquery = "SELECT Product_Id, Product_Description, Standard_Price " +
                                  "FROM PRODUCT_t ORDER BY Product_Id";
               
                SqlDataAdapter dataAdapter = new SqlDataAdapter(sqlquery, connect);

                DataTable dataTable = new DataTable();
                dataAdapter.Fill(dataTable);

                gvProducts.DataSource = dataTable;
                gvProducts.DataBind();
            }
        }

      
        protected void btnSearch_Click(object sender, EventArgs e)
        {
            string search = txtSearch.Text.Trim();

            if (string.IsNullOrEmpty(search))
            {
                LoadProducts();
                return;
            }

            using (SqlConnection connect = new SqlConnection(connectionString))
            {
                string sqlquery = "SELECT Product_Id, Product_Description, Standard_Price "+
                                 "FROM PRODUCT_t "+
                                 "WHERE Product_Description LIKE '%' + @s + '%'";

                SqlCommand command = new SqlCommand(sqlquery, connect);
                command.Parameters.AddWithValue("@s", search);

                SqlDataAdapter dataAdapter = new SqlDataAdapter(command);
                DataTable dataTable = new DataTable();
                dataAdapter.Fill(dataTable);

                gvProducts.DataSource = dataTable;
                gvProducts.DataBind();
            }
        }

        protected void btnShowAll_Click(object sender, EventArgs e)
        {
            txtSearch.Text = "";
            LoadProducts();
        }

       
        protected void gvProducts_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName != "AddToCart") 
                return;

            int index = Convert.ToInt32(e.CommandArgument);
            int productId = Convert.ToInt32(gvProducts.DataKeys[index].Value);

            string productName = gvProducts.Rows[index].Cells[1].Text;

            decimal price = Convert.ToDecimal(
                gvProducts.Rows[index].Cells[2].Text
                .Replace("$", "")
                .Replace(",", "")
            );

            TextBox txtQty = (TextBox)gvProducts.Rows[index].FindControl("txtQty");
            int qty = Convert.ToInt32(txtQty.Text);

            if (qty <= 0)
            {
                ShowMessage("Invalid quantity!", "error");
                return;
            }

            DataTable cart = Session["Cart"] as DataTable;

            if (cart == null)
            {
                cart = new DataTable();
                cart.Columns.Add("Product_Id", typeof(int));
                cart.Columns.Add("Product_Name", typeof(string));
                cart.Columns.Add("Price", typeof(decimal));
                cart.Columns.Add("Quantity", typeof(int));
                cart.Columns.Add("Total", typeof(decimal));
            }

            bool found = false;

            foreach (DataRow row in cart.Rows)
            {
                if ((int)row["Product_Id"] == productId)
                {
                    row["Quantity"] = (int)row["Quantity"] + qty;
                    row["Total"] = (decimal)row["Price"] * (int)row["Quantity"];
                    found = true;
                    break;
                }
            }

            if (!found)
            {
                cart.Rows.Add(productId, productName, price, qty, price * qty);
            }

            Session["Cart"] = cart;

            LoadCart();
            ShowMessage(productName + " added to cart!", "success");

            LoadRecommendations(productId);
            
        }

       
        protected void gvCart_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName != "Remove") 
                return;

            int index = Convert.ToInt32(e.CommandArgument);

            DataTable cart = Session["Cart"] as DataTable;

            if (cart != null && index < cart.Rows.Count)
            {
                string name = cart.Rows[index]["Product_Name"].ToString();

                cart.Rows.RemoveAt(index);

                Session["Cart"] = cart;

                LoadCart();
                ShowMessage(name + " removed from cart", "info");
            }
        }

      
        private void LoadRecommendations(int productId)
        {
            List<int> recIds = GetRecommendations(productId);

            if (recIds == null || recIds.Count == 0)
            {
                gvRecommendations.DataSource = null;
                gvRecommendations.DataBind();
                return;
            }

            string ids = string.Join(",", recIds);

            using (SqlConnection connect = new SqlConnection(connectionString))
            {
                string sqlquery = "SELECT Product_Id, Product_Description, Standard_Price "+
                                 "FROM PRODUCT_t "+
                                 "WHERE Product_Id IN (" + ids + ")";

                SqlDataAdapter dataAdapter = new SqlDataAdapter(sqlquery, connect);
                DataTable dataTable = new DataTable();
                dataAdapter.Fill(dataTable);

                gvRecommendations.DataSource = dataTable;
                gvRecommendations.DataBind();
            }
        }
        private void LoadReorderSuggestions()
        {
            int userId = Convert.ToInt32(Session["UserId"]);

            using (SqlConnection connect = new SqlConnection(connectionString))
            {
                string sqlquery = "SELECT DISTINCT p.Product_Id, p.Product_Description, p.Standard_Price "+
                                  "FROM PRODUCT_t p "+
                                   "JOIN Order_line_t ol ON p.Product_Id = ol.Product_Id "+
                                   "JOIN Orders_t o ON o.Order_Id = ol.Order_Id "+
                                  "WHERE o.UserID = @uid ";

                SqlCommand command = new SqlCommand(sqlquery, connect);
                command.Parameters.AddWithValue("@uid", userId);

                SqlDataAdapter dataAdapter = new SqlDataAdapter(command);
                DataTable dataTable = new DataTable();
                dataAdapter.Fill(dataTable);

                gvReorder.DataSource = dataTable;
                gvReorder.DataBind();
            }
        }
        
        
        public List<int> GetRecommendations(int productId)
        {
            List<int> recs = new List<int>();

            try
            {
                //somee link
                string baseUrl = "http://www.iqrawebsite.somee.com/Lab11";
                string url = baseUrl + "/Recommendation.aspx?pid=" + productId;

                WebRequest req = WebRequest.Create(url);
                ServicePointManager.ServerCertificateValidationCallback += (sender, cert, chain, sslPolicyErrors) => true;
                WebResponse res = req.GetResponse();

                using (StreamReader reader = new StreamReader(res.GetResponseStream()))
                {
                    string json = reader.ReadToEnd();

                    if (!string.IsNullOrEmpty(json))
                    {
                        recs = JsonConvert.DeserializeObject<List<int>>(json);
                    }
                }
            }
            catch (Exception ex)
            {
                ShowMessage("Recommendation error: " + ex.Message, "error");
            }

            return recs;
        }

     
        private void LoadCart()
        {
            DataTable cart = Session["Cart"] as DataTable;

            DataTable display = new DataTable();
            display.Columns.Add("Product_Name");
            display.Columns.Add("Price");
            display.Columns.Add("Quantity");
            display.Columns.Add("Total");

            decimal total = 0;

            if (cart != null)
            {
                foreach (DataRow row in cart.Rows)
                {
                    display.Rows.Add(row["Product_Name"], row["Price"], row["Quantity"], row["Total"]);
                    total += Convert.ToDecimal(row["Total"]);
                }
            }

            gvCart.DataSource = display;
            gvCart.DataBind();

            lblTotal.Text = "$" + total.ToString("N2");
        }

      
        protected void btnClearCart_Click(object sender, EventArgs e)
        {
            Session["Cart"] = null;
            LoadCart();
            ShowMessage("Cart cleared", "info");
        }

       
        protected void btnCheckout_Click(object sender, EventArgs e)
        {
            DataTable cart = Session["Cart"] as DataTable;

            if (cart == null || cart.Rows.Count == 0)
            {
                ShowMessage("Cart is empty!", "error");
                return;
            }

            Session["CheckoutCart"] = cart;
            Response.Redirect("Checkout.aspx");
        }

       
        protected void btnBack_Click(object sender, EventArgs e)
        {
            RedirectToDashboard();
        }

  
        private void ShowMessage(string msg, string type)
        {
            lblMsg.Text = msg;
            lblMsg.CssClass = type;
        }
    }
}