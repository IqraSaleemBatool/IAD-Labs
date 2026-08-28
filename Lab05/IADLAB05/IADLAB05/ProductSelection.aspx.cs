using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;

namespace PVFC
{
    public partial class ProductSelection : System.Web.UI.Page
    {
        string connStr = ConfigurationManager.ConnectionStrings["PVFCConnectionString"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadAllProducts();
            }
        }

       
        protected void btnRefresh_Click(object sender, EventArgs e)
        {
            LoadAllProducts();
            ShowMessage("Product list refreshed!", "info");
        }

       
        protected void btnBack_Click(object sender, EventArgs e)
        {
            Response.Redirect("index.aspx");
        }

        protected void gvProducts_RowCommand(object sender, System.Web.UI.WebControls.GridViewCommandEventArgs e)
        {
            if (e.CommandName == "SelectProduct")
            {
                int index = Convert.ToInt32(e.CommandArgument);
                System.Web.UI.WebControls.GridViewRow row = gvProducts.Rows[index];

               
                txtProductId.Text = row.Cells[0].Text;
                txtProductNameDisplay.Text = row.Cells[1].Text;

                ShowMessage("Product selected! Enter Order ID and Quantity to add to order.", "info");
            }
        }

       
        protected void btnAdd_Click(object sender, EventArgs e)
        {
           
            if (string.IsNullOrEmpty(txtOrderId.Text))
            {
                ShowMessage("Order ID is required!", "error");
                return;
            }

            if (string.IsNullOrEmpty(txtProductId.Text))
            {
                ShowMessage("Please select a product first!", "error");
                return;
            }

            if (string.IsNullOrEmpty(txtQuantity.Text))
            {
                ShowMessage("Quantity is required!", "error");
                return;
            }

            try
            {
                int orderId = int.Parse(txtOrderId.Text);
                int productId = int.Parse(txtProductId.Text);
                int quantity = int.Parse(txtQuantity.Text);

                if (quantity <= 0)
                {
                    ShowMessage("Quantity must be greater than 0!", "error");
                    return;
                }

                using (SqlConnection con = new SqlConnection(connStr))
                {
                    con.Open();

                   
                    string checkOrderQuery = "SELECT COUNT(*) FROM Orders_t WHERE Order_Id = @oid";
                    SqlCommand checkOrderCmd = new SqlCommand(checkOrderQuery, con);
                    checkOrderCmd.Parameters.AddWithValue("@oid", orderId);
                    int orderExists = (int)checkOrderCmd.ExecuteScalar();

                    if (orderExists == 0)
                    {
                        ShowMessage("Order ID '" + orderId + "' does not exist! Please create the order first.", "error");
                        return;
                    }

                   
                    string checkDuplicateQuery = @"SELECT COUNT(*) FROM Order_line_t 
                                                   WHERE Order_Id = @oid AND Product_Id = @pid";
                    SqlCommand checkDuplicateCmd = new SqlCommand(checkDuplicateQuery, con);
                    checkDuplicateCmd.Parameters.AddWithValue("@oid", orderId);
                    checkDuplicateCmd.Parameters.AddWithValue("@pid", productId);
                    int duplicateExists = (int)checkDuplicateCmd.ExecuteScalar();

                    if (duplicateExists > 0)
                    {
                        ShowMessage("Product is already added to this order!", "error");
                        return;
                    }

                    string query = @"INSERT INTO Order_line_t (Order_Id, Product_Id, Ordered_Quantity)
                                     VALUES (@oid, @pid, @qty)";

                    SqlCommand cmd = new SqlCommand(query, con);
                    cmd.Parameters.AddWithValue("@oid", orderId);
                    cmd.Parameters.AddWithValue("@pid", productId);
                    cmd.Parameters.AddWithValue("@qty", quantity);

                    cmd.ExecuteNonQuery();

                    ShowMessage("Product added to order successfully!", "success");

                  
                    txtOrderId.Text = "";
                    txtQuantity.Text = "1";
                }
            }
            catch (FormatException)
            {
                ShowMessage("Please enter valid numeric values for Order ID and Quantity.", "error");
            }
            catch (SqlException ex)
            {
                ShowMessage("Database error: " + ex.Message, "error");
            }
            catch (Exception ex)
            {
                ShowMessage("Error: " + ex.Message, "error");
            }
        }

        private void LoadAllProducts()
        {
            try
            {
                using (SqlConnection con = new SqlConnection(connStr))
                {
                    string query = @"SELECT 
                                        Product_Id,
                                        Product_Description,
                                        Product_Finish,
                                        Standard_Price
                                    FROM PRODUCT_t 
                                    ORDER BY Product_Id";

                    SqlDataAdapter da = new SqlDataAdapter(query, con);
                    DataTable dt = new DataTable();
                    da.Fill(dt);

                    gvProducts.DataSource = dt;
                    gvProducts.DataBind();
                }
            }
            catch (Exception ex)
            {
                ShowMessage("Error loading products: " + ex.Message, "error");
            }
        }

       
        private void ShowMessage(string message, string type)
        {
            lblMsg.Text = message;
            if (type == "success")
            {
                lblMsg.CssClass = "message success";
            }
            else if (type == "error")
            {
                lblMsg.CssClass = "message error";
            }
            else
            {
                lblMsg.CssClass = "message info";
            }
        }
    }
}