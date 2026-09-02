using System;
using System.Data;
using System.Data.Common;
using System.Data.SqlClient;
using System.Web.UI;

namespace QuizManagementSystem
{
    public partial class TeacherResults : Page
    {
        string connectionString =
            System.Configuration.ConfigurationManager.ConnectionStrings["QuizDB"].ConnectionString;

        protected void Page_Load(object sender, EventArgs ex)
        {
            if (Session["UserID"] == null )
            {
                Response.Redirect("Login.aspx");
            }
               if (Session["Role"].ToString() != "Teacher")
            {
                Response.Redirect("Login.aspx");
            }

            if (!IsPostBack)
            {
                LoadTheResults();
            }
        }
        protected void btnBack_Click(object sender, EventArgs ex)
        {
            Response.Redirect("Dashboard.aspx");
        }

        void LoadTheResults()
        {
            string query = " SELECT  r.StudentID, r.QuizID,r.Obtained, r.Total, " +
                       " (CAST(r.Obtained AS FLOAT) / r.Total) * 100 AS Percentage   " +
                        " FROM Result_t r " +
                       " ORDER BY r.ResultID DESC " ;

            using (SqlConnection connect = new SqlConnection(connectionString))
            using (SqlDataAdapter dataAdapter = new SqlDataAdapter(query, connect))
            {
                DataTable datATAble = new DataTable();
                dataAdapter.Fill(datATAble);

                GridView1.DataSource = datATAble;
                GridView1.DataBind();
            }
        }
    }
}