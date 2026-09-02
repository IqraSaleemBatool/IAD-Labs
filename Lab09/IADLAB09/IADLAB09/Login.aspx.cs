using System;
using System.Data.SqlClient;
using System.Web.UI;

namespace SurveySystem
{
    public partial class Login : Page
    {
        string connectionString =
            System.Configuration.ConfigurationManager.ConnectionStrings["SurveyDB"].ConnectionString;

        protected void btnLogin_Click(object sender, EventArgs e)
        {
            string userName = txtUsername.Text.Trim();
            string passWord = txtPassword.Text.Trim();

            using (SqlConnection connect = new SqlConnection(connectionString))
            {
                string sqlquery = "SELECT * FROM Users_t " +
                                  "WHERE Username=@u AND Password=@p";

                SqlCommand command = new SqlCommand(sqlquery, connect);
                command.Parameters.AddWithValue("@u", userName);
                command.Parameters.AddWithValue("@p", passWord);

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
                        lblError.Text = "Invalid Username or Password!";
                        txtPassword.Text = "";
                    }
                }
                catch (Exception ex)
                {
                    lblError.Text = "Error: " + ex.Message;
                }
            }
        }
    }
}