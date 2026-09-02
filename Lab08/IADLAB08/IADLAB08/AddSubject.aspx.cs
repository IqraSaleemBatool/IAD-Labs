using System;
using System.Data.SqlClient;

namespace QuizManagementSystem
{
    public partial class AddSubject : System.Web.UI.Page
    {
        string connectionString =
            System.Configuration.ConfigurationManager.ConnectionStrings["QuizDB"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["UserID"] == null )
            {
                Response.Redirect("Login.aspx");
            }
                if(Session["Role"].ToString() != "Admin")
            {
                Response.Redirect("Login.aspx");
            }
                
        }
        protected void btnBack_Click(object sender, EventArgs e)
        {
            Response.Redirect("Dashboard.aspx");
        }
        protected void btnAdd_Click(object sender, EventArgs e)
        {
            using (SqlConnection connect = new SqlConnection(connectionString))
            {
                string sqlquery = "Insert Into Subjects_t (SubjectName) Values (@s)";

                SqlCommand command = new SqlCommand(sqlquery, connect);
                command.Parameters.AddWithValue("@s", txtSubject.Text);

                connect.Open();
                command.ExecuteNonQuery();
            }

            lblMsg.Text = "Subject Added Successfully!";
            txtSubject.Text = "";
        }
    }
}