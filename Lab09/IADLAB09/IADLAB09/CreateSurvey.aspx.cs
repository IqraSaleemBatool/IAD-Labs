using System;
using System.Data.SqlClient;

namespace SurveySystem
{
    public partial class CreateSurvey : System.Web.UI.Page
    {
        string connectionString = System.Configuration.ConfigurationManager.ConnectionStrings["SurveyDB"].ConnectionString;

        protected void btnCreate_Click(object sender, EventArgs ex)
        {
            using (SqlConnection connect = new SqlConnection(connectionString))
            {
                string sqlQuery = "INSERT INTO Survey_t (Title, CreatedBy)" +
                                 " VALUES (@t, @c)";
                SqlCommand command = new SqlCommand(sqlQuery, connect);

                command.Parameters.AddWithValue("@t", txtTitle.Text);
                command.Parameters.AddWithValue("@c", Session["UserID"]);

                connect.Open();
                command.ExecuteNonQuery();
            }

            lblMsg.Text = "Survey is Created Successfully!!!!";
        }

        protected void btnBack_Click(object sender, EventArgs ex)
        {
            Response.Redirect("Dashboard.aspx");
        }
    }
}