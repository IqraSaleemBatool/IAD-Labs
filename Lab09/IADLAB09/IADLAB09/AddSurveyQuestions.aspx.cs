using System;
using System.Data;
using System.Data.SqlClient;

namespace SurveySystem
{
    public partial class AddSurveyQuestions : System.Web.UI.Page
    {
        string connectionString = System.Configuration.ConfigurationManager.ConnectionStrings["SurveyDB"].ConnectionString;

        protected void Page_Load(object sender, EventArgs ex)
        {
            if (!IsPostBack)
            {
                LoadSurveys();
                pnlMCQ.Visible = true;
                pnlTF.Visible = false;
            }
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

      
        protected void ddlType_SelectedIndexChanged(object sender, EventArgs ex)
        {
            if (ddlType.SelectedValue == "TF")
            {
                pnlMCQ.Visible = false;
                pnlTF.Visible = true;
            }
            else
            {
                pnlMCQ.Visible = true;
                pnlTF.Visible = false;
            }
        }

        protected void btnSave_Click(object sender, EventArgs ex)
        {
            if (txtQ.Text == "")
            {
                lblMsg.Text = "Enter Question!";
                return;
            }

            int QID;

            using (SqlConnection connect = new SqlConnection(connectionString))
            {
                connect.Open();
                string sqlquery = "Insert Into SurveyQuestions_t (SurveyID, QuestionText, QType) " +
                                        "Values (@s,@q,@t); SELECT SCOPE_IDENTITY();";

                // Insert  the Question
                SqlCommand command = new SqlCommand(sqlquery,connect);

                command.Parameters.AddWithValue("@s", ddlSurvey.SelectedValue);
                command.Parameters.AddWithValue("@q", txtQ.Text);
                command.Parameters.AddWithValue("@t", ddlType.SelectedValue);

                QID = Convert.ToInt32(command.ExecuteScalar());

                // MCQ's Options
                if (ddlType.SelectedValue == "MCQ")
                {
                    InsertOption(connect, QID, txtA.Text);
                    InsertOption(connect, QID, txtB.Text);
                    InsertOption(connect , QID, txtC.Text);
                }

                // TF Options (Auto)
                else if (ddlType.SelectedValue == "TF")
                {
                    InsertOption(connect, QID, "True");
                    InsertOption(connect, QID, "False");
                }
            }

            lblMsg.Text = "Question's Added Successfully!!!!";

            // Clear fields
            txtQ.Text = "";
            txtA.Text = "";
            txtB.Text = "";
            txtC.Text = "";
        }

        void InsertOption(SqlConnection connect, int qID, string Text)
        {
            SqlCommand command = new SqlCommand(
                "INSERT INTO SurveyOptions_t (QuestionID, OptionText) VALUES (@q,@o)", connect);

            command.Parameters.AddWithValue("@q", qID);
            command.Parameters.AddWithValue("@o", Text);
            command.ExecuteNonQuery();
        }

        // Bacck Button
        protected void btnBack_Click(object sender, EventArgs e)
        {
            Response.Redirect("Dashboard.aspx");
        }
    }
}