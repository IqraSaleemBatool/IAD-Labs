using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI.WebControls;

namespace SurveySystem
{
    public partial class TakeSurvey : System.Web.UI.Page
    {
        string connectionstring= System.Configuration.ConfigurationManager.ConnectionStrings["SurveyDB"].ConnectionString;

        protected void Page_Load(object sender, EventArgs ex)
        {
            if (!IsPostBack)
                LoadTheQuestions();
        }

        void LoadTheQuestions()
        {
            using (SqlConnection connect = new SqlConnection(connectionstring))
            {
                string sqlquery = "SELECT * " +
                                 "FROM SurveyQuestions_t " +
                                 "WHERE SurveyID=@id";
                SqlDataAdapter dataAdapter = new SqlDataAdapter(sqlquery, connect);

                dataAdapter.SelectCommand.Parameters.AddWithValue("@id", Session["SurveyID"]);

                DataTable dataTable = new DataTable();
                dataAdapter.Fill(dataTable);

                rptQuestions.DataSource = dataTable;
                rptQuestions.DataBind();
            }
        }

        // load option for each question
        public DataTable GetOptions(object qID)
        {
            using (SqlConnection connect = new SqlConnection(connectionstring))
            {
                string sqlquery = "SELECT * FROM SurveyOptions_t WHERE QuestionID=@q";
                SqlDataAdapter dataAdapter = new SqlDataAdapter(sqlquery, connect);

                dataAdapter.SelectCommand.Parameters.AddWithValue("@q", qID);

                DataTable dataTable = new DataTable();
                dataAdapter.Fill(dataTable);

                return dataTable;
            }
        }
        protected void btnBack_Click(object sender, EventArgs e)
        {
            Response.Redirect("Dashboard.aspx");
        }
        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            int ResponseID;

            using (SqlConnection connect = new SqlConnection(connectionstring))
            {
                connect.Open();

                string sqlQuery = "INSERT INTO SurveyResponse_t (SurveyID, UserID) VALUES (@s,@u); SELECT SCOPE_IDENTITY();";
                SqlCommand command = new SqlCommand(sqlQuery , connect);

                command.Parameters.AddWithValue("@s", Session["SurveyID"]);
                command.Parameters.AddWithValue("@u", Session["UserID"]);

                ResponseID = Convert.ToInt32(command.ExecuteScalar());

                // looping through questions
                foreach (RepeaterItem item in rptQuestions.Items)
                {
                    HiddenField HD = (HiddenField)item.FindControl("hdQID");
                    RadioButtonList rbl = (RadioButtonList)item.FindControl("rblOptions");

                    if (rbl.SelectedValue != "")
                    {
                        SqlCommand answer = new SqlCommand(
                            "INSERT INTO SurveyAnswers_t (ResponseID, QuestionID, SelectedAnswer) VALUES (@r,@q,@a)", connect);

                        answer.Parameters.AddWithValue("@r", ResponseID);
                        answer.Parameters.AddWithValue("@q", HD.Value);
                        answer.Parameters.AddWithValue("@a", rbl.SelectedValue);

                        answer.ExecuteNonQuery();
                    }
                }
            }

            lblMsg.Text = "Survey Submitted Successfully!";
        }
    }
}