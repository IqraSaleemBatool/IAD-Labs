using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;

namespace PVFC
{
    public partial class DemandForecast : BasePage
    {
        string connectionString = ConfigurationManager.ConnectionStrings["PVFCConnectionString"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            
            CheckAccess(new string[] { "Admin", "Manager" });

            if (!IsPostBack)
            {
                LoadForecast();
            }
        }

        private void LoadForecast()
        {
            using (SqlConnection connect = new SqlConnection(connectionString))
            {
                string sqlquery = "SELECT " +
                  "p.Product_Id, " +
                  "p.Product_Description, " +
                  "COUNT(*) AS DemandScore, " +

                  "CASE " +
                  "WHEN COUNT(*) >= 20 THEN 'Urgent Restock' " +
                  "WHEN COUNT(*) >= 10 THEN 'Increase Stock' " +
                  "WHEN COUNT(*) >= 5 THEN 'Moderate Demand' " +
                  "ELSE 'Low Demand' " +
                  "END AS Action " +

                  "FROM Order_line_t ol " +
                  "JOIN PRODUCT_t p ON ol.Product_Id = p.Product_Id " +

                  "GROUP BY p.Product_Id, p.Product_Description " +
                  "ORDER BY DemandScore DESC";
                SqlDataAdapter dataAdapter = new SqlDataAdapter(sqlquery, connect);
                DataTable dataTable = new DataTable();
                dataAdapter.Fill(dataTable);

                gvForecast.DataSource = dataTable;
                gvForecast.DataBind();
            }
        }

        protected void btnBack_Click(object sender, EventArgs e)
        {
            RedirectToDashboard();
        }
    }
}