using System;
using System.Configuration;
using System.Data.SqlClient;
using System.Collections.Generic;
using System.Web.Script.Serialization;

namespace PVFC
{
    public partial class Recommendation : System.Web.UI.Page
    {
        string connStr = ConfigurationManager.ConnectionStrings["PVFCConnectionString"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            Response.Clear();
            Response.ContentType = "application/json";

            List<int> recs = new List<int>();

            try
            {
                int productId = 0;

                if (!string.IsNullOrEmpty(Request.QueryString["pid"]))
                    productId = Convert.ToInt32(Request.QueryString["pid"]);

                using (SqlConnection con = new SqlConnection(connStr))
                {
                    con.Open();

                    string query = @"
                    SELECT TOP 5 ol2.Product_Id
                    FROM Order_line_t ol1
                    JOIN Order_line_t ol2 
                    ON ol1.Order_Id = ol2.Order_Id
                    WHERE ol1.Product_Id = @pid
                    AND ol2.Product_Id != @pid
                    GROUP BY ol2.Product_Id
                    ORDER BY COUNT(*) DESC";

                    SqlCommand cmd = new SqlCommand(query, con);
                    cmd.Parameters.AddWithValue("@pid", productId);

                    SqlDataReader dr = cmd.ExecuteReader();

                    while (dr.Read())
                    {
                        recs.Add(Convert.ToInt32(dr["Product_Id"]));
                    }
                }
            }
            catch
            {
                // return empty list instead of crashing
            }

            JavaScriptSerializer js = new JavaScriptSerializer();
            Response.Write(js.Serialize(recs));
            Response.End();
        }
    }
}