using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;

namespace PVFC
{
    public partial class task_01_product_search : System.Web.UI.Page
    {
        // Your database connection string
        string connStr = ConfigurationManager.ConnectionStrings["PVFCConnectionString"].ConnectionString;


        protected void btnSearch_Click(object sender, EventArgs e)
        {
            string searchText = txtSearch.Text.Trim();

            if (string.IsNullOrEmpty(searchText))
            {
                // Clear GridView if search box is empty
                GridView1.DataSource = null;
                GridView1.DataBind();
                return;
            }

            try
            {
                using (SqlConnection con = new SqlConnection(connStr))
                {
                    // Query to select matching products
                    string query = @"SELECT Product_Id, Product_Description, Product_Finish, Standard_Price 
                                     FROM PRODUCT_t 
                                     WHERE Product_Description LIKE '%' + @search + '%'";

                    SqlCommand cmd = new SqlCommand(query, con);
                    cmd.Parameters.AddWithValue("@search", searchText);

                    SqlDataAdapter da = new SqlDataAdapter(cmd);
                    DataTable dt = new DataTable();
                    da.Fill(dt);

                    // Bind results to GridView
                    GridView1.DataSource = dt;
                    GridView1.DataBind();
                }
            }
            catch (Exception ex)
            {
                // Optional: display error in a Label if needed
                // lblMsg.Text = "Error: " + ex.Message;
            }
        }
    }
}