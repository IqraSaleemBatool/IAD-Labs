using System;
using System.Data;
using System.Data.Common;
using System.Data.SqlClient;
using System.Security.Cryptography;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace QuizManagementSystem
{
    public partial class TakeQuiz : Page
    {
        string connectionString =
            System.Configuration.ConfigurationManager.ConnectionStrings["QuizDB"].ConnectionString;

        DataTable questions
        {
            get
            { 
                return (DataTable)ViewState["questions"]; 
            }
            set
            { 
                ViewState["questions"] = value; 
            }
        }

        int index
        {
            get 
            { 
                return ViewState["index"] != null ? (int)ViewState["index"] : 0;
            }
            set 
            { 
                ViewState["index"] = value; 
            }
        }

        int marks
        {
            get 
            { 
                return ViewState["marks"] != null ? (int)ViewState["marks"] : 0; 
            }
            set 
            { 
                ViewState["marks"] = value; 
            }
        }

        protected void Page_Load(object sender, EventArgs ex)
        {
            if (Session["QuizID"] == null )
            {
                Response.Redirect("StudentQuiz.aspx");
            }
                if(Session["UserID"] == null)
            {
                Response.Redirect("StudentQuiz.aspx");
            }
              

            if (!IsPostBack)
            {
                LoadTheQuestions();
                ShowTheQuestion();
                SetTheTimer();
            }

            UpdateTheTimer();
        }

        // load Questions
        void LoadTheQuestions()
        {
            using (SqlConnection connect = new SqlConnection(connectionString))
            {
                string sqlQuery = " Select q.* " +
                                  " From Questions_t q " +
                                   " Inner JOIN QuizQuestions_t qq " +
                                   " on q.QuestionID = qq.QuestionID " +
                                   " Where qq.QuizID = @id" +
                                   "order by NEWID()";

                   

                SqlDataAdapter dataAdapter = new SqlDataAdapter(sqlQuery, connect);
                dataAdapter.SelectCommand.Parameters.AddWithValue("@id", Session["QuizID"]);

                questions = new DataTable();
                dataAdapter.Fill(questions);
            }
        }

        // Show Questions
        void ShowTheQuestion()
        {
            if (index >= questions.Rows.Count)
            {
                FinishQuiz();
                return;
            }

            lblQ.Text = questions.Rows[index]["QuestionText"].ToString();

            rblOptions.Items.Clear();
            rblOptions.Items.Add(new ListItem(questions.Rows[index]["OptionA"].ToString(), "A"));
            rblOptions.Items.Add(new ListItem(questions.Rows[index]["OptionB"].ToString(), "B"));
            rblOptions.Items.Add(new ListItem(questions.Rows[index]["OptionC"].ToString(), "C"));
            rblOptions.Items.Add(new ListItem(questions.Rows[index]["OptionD"].ToString(), "D"));

            rblOptions.ClearSelection();
        }

        // Next button
        protected void btnNext_Click(object sender, EventArgs e)
        {
            if (rblOptions.SelectedItem == null)
                return;

            string selected = rblOptions.SelectedValue;
            string correct = questions.Rows[index]["Correct"].ToString();
            int qID = Convert.ToInt32(questions.Rows[index]["QuestionID"]);

            int Marks = 0;

            if (selected == correct) 
            {
                marks++;
                Marks = 1;
            }

            using (SqlConnection connect = new SqlConnection(connectionString))
            {
                string sqlquery = "Insert into Answers_t " +
                               "(StudentID, QuizID, QuestionID, Correct, StudentAns, Marks) " +
                               "Values (@sid, @qid, @ques, @c, @s, @m)";

                SqlCommand command = new SqlCommand(sqlquery, connect);

                command.Parameters.AddWithValue("@sid", Session["UserID"]);
                command.Parameters.AddWithValue("@qid", Session["QuizID"]);
                command.Parameters.AddWithValue("@ques", qID);
                command.Parameters.AddWithValue("@c", correct);
                command.Parameters.AddWithValue("@s", selected);
                command.Parameters.AddWithValue("@m", Marks);

                connect.Open();
                command.ExecuteNonQuery();
            }
            index++;
            ShowTheQuestion();
        }

        // Timer Set
        void SetTheTimer()
        {
            int minutes = GetQuizTime();
            Session["EndTime"] = DateTime.Now.AddMinutes(minutes);
        }

        int GetQuizTime()
        {
            using (SqlConnection connect = new SqlConnection(connectionString))
            {
                string query = "SELECT TotalTime FROM Quiz_t WHERE QuizID=@id";
                SqlCommand command = new SqlCommand(query, connect);
                command.Parameters.AddWithValue("@id", Session["QuizID"]);

                connect.Open();
                return Convert.ToInt32(command.ExecuteScalar());
            }
        }

         //Timer Update
        void UpdateTheTimer()
        {
            if (Session["EndTime"] == null) 
                return;

            DateTime End = (DateTime)Session["EndTime"];
            TimeSpan TimeLeft = End - DateTime.Now;

            if (TimeLeft.TotalSeconds <= 0)
            {
                FinishQuiz();
                return;
            }

            lblTimer.Text = "Time Left: " +
                            TimeLeft.Minutes + "m " +
                            TimeLeft.Seconds + "s";
        }

        // Finish Quiz
        void FinishQuiz()
        {
            SaveResult();

            Session["QuizID"] = null;
            Response.Redirect("QuizResult.aspx");
        }

        // Save Result
        void SaveResult()
        {
            using (SqlConnection connect = new SqlConnection(connectionString))
            {
                string query = " INSERT INTO Result_t (StudentID, QuizID, Obtained, Total) " +
                                 " VALUES (@sid, @qid, @ob, @tot)";

                SqlCommand command = new SqlCommand(query, connect);
                command.Parameters.AddWithValue("@sid", Session["UserID"]);
                command.Parameters.AddWithValue("@qid", Session["QuizID"]);
                command.Parameters.AddWithValue("@ob", marks);
                command.Parameters.AddWithValue("@tot", questions.Rows.Count);

                connect.Open();
                command.ExecuteNonQuery();
            }
        }

        // Back Button
        protected void btnBack_Click(object sender, EventArgs e)
        {
            Response.Redirect("Dashboard.aspx");
        }
    }
}