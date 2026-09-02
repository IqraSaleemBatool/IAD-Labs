using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;

namespace PVFC
{
    public partial class ProductSearch : BasePage
    {
        string connStr = ConfigurationManager.ConnectionStrings["PVFCConnectionString"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            
            CheckAccess(new string[] { "Admin", "Manager", "Customer" });

            if (!IsPostBack)
            {
                LoadProductNames();
            }
        }

       
        private void LoadProductNames()
        {
            try
            {
                using (SqlConnection con = new SqlConnection(connStr))
                {
                    string query = @"SELECT Product_Id, Product_Description 
                                    FROM PRODUCT_t 
                                    ORDER BY Product_Description";

                    SqlCommand cmd = new SqlCommand(query, con);
                    con.Open();
                    SqlDataReader dr = cmd.ExecuteReader();

                    ddlProductNames.Items.Clear();
                    ddlProductNames.Items.Add(new System.Web.UI.WebControls.ListItem("-- Select a Product --", ""));

                    while (dr.Read())
                    {
                        ddlProductNames.Items.Add(new System.Web.UI.WebControls.ListItem(
                            dr["Product_Description"].ToString(),
                            dr["Product_Id"].ToString()));
                    }
                    dr.Close();
                }
            }
            catch (Exception ex)
            {
                ShowMessage("Error loading products: " + ex.Message, "error");
            }
        }

        // When user selects a product from dropdown
        protected void ddlProductNames_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (!string.IsNullOrEmpty(ddlProductNames.SelectedValue))
            {
                int productId = Convert.ToInt32(ddlProductNames.SelectedValue);
                LoadProductDetails(productId);
            }
            else
            {
                productDetail.Visible = false;
                lblResultCount.Text = "Select a product from the dropdown to view details.";
            }
        }

      
        protected void btnSearch_Click(object sender, EventArgs e)
        {
            if (string.IsNullOrEmpty(ddlProductNames.SelectedValue))
            {
                ShowMessage("Please select a product from the dropdown first!", "error");
                return;
            }

            int productId = Convert.ToInt32(ddlProductNames.SelectedValue);
            LoadProductDetails(productId);
            ShowMessage("Product details loaded successfully!", "success");
        }

        protected void btnClear_Click(object sender, EventArgs e)
        {
            ddlProductNames.SelectedIndex = 0;
            productDetail.Visible = false;
            lblResultCount.Text = "Select a product from the dropdown to view details.";
            ShowMessage("Cleared! Select a product to view details.", "info");
        }

       
        private void LoadProductDetails(int productId)
        {
            try
            {
                using (SqlConnection con = new SqlConnection(connStr))
                {
                    string query = @"SELECT 
                                        P.Product_Id,
                                        P.Product_Description,
                                        P.Product_Finish,
                                        P.Standard_Price,
                                        ISNULL(PL.Product_Line_Name, 'Uncategorized') AS Category
                                    FROM PRODUCT_t P
                                    LEFT JOIN PRODUCT_LINE_t PL ON P.Product_Line_Id = PL.Product_Line_Id
                                    WHERE P.Product_Id = @pid";

                    SqlCommand cmd = new SqlCommand(query, con);
                    cmd.Parameters.AddWithValue("@pid", productId);

                    con.Open();
                    SqlDataReader dr = cmd.ExecuteReader();

                    if (dr.Read())
                    {
                        lblProductId.Text = dr["Product_Id"].ToString();
                        lblProductName.Text = dr["Product_Description"].ToString();
                        lblFinish.Text = dr["Product_Finish"].ToString();
                        lblPrice.Text = "$" + Convert.ToDecimal(dr["Standard_Price"]).ToString("N2");
                        lblCategory.Text = dr["Category"].ToString();

                        productDetail.Visible = true;
                        lblResultCount.Text = "Showing details for selected product:";
                    }
                    else
                    {
                        productDetail.Visible = false;
                        lblResultCount.Text = "Product not found!";
                        ShowMessage("Product not found in database!", "error");
                    }
                    dr.Close();
                }
            }
            catch (Exception ex)
            {
                ShowMessage("Error loading product details: " + ex.Message, "error");
            }
        }

        
        protected void btnBack_Click(object sender, EventArgs e)
        {
            RedirectToDashboard();
        }

        
        private void ShowMessage(string message, string type)
        {
            lblMsg.Text = message;
            if (type == "error")
            {
                lblMsg.CssClass = "message error";
            }
            else if (type == "success")
            {
                lblMsg.CssClass = "message success";
            }
            else
            {
                lblMsg.CssClass = "message info";
            }
        }
    }
}