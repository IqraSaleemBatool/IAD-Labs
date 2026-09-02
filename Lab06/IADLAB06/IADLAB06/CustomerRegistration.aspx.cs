using System;
using System.Configuration;
using System.Data.SqlClient;

namespace PVFC
{
    public partial class CustomerRegistration : System.Web.UI.Page
    {
        string connectionString = ConfigurationManager.ConnectionStrings["PVFCConnectionString"].ConnectionString;

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

        protected void btnRegister_Click(object sender, EventArgs e)
        {
            try
            {
                using (SqlConnection connect = new SqlConnection(connectionString))
                {
                    connect.Open();

                    
                    string query = "INSERT INTO CUSTOMER_t"+
                                    "(Customer_Id, Customer_Name, Customer_Address, Customer_City, Customer_State, Postal_Code)"+
                                     "VALUES"+
                                    "(@Id, @Name, @Address, @City, @State, @Postal)";

                    SqlCommand command1 = new SqlCommand(query, connect);
                    command1.Parameters.AddWithValue("@Id", txtId.Text);
                    command1.Parameters.AddWithValue("@Name", txtName.Text);
                    command1.Parameters.AddWithValue("@Address", txtAddress.Text);
                    command1.Parameters.AddWithValue("@City", ddlCity.SelectedItem.Text);
                    command1.Parameters.AddWithValue("@State", txtState.Text);
                    command1.Parameters.AddWithValue("@Postal", txtPostal.Text);

                    command1.ExecuteNonQuery();

                    string Query = "INSERT INTO Users(Username, Password)"+
                                    "VALUES(@u,@p); SELECT SCOPE_IDENTITY()";

                    SqlCommand command2 = new SqlCommand(Query, connect);
                    command2.Parameters.AddWithValue("@u", txtUsername.Text);
                    command2.Parameters.AddWithValue("@p", txtPassword.Text);

                    int userId = Convert.ToInt32(command2.ExecuteScalar());

                 
                    SqlCommand command3 = new SqlCommand("INSERT INTO UserRoles VALUES(@uid,4)", connect);
                    command3.Parameters.AddWithValue("@uid", userId);
                    command3.ExecuteNonQuery();

                 
                    Session["UserID"] = userId;
                    Session["CustomerID"] = txtId.Text;

                    Response.Redirect("CustomerDashboard.aspx");
                }
            }
            catch (Exception ex)
            {
                lblMsg.Text = "Error: " + ex.Message;
            }
        }
    }
}