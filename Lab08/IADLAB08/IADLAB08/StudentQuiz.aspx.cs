using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI.WebControls;

namespace QuizManagementSystem
{
    public partial class StudentQuiz : System.Web.UI.Page
    {
        string connectionString =
            System.Configuration.ConfigurationManager.ConnectionStrings["QuizDB"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["UserID"] == null)
                Response.Redirect("Login.aspx");

            if (!IsPostBack)
                LoadQuizzes();
        }

        void LoadQuizzes()
        {
            using (SqlConnection connect = new SqlConnection(connectionString))
            {
                SqlDataAdapter dataAdapter = new SqlDataAdapter("SELECT QuizID, Title FROM Quiz_t", connect);
                DataTable dataTable = new DataTable();
                dataAdapter.Fill(dataTable);

                GridView1.DataSource = dataTable;
                GridView1.DataBind();
            }
        }
        protected void btnBack_Click(object sender, EventArgs ex)
        {
            Response.Redirect("Dashboard.aspx");
        }
        protected void GridView1_RowCommand(object sender, GridViewCommandEventArgs ex)
        {
            if (ex.CommandName == "StartQuiz")
            {
                int Index = Convert.ToInt32(ex.CommandArgument);

                string quizID = GridView1.Rows[Index].Cells[0].Text;

                Session["QuizID"] = quizID;

                Response.Redirect("TakeQuiz.aspx");
            }
        }
    }
}