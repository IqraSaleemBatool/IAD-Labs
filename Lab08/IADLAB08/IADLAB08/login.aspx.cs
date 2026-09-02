using System;
using System.Data.SqlClient;
using System.Web.UI;

namespace QuizManagementSystem
{
    public partial class Login : Page
    {
        string connectionString = System.Configuration.ConfigurationManager.ConnectionStrings["QuizDB"].ConnectionString;

        protected void btnLogin_Click(object sender, EventArgs e)
        {
            string username = txtUsername.Text.Trim();
            string password = txtPassword.Text.Trim();

            SqlConnection connect = new SqlConnection(connectionString);

            string query = "select * fRom Users_t " +
                           "Where Username=@u and Password=@p";
            SqlCommand command = new SqlCommand(query, connect);

            command.Parameters.AddWithValue("@u", username);
            command.Parameters.AddWithValue("@p", password);

            try
            {
                connect.Open();
                SqlDataReader dataRead = command.ExecuteReader();

                if (dataRead.Read())
                {
                    Session["UserID"] = dataRead["UserID"].ToString();
                    Session["UserName"] = dataRead["Username"].ToString(); 
                    Session["Role"] = dataRead["Role"].ToString();

                    Response.Redirect("Dashboard.aspx");
                }
                else
                {
                    lblError.Text = "Invalid Username or Password!!!!!";
                    txtPassword.Text = "";
                }
            }
            catch (Exception ex)
            {
                lblError.Text = "Error: " + ex.Message;
            }

            connect.Close();
        }
    }
}