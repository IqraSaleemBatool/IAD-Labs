using System;
using System.Configuration;
using System.Data.SqlClient;

namespace PVFC
{
    public partial class task_01_product_selection : System.Web.UI.Page
    {
        // Connection string to your PVFC database
        string connStr = ConfigurationManager.ConnectionStrings["PVFCConnectionString"].ConnectionString;


        protected void btnAdd_Click(object sender, EventArgs e)
        {
            try
            {
                // Get input values
                int orderId = int.Parse(txtOrderId.Text);
                int productId = int.Parse(txtProductId.Text);
                int quantity = int.Parse(txtQuantity.Text);

                using (SqlConnection con = new SqlConnection(connStr))
                {
                    // Insert into Order_line_t table
                    string query = @"INSERT INTO Order_line_t (Order_Id, Product_Id, Ordered_Quantity)
                                     VALUES (@oid, @pid, @qty)";

                    SqlCommand cmd = new SqlCommand(query, con);
                    cmd.Parameters.AddWithValue("@oid", orderId);
                    cmd.Parameters.AddWithValue("@pid", productId);
                    cmd.Parameters.AddWithValue("@qty", quantity);

                    con.Open();
                    cmd.ExecuteNonQuery();
                    con.Close();

                    lblMsg.ForeColor = System.Drawing.Color.Green;
                    lblMsg.Text = "Product added to order successfully!";
                }
            }
            catch (FormatException)
            {
                lblMsg.ForeColor = System.Drawing.Color.Red;
                lblMsg.Text = "Please enter valid numeric values for Order ID, Product ID, and Quantity.";
            }
            catch (SqlException ex)
            {
                lblMsg.ForeColor = System.Drawing.Color.Red;
                lblMsg.Text = "Database error: " + ex.Message;
            }
            catch (Exception ex)
            {
                lblMsg.ForeColor = System.Drawing.Color.Red;
                lblMsg.Text = "Error: " + ex.Message;
            }
        }
    }
}