using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace QuizManagementSystem
{
    public partial class AddQuestions : Page
    {
        string connectionString =
            System.Configuration.ConfigurationManager.ConnectionStrings["QuizDB"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["UserID"] == null || Session["Role"] == null)
            {
                Response.Redirect("Login.aspx");
                return;
            }

            if (Session["Role"].ToString() != "Teacher")
            {
                Response.Redirect("Login.aspx");
                return;
            }

            if (!IsPostBack)
            {
                LoadTheSubjects();
            }
        }
        protected void btnBack_Click(object sender, EventArgs e)
        {
            Response.Redirect("Dashboard.aspx");
        }
        void LoadTheSubjects()
        {
       
            using (SqlConnection connect = new SqlConnection(connectionString))
            
            {
                SqlDataAdapter dataAdapter = new SqlDataAdapter("select SubjectID, SubjectName " +
                                               " FROM Subjects_t ",connect);

                DataTable dataTable = new DataTable();
                dataAdapter.Fill(dataTable);

                ddlSubject.DataSource = dataTable;
                ddlSubject.DataTextField = "SubjectName";
                ddlSubject.DataValueField = "SubjectID";
                ddlSubject.DataBind();

                ddlSubject.Items.Insert(0, new ListItem(" Select Subject ", "0"));
            }
        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            if (ddlSubject.SelectedValue == "0")
            {
                lblMsg.Text = "Select the Subject!!";
                return;
            }

            if (txtQuestion.Text == "")
            {
                lblMsg.Text = "Enter the Questions!!";
                return;
            }

            string query = "(insert INTO Questions_t " +
                                "SubjectID, QuestionText, OptionA, OptionB, OptionC, OptionD, Correct, Difficulty) " +
                                  "VALUES " +
                                 " (@sub, @q, @a, @b, @c, @d, @correct, 1)";

            using (SqlConnection connect = new SqlConnection(connectionString))
            using (SqlCommand command = new SqlCommand(query, connect))
            {
                command.Parameters.AddWithValue("@sub", ddlSubject.SelectedValue);
                command.Parameters.AddWithValue("@q", txtQuestion.Text);
                command.Parameters.AddWithValue("@a", txtA.Text);
                command.Parameters.AddWithValue("@b", txtB.Text);
                command.Parameters.AddWithValue("@c", txtC.Text);
                command.Parameters.AddWithValue("@d", txtD.Text);
                command.Parameters.AddWithValue("@correct", ddlCorrect.SelectedValue);

                connect.Open();
                command.ExecuteNonQuery();
                connect.Close();
            }

            lblMsg.Text = "Question Added Successfully!";

            txtQuestion.Text = "";
            txtA.Text = "";
            txtB.Text = "";
            txtC.Text = "";
            txtD.Text = "";
        }
    }
}