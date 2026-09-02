using System;
using System.Data.SqlClient;

namespace QuizManagementSystem
{
    public partial class AddUser : System.Web.UI.Page
    {
        string connectionString =
            System.Configuration.ConfigurationManager.ConnectionStrings["QuizDB"].ConnectionString;

        protected void btnAdd_Click(object sender, EventArgs e)
        {
            if (txtUser.Text == "" || txtPass.Text == "")
            {
                lblMsg.Text = "Please fill all fields";
                return;
            }

            using (SqlConnection connect = new SqlConnection(connectionString))
            {
                string sqlQuery = "Insert Into Users_t (Username, Password, Role) " +
                             " Values (@u, @p, @r)";

                SqlCommand command = new SqlCommand(sqlQuery, connect);

                command.Parameters.AddWithValue("@u", txtUser.Text);
                command.Parameters.AddWithValue("@p", txtPass.Text);
                command.Parameters.AddWithValue("@r", ddlRole.SelectedValue);

                connect.Open();
                command.ExecuteNonQuery();
                connect.Close();
            }

            lblMsg.Text = "User Added Successfully!";

            txtUser.Text = "";
            txtPass.Text = "";
            ddlRole.SelectedIndex = 0;
        }
        protected void btnBack_Click(object sender, EventArgs e)
        {
            Response.Redirect("Dashboard.aspx");
        }
    }
}