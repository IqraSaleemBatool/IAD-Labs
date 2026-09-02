using System;
using System.Data;
using System.Data.SqlClient;

namespace SurveySystem
{
    public partial class SurveyList : System.Web.UI.Page
    {
        string cnnectionString = System.Configuration.ConfigurationManager.ConnectionStrings["SurveyDB"].ConnectionString;

        protected void Page_Load(object sender, EventArgs ex)
        {
            if (!IsPostBack)
                LoadSurveys();
        }

        void LoadSurveys()
        {
            using (SqlConnection connect = new SqlConnection(cnnectionString))
            {
                string sqlQuery= "SELECT * FROM Survey_t";
                SqlDataAdapter dataAdapter = new SqlDataAdapter(sqlQuery, connect);
                DataTable dataTable = new DataTable();
                dataAdapter.Fill(dataTable);

                GridView1.DataSource = dataTable;
                GridView1.DataBind();
            }
        }

        protected void GridView1_RowCommand(object sender, System.Web.UI.WebControls.GridViewCommandEventArgs ex)
        {
            int Index = Convert.ToInt32(ex.CommandArgument);
            Session["SurveyID"] = GridView1.Rows[Index].Cells[0].Text;

            Response.Redirect("TakeSurvey.aspx");
        }

        protected void btnBack_Click(object sender, EventArgs e)
        {
            Response.Redirect("Dashboard.aspx");
        }
    }
}