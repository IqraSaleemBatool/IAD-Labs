using System;
using System.Configuration;
using System.Data.SqlClient;

namespace PVFC
{
    public partial class task_01_product_catalog : System.Web.UI.Page
    {
        string connStr = ConfigurationManager.ConnectionStrings["PVFCConnectionString"].ConnectionString;

        protected void btnUpdate_Click(object sender, EventArgs e)
        {
            try
            {
                using (SqlConnection con = new SqlConnection(connStr))
                {
                    string query = @"UPDATE PRODUCT_t
                                     SET Product_Line_Id = @LineId,
                                         Product_Description = @Desc,
                                         Product_Finish = @Finish,
                                         Standard_Price = @Price
                                     WHERE Product_Id = @Pid";

                    using (SqlCommand cmd = new SqlCommand(query, con))
                    {
                        cmd.Parameters.AddWithValue("@Pid", txtProductId.Text);
                        cmd.Parameters.AddWithValue("@LineId", ddlProductLine.SelectedValue);
                        cmd.Parameters.AddWithValue("@Desc", txtDescription.Text);
                        cmd.Parameters.AddWithValue("@Finish", txtFinish.Text);
                        cmd.Parameters.AddWithValue("@Price", txtPrice.Text);

                        con.Open();
                        int rows = cmd.ExecuteNonQuery();

                        lblMsg.Text = rows > 0 ? "Product Updated Successfully!" : "Product ID Not Found!";
                    }
                }
            }
            catch (Exception ex)
            {
                lblMsg.Text = "Error: " + ex.Message;
            }
        }
    }
}