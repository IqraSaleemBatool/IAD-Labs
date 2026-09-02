using System;
using System.Data;
using System.Data.SqlClient;
using System.Drawing;
using System.Security.Cryptography;
using System.Web.UI;

namespace QuizManagementSystem
{
    public partial class QuizResult : Page
    {
        string connectionString =
            System.Configuration.ConfigurationManager.ConnectionStrings["QuizDB"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["UserID"] == null)
            {
                Response.Redirect("Login.aspx");
            }

            if (!IsPostBack)
            {
                LoadTHeResults();
            }
        }
        protected void btnBack_Click(object sender, EventArgs ex)
        {
            Response.Redirect("Dashboard.aspx");
        }
        void LoadTHeResults()
        {
            using (SqlConnection connect = new SqlConnection(connectionString))
            {
                string query = " Select ResultID, QuizID, Obtained, Total, " +
                      " (CAST(Obtained AS FLOAT) / Total) * 100 AS Percentage " +
                          " From Result_t " +
                         " Where StudentID = @sid";

                SqlCommand command = new SqlCommand(query, connect);
                command.Parameters.AddWithValue("@sid", Session["UserID"]);

                SqlDataAdapter dataAdapter = new SqlDataAdapter(command);
                DataTable dataTable = new DataTable();

                dataAdapter.Fill(dataTable);

                GridView1.DataSource = dataTable;
                GridView1.DataBind();
            }
        }
    }
}