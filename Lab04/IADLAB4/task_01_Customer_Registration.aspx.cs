using System;
using System.Configuration;
using System.Data.SqlClient;


namespace PVFC
{
    public partial class task_01_Customer_Registration : System.Web.UI.Page
    {
        // Connection string to your SQL Server database
        string connStr = ConfigurationManager.ConnectionStrings["PVFCConnectionString"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                ddlCity.Items.Insert(0, new System.Web.UI.WebControls.ListItem("Select City", ""));
            }
        }

        // Auto-fill postal code from city dropdown
        protected void ddlCity_SelectedIndexChanged(object sender, EventArgs e)
        {
            txtPostal.Text = ddlCity.SelectedValue; // Postal code value from dropdown
        }

        protected void btnRegister_Click(object sender, EventArgs e)
        {
            try
            {
                using (SqlConnection con = new SqlConnection(connStr))
                {
                    string query = @"INSERT INTO CUSTOMER_t
                                     (Customer_Id, Customer_Name, Customer_Address, Customer_City, Customer_State, Postal_Code)
                                     VALUES
                                     (@Id, @Name, @Address, @City, @State, @Postal)";

                    using (SqlCommand cmd = new SqlCommand(query, con))
                    {
                        cmd.Parameters.AddWithValue("@Id", txtId.Text);
                        cmd.Parameters.AddWithValue("@Name", txtName.Text);
                        cmd.Parameters.AddWithValue("@Address", txtAddress.Text);
                        cmd.Parameters.AddWithValue("@City", ddlCity.SelectedItem.Text);
                        cmd.Parameters.AddWithValue("@State", txtState.Text);
                        cmd.Parameters.AddWithValue("@Postal", txtPostal.Text);

                        con.Open();
                        int rows = cmd.ExecuteNonQuery();

                        lblMsg.Text = rows > 0 ? "Customer Registered Successfully!" : "Registration Failed!";
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