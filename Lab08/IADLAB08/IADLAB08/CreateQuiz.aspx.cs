using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Windows.Input;

namespace QuizManagementSystem
{
    public partial class CreateQuiz : Page
    {
        string connectionString =
            System.Configuration.ConfigurationManager.ConnectionStrings["QuizDB"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["UserID"] == null)
            {
                Response.Redirect("Login.aspx");
            }
                if(Session["Role"].ToString() != "Teacher")
            {
                Response.Redirect("Login.aspx");
            }
                

            if (!IsPostBack)
            {
                LoadTheSubjects();
            }
                
        }

        void LoadTheSubjects()
        {
            string sqlQuery = "SELECT SubjectID, SubjectName FROM Subjects_t";

            using (SqlConnection connect = new SqlConnection(connectionString))
            using (SqlCommand command = new SqlCommand(sqlQuery, connect))
            {
                SqlDataAdapter dataAdapter = new SqlDataAdapter(command);
                DataTable dataTable = new DataTable();
                dataAdapter.Fill(dataTable);

                ddlSubject.DataSource = dataTable;
                ddlSubject.DataTextField = "SubjectName";
                ddlSubject.DataValueField = "SubjectID";
                ddlSubject.DataBind();

                ddlSubject.Items.Insert(0, " Select Subject ");
            }
        }

        protected void ddlSubject_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (ddlSubject.SelectedValue != "0")
                LoadTHeQuestions();
        }

        void LoadTHeQuestions()
        {
            string loadquery = "SELECT QuestionID, QuestionText FROM Questions_t WHERE SubjectID=@sid";

            using (SqlConnection connect = new SqlConnection(connectionString))
            using (SqlCommand command = new SqlCommand(loadquery, connect))
            {
                command.Parameters.AddWithValue("@sid", ddlSubject.SelectedValue);

                SqlDataAdapter dataAdapter = new SqlDataAdapter(command);
                DataTable dataTable = new DataTable();
                dataAdapter.Fill(dataTable);

                cblQuestions.DataSource = dataTable;
                cblQuestions.DataTextField = "QuestionText";
                cblQuestions.DataValueField = "QuestionID";
                cblQuestions.DataBind();
            }
        }
        protected void btnBack_Click(object sender, EventArgs e)
        {
            Response.Redirect("Dashboard.aspx");
        }
        protected void btnCreate_Click(object sender, EventArgs e)
        {
            if (ddlSubject.SelectedValue == "0")
                return;

            int count = 0;
            foreach (ListItem i in cblQuestions.Items)
                if (i.Selected) 
                    count++;

            if (count == 0) 
                return;

            int quizId;

            using (SqlConnection connect = new SqlConnection(connectionString))
            {
                connect.Open();

                string query = "INSERT INTO Quiz_t " +
                                " (SubjectID, Title, TotalQ, TotalTime, StartTime, EndTime, ShuffleQ, ShuffleOpt, AttemptOnce, Review, NegativeMark) "+
                              " VALUES " +
                              " (@s,@t,@q,@time,GETDATE(),GETDATE(),@sq,@so,@a,1,0);"+ 
                               " SELECT SCOPE_IDENTITY();";

                SqlCommand command = new SqlCommand(query, connect);
                command.Parameters.AddWithValue("@s", ddlSubject.SelectedValue);
                command.Parameters.AddWithValue("@t", txtQuizTitle.Text);
                command.Parameters.AddWithValue("@q", count);
                command.Parameters.AddWithValue("@time", txtTimeAllowed.Text);
                command.Parameters.AddWithValue("@sq", chkShuffleQuestions.Checked);
                command.Parameters.AddWithValue("@so", chkShuffleOptions.Checked);
                command.Parameters.AddWithValue("@a", chkAttemptOnce.Checked);

                quizId = Convert.ToInt32(command.ExecuteScalar());

                foreach (ListItem item in cblQuestions.Items)
                {
                    if (item.Selected)
                    {
                        SqlCommand command2 = new SqlCommand(
                            "INSERT INTO QuizQuestions_t VALUES (@qz,@qst)", connect);

                        command2.Parameters.AddWithValue("@qz", quizId);
                        command2.Parameters.AddWithValue("@qst", item.Value);
                        command2.ExecuteNonQuery();
                    }
                }
            }

            lblMessage.Text = "Quiz Created Successfully!";
        }
    }
}