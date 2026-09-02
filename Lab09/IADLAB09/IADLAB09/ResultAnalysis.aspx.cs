using System;
using System.Data;
using System.Data.SqlClient;

namespace SurveySystem
{
    public partial class ResultAnalysis : System.Web.UI.Page
    {
        string connectionString = System.Configuration.ConfigurationManager.ConnectionStrings["SurveyDB"].ConnectionString;

        protected void Page_Load(object sender, EventArgs ex)
        {
            if (!IsPostBack)
                LoadSurveys();
        }

        void LoadSurveys()
        {
            using (SqlConnection connect = new SqlConnection(connectionString))
            {
                SqlDataAdapter dataAdapter = new SqlDataAdapter("SELECT * FROM Survey_t", connect);
                DataTable dataTable = new DataTable();
                dataAdapter.Fill(dataTable);

                ddlSurvey.DataSource = dataTable;
                ddlSurvey.DataTextField = "Title";
                ddlSurvey.DataValueField = "SurveyID";
                ddlSurvey.DataBind();
            }
        }

        protected void btnLoad_Click(object sender, EventArgs ex)
        {
            using (SqlConnection connect = new SqlConnection(connectionString))
            {
                string sqlQuery = "SELECT * FROM SurveyQuestions_t " +
                                     "WHERE SurveyID=@id";
                SqlDataAdapter dataAdapter = new SqlDataAdapter(sqlQuery, connect);

                dataAdapter.SelectCommand.Parameters.AddWithValue("@id", ddlSurvey.SelectedValue);

                DataTable dataTable = new DataTable();
                dataAdapter.Fill(dataTable);

                rptResults.DataSource = dataTable;
                rptResults.DataBind();
            }
        }

        
        public DataTable GetOptions(object qID)
        {
            using (SqlConnection connect = new SqlConnection(connectionString))
            {
                string sqlQuery = "SELECT * FROM SurveyOptions_t " +
                                  "WHERE QuestionID=@q";
                SqlDataAdapter dataAdapter = new SqlDataAdapter(sqlQuery , connect);

                dataAdapter.SelectCommand.Parameters.AddWithValue("@q", qID);

                DataTable dataTable = new DataTable();
                dataAdapter.Fill(dataTable);

                return dataTable;
            }
        }

        // Votes  Counting
        public int GetVotes(object qid, object option)
        {
            using (SqlConnection connect = new SqlConnection(connectionString))
            {
                string sqlQuery = "SELECT COUNT(*) " +
                                   "FROM SurveyAnswers_t " +
                                   "WHERE QuestionID=@q AND SelectedAnswer=@a";
                SqlCommand command = new SqlCommand(sqlQuery, connect);

                command.Parameters.AddWithValue("@q", qid);
                command.Parameters.AddWithValue("@a", option);

                connect.Open();
                int count = (int)command.ExecuteScalar();
                connect.Close();

                return count;
            }
        }
        protected void btnBack_Click(object sender, EventArgs e)
        {
            Response.Redirect("Dashboard.aspx");
        }
    }
}