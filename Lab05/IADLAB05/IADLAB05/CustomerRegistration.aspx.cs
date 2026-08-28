using System;
using System.Configuration;
using System.Data.SqlClient;


namespace PVFC
{
    public partial class CustomerRegistration : System.Web.UI.Page
    {
       
        string connStr = ConfigurationManager.ConnectionStrings["PVFCConnectionString"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                ddlCity.Items.Insert(0, new System.Web.UI.WebControls.ListItem("Select City", ""));
            }
        }

     
        protected void ddlCity_SelectedIndexChanged(object sender, EventArgs e)
        {
            txtPostal.Text = ddlCity.SelectedValue; 
        }
        protected void btnBack_Click(object sender, EventArgs e)
        {
            Response.Redirect("index.aspx");
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