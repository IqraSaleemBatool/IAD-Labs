using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;

namespace PVFC
{
    public partial class ProductUpdate : BasePage
    {
        string connectionString = ConfigurationManager.ConnectionStrings["PVFCConnectionString"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            
            if (Session["Role"] == null)
            {
                Response.Redirect("Login.aspx");
                return;
            }

            string role = Session["Role"].ToString();
            if (role != "Admin")
            {
                Response.Write("<h3>Access Denied!</h3><p>Only Administrator can update products.</p>");
                Response.End();
                return;
            }

            if (!IsPostBack)
            {
                LoadProductNames();
            }
        }

        
        private void LoadProductNames()
        {
            try
            {
                using (SqlConnection connnect = new SqlConnection(connectionString))
                {
                    string sqlquery = "SELECT Product_Id, Product_Description "+
                                    "FROM PRODUCT_t "+
                                    "ORDER BY Product_Description";

                    SqlCommand command = new SqlCommand(sqlquery, connnect);
                    connnect.Open();
                    SqlDataReader dataReader = command.ExecuteReader();

                    ddlProducts.Items.Clear();
                    ddlProducts.Items.Add(new System.Web.UI.WebControls.ListItem("-- Select a Product --", ""));

                    while (dataReader.Read())
                    {
                        ddlProducts.Items.Add(new System.Web.UI.WebControls.ListItem(
                            dataReader["Product_Description"].ToString(),
                            dataReader["Product_Id"].ToString()));
                    }
                    dataReader.Close();
                }
            }
            catch (Exception ex)
            {
                ShowMessage("Error loading products: " + ex.Message, "error");
            }
        }

        
        protected void ddlProducts_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (!string.IsNullOrEmpty(ddlProducts.SelectedValue))
            {
                int productId = Convert.ToInt32(ddlProducts.SelectedValue);
                LoadProductDetails(productId);
                ShowMessage("Product selected. You can now update the details.", "info");
            }
            else
            {
                ClearForm();
            }
        }

        
        private void LoadProductDetails(int productId)
        {
            try
            {
                using (SqlConnection connect = new SqlConnection(connectionString))
                {
                    string sqlQuery = "SELECT "+
                                        "Product_Id, "+
                                        "Product_Description, "+
                                        "Product_Finish, "+
                                        "Standard_Price, "+
                                        "Product_Line_Id "+
                                    "FROM PRODUCT_t  "+
                                    "WHERE Product_Id = @pid";

                    SqlCommand command = new SqlCommand(sqlQuery, connect);
                    command.Parameters.AddWithValue("@pid", productId);

                    connect.Open();
                    SqlDataReader dr = command.ExecuteReader();

                    if (dr.Read())
                    {
                        txtProductId.Text = dr["Product_Id"].ToString();
                        txtDescription.Text = dr["Product_Description"].ToString();
                        txtFinish.Text = dr["Product_Finish"].ToString();
                        txtPrice.Text = dr["Standard_Price"].ToString();

                        // Set dropdown value
                        string lineId = dr["Product_Line_Id"] != DBNull.Value ? dr["Product_Line_Id"].ToString() : "";
                        if (!string.IsNullOrEmpty(lineId))
                            ddlProductLine.SelectedValue = lineId;
                        else
                            ddlProductLine.SelectedIndex = 0;
                    }
                    dr.Close();
                }
            }
            catch (Exception ex)
            {
                ShowMessage("Error loading product details: " + ex.Message, "error");
            }
        }

        
        protected void btnUpdate_Click(object sender, EventArgs e)
        {
            if (string.IsNullOrEmpty(txtProductId.Text))
            {
                ShowMessage("Please select a product to update first!", "error");
                return;
            }

            try
            {
                using (SqlConnection con = new SqlConnection(connectionString))
                {
                    string query = "UPDATE PRODUCT_t "+
                                     "SET Product_Line_Id = @LineId, "+
                                         "Product_Description = @Desc, "+
                                         "Product_Finish = @Finish, "+
                                         "Standard_Price = @Price "+
                                     "WHERE Product_Id = @Pid";

                    using (SqlCommand cmd = new SqlCommand(query, con))
                    {
                        cmd.Parameters.AddWithValue("@Pid", txtProductId.Text);

                        if (string.IsNullOrEmpty(ddlProductLine.SelectedValue))
                            cmd.Parameters.AddWithValue("@LineId", DBNull.Value);
                        else
                            cmd.Parameters.AddWithValue("@LineId", ddlProductLine.SelectedValue);

                        cmd.Parameters.AddWithValue("@Desc", txtDescription.Text);
                        cmd.Parameters.AddWithValue("@Finish", txtFinish.Text);

                        decimal price;
                        if (decimal.TryParse(txtPrice.Text, out price))
                            cmd.Parameters.AddWithValue("@Price", price);
                        else
                            cmd.Parameters.AddWithValue("@Price", 0);

                        con.Open();
                        int rows = cmd.ExecuteNonQuery();

                        if (rows > 0)
                        {
                            ShowMessage("Product Updated Successfully!", "success");
                            LoadProductNames();  // Refresh dropdown
                            LoadProductDetails(Convert.ToInt32(txtProductId.Text));  // Reload details
                        }
                        else
                        {
                            ShowMessage("Product ID Not Found!", "error");
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                ShowMessage("Error: " + ex.Message, "error");
            }
        }

        
        protected void btnRefresh_Click(object sender, EventArgs e)
        {
            LoadProductNames();
            ClearForm();
            ShowMessage("Product list refreshed!", "info");
        }

        
        protected void btnBackToMain_Click(object sender, EventArgs e)
        {
            RedirectToDashboard();
        }

        
        private void ClearForm()
        {
            txtProductId.Text = "";
            txtDescription.Text = "";
            txtFinish.Text = "";
            txtPrice.Text = "";
            ddlProductLine.SelectedIndex = 0;
            ddlProducts.SelectedIndex = 0;
        }

        
        private void ShowMessage(string message, string type)
        {
            lblMsg.Text = message;
            if (type == "success")
            {
                lblMsg.CssClass = "success";
            }
            else if (type == "error")
            {
                lblMsg.CssClass = "error";
            }
            else
            {
                lblMsg.CssClass = "info";
            }
        }
    }
}