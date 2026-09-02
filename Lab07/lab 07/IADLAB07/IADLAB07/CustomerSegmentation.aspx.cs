using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;

public partial class CustomerSegmentation : System.Web.UI.Page
{
    string connStr = ConfigurationManager.ConnectionStrings["PVFCConnectionString"].ConnectionString;

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            LoadAllSegments();
            lblGeneratedDate.Text = DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss");
        }
    }

    protected void btnRefresh_Click(object sender, EventArgs e)
    {
        LoadAllSegments();
        lblGeneratedDate.Text = DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss");
    }

    protected void btnBack_Click(object sender, EventArgs e)
    {
        Response.Redirect("Default.aspx");
    }

    private void LoadAllSegments()
    {
        try
        {
            using (SqlConnection con = new SqlConnection(connStr))
            {
                con.Open();

                // 1. premium customer who will Spent > $2000
                string sqlPremium = "Select C.Customer_Id AS [ID],"+
                        " C.Customer_Name AS [Customer Name], " +
                        "C.Customer_City AS [City]," +
                        "ISNULL(SUM(P.Standard_Price * OL.Ordered_Quantity), 0) AS [Total Spent]," +
                        "COUNT(DISTINCT O.Order_Id) AS [Orders] " +
                    "from CUSTOMER_t C "+
                    "LEFT JOIN Users U ON C.Customer_Id = U.Customer_Id "+
                    "LEFT JOIN Orders_t O ON U.UserID = O.UserID "+
                    "LEFT JOIN Order_line_t OL ON O.Order_Id = OL.Order_Id " +
                    "LEFT JOIN PRODUCT_t P ON OL.Product_Id = P.Product_Id " +
                    "GROUP BY C.Customer_Id, C.Customer_Name, C.Customer_City " +
                    "HAVING ISNULL(SUM(P.Standard_Price * OL.Ordered_Quantity), 0) > 2000 "+
                    "ORDER BY [Total Spent] DESC"; 
                LoadData(con, sqlPremium, gvPremium);

                // 2. Frequent Customers places Orders > 3
                string sqlFrequent = " SELECT C.Customer_Id AS [ID], "+
                        "C.Customer_Name AS [Customer Name], "+
                        "C.Customer_City AS [City], "+
                        "COUNT(DISTINCT O.Order_Id) AS [Orders], "+
                        "ISNULL(SUM(P.Standard_Price * OL.Ordered_Quantity), 0) AS [Total Spent] "+
                    "FROM CUSTOMER_t C "+
                    "LEFT JOIN Users U ON C.Customer_Id = U.Customer_Id "+
                    "LEFT JOIN Orders_t O ON U.UserID = O.UserID "+
                    "LEFT JOIN Order_line_t OL ON O.Order_Id = OL.Order_Id "+
                    "LEFT JOIN PRODUCT_t P ON OL.Product_Id = P.Product_Id "+
                    "GROUP BY C.Customer_Id, C.Customer_Name, C.Customer_City "+
                    "HAVING COUNT(DISTINCT O.Order_Id) > 3 " +
                    "ORDER BY [Orders] DESC";
                LoadData(con, sqlFrequent, gvFrequent);

                // 3. bulk buyers have Avg Order Quantity > 3
                string sqlBulk = "SELECT C.Customer_Id AS [ID], "+
                        "C.Customer_Name AS [Customer Name], "+
                        "C.Customer_City AS [City], "+
                        "CAST(AVG(CAST(OL.Ordered_Quantity AS FLOAT)) AS DECIMAL(10,2)) AS [Avg Quantity], "+
                        "SUM(OL.Ordered_Quantity) AS [Total Items] "+
                    "FROM CUSTOMER_t C "+
                    "INNER JOIN Users U ON C.Customer_Id = U.Customer_Id "+
                    "INNER JOIN Orders_t O ON U.UserID = O.UserID "+
                    "INNER JOIN Order_line_t OL ON O.Order_Id = OL.Order_Id "+
                    "GROUP BY C.Customer_Id, C.Customer_Name, C.Customer_City "+
                    "HAVING AVG(CAST(OL.Ordered_Quantity AS FLOAT)) > 3 "+
                    "ORDER BY [Avg Quantity] DESC"; 
                LoadData(con, sqlBulk, gvBulk);

                // 4. OCCASIONAL CUSTOMERS palces order <= 1 
                string sqlOccasional = "SELECT  C.Customer_Id AS [ID], "+
                        "C.Customer_Name AS [Customer Name], "+
                        "C.Customer_City AS [City], "+
                        "ISNULL(COUNT(DISTINCT O.Order_Id), 0) AS [Orders], "+
                        "ISNULL(SUM(P.Standard_Price * OL.Ordered_Quantity), 0) AS [Total Spent] "+
                    "FROM CUSTOMER_t C "+
                    "LEFT JOIN Users U ON C.Customer_Id = U.Customer_Id "+
                    "LEFT JOIN Orders_t O ON U.UserID = O.UserID "+
                    "LEFT JOIN Order_line_t OL ON O.Order_Id = OL.Order_Id "+
                    "LEFT JOIN PRODUCT_t P ON OL.Product_Id = P.Product_Id "+
                    "GROUP BY C.Customer_Id, C.Customer_Name, C.Customer_City "+
                    "HAVING ISNULL(COUNT(DISTINCT O.Order_Id), 0) <= 1 "+
                    "ORDER BY [Orders] DESC";
                LoadData(con, sqlOccasional, gvOccasional);

                // 5. low value customers who will Spent < $500
                string sqlLow = "SELECT C.Customer_Id AS [ID], "+
                        "C.Customer_Name AS [Customer Name], "+
                        "C.Customer_City AS [City], "+
                        "ISNULL(SUM(P.Standard_Price * OL.Ordered_Quantity), 0) AS [Total Spent], "+
                        "ISNULL(COUNT(DISTINCT O.Order_Id), 0) AS [Orders] "+
                    "FROM CUSTOMER_t C "+
                    "LEFT JOIN Users U ON C.Customer_Id = U.Customer_Id "+
                    "LEFT JOIN Orders_t O ON U.UserID = O.UserID "+
                    "LEFT JOIN Order_line_t OL ON O.Order_Id = OL.Order_Id "+
                    "LEFT JOIN PRODUCT_t P ON OL.Product_Id = P.Product_Id "+
                    "GROUP BY C.Customer_Id, C.Customer_Name, C.Customer_City "+
                    "HAVING ISNULL(SUM(P.Standard_Price * OL.Ordered_Quantity), 0) < 500 "+
                    "ORDER BY [Total Spent] ASC";
                LoadData(con, sqlLow, gvLow);

                // 6. inactive customers places No orders in 6 months
                string sqlInactive = "SELECT C.Customer_Id AS [ID], "+
                        "C.Customer_Name AS [Customer Name], "+
                        "C.Customer_City AS [City], "+
                        "CASE "+
                             "WHEN MAX(O.Order_Date) IS NULL THEN 'Never Ordered' "+
                            "ELSE CONVERT(VARCHAR, MAX(O.Order_Date), 106) "+
                        "END AS [Last Order], "+
                        "CASE  "+
                            "WHEN MAX(O.Order_Date) IS NULL THEN 999 "+
                            "ELSE DATEDIFF(MONTH, MAX(O.Order_Date), GETDATE()) "+
                        "END AS [Months Inactive] "+
                    "FROM CUSTOMER_t C "+
                    "LEFT JOIN Users U ON C.Customer_Id = U.Customer_Id "+
                    "LEFT JOIN Orders_t O ON U.UserID = O.UserID "+
                    "GROUP BY C.Customer_Id, C.Customer_Name, C.Customer_City "+
                    "HAVING MAX(O.Order_Date) IS NULL  "+
                        "OR MAX(O.Order_Date) < DATEADD(MONTH, -6, GETDATE()) "+
                    "ORDER BY [Months Inactive] DESC";
                LoadData(con, sqlInactive, gvInactive);

                // 7. loyal customers are (Frequent + Premium)
                string sqlLoyal = "SELECT C.Customer_Id AS [ID], "+
                        "C.Customer_Name AS [Customer Name], "+
                        "C.Customer_City AS [City], "+
                         "COUNT(DISTINCT O.Order_Id) AS [Orders], "+
                        "ISNULL(SUM(P.Standard_Price * OL.Ordered_Qua ntity), 0) AS [Total Spent] "+
                    "FROM CUSTOMER_t C "+
                    "LEFT JOIN Users U ON C.Customer_Id = U.Customer_Id "+
                     "LEFT JOIN Orders_t O ON U.UserID = O.UserID "+
                    "LEFT JOIN Order_line_t OL ON O.Order_Id = OL.Order_Id "+
                    "LEFT JOIN PRODUCT_t P ON OL.Product_Id = P.Product_Id "+
                     "GROUP BY C.Customer_Id, C.Customer_Name, C.Customer_City "+
                    "HAVING COUNT(DISTINCT O.Order_Id) > 3  "+
                        "AND ISNULL(SUM(P.Standard_Price * OL.Ordered_Quantity), 0) > 2000 "+
                    "ORDER BY [Total Spent] DESC";
                LoadData(con, sqlLoyal, gvLoyal);

                UpdateStatistics(con);
            }
        }
        catch (Exception ex)
        {
            Response.Write("<div style='color:red; padding:10px;'>Error: " + ex.Message + "</div>");
        }
    }

    private void UpdateStatistics(SqlConnection con)
    {
        try
        {
            SqlCommand cmdTotal = new SqlCommand("select count(*) from CUSTOMER_t", con);
            int totalCustomers = Convert.ToInt32(cmdTotal.ExecuteScalar());
            lblTotalCustomers.Text = totalCustomers.ToString();

            SqlCommand cmdActive = new SqlCommand(@"
                SELECT COUNT(DISTINCT C.Customer_Id) 
                FROM CUSTOMER_t C
                INNER JOIN Users U ON C.Customer_Id = U.Customer_Id
                INNER JOIN Orders_t O ON U.UserID = O.UserID", con);
            int activeCustomers = Convert.ToInt32(cmdActive.ExecuteScalar());
            lblActiveCustomers.Text = activeCustomers.ToString();
            lblInactiveCustomers.Text = (totalCustomers - activeCustomers).ToString();

            SqlCommand cmdRevenue = new SqlCommand(@"
                SELECT ISNULL(SUM(P.Standard_Price * OL.Ordered_Quantity), 0)
                FROM Order_line_t OL
                INNER JOIN PRODUCT_t P ON OL.Product_Id = P.Product_Id", con);
            decimal totalRevenue = Convert.ToDecimal(cmdRevenue.ExecuteScalar());
            lblTotalRevenue.Text = totalRevenue.ToString("N2");
        }
        catch (Exception ex)
        {
            System.Diagnostics.Debug.WriteLine("Stats error: " + ex.Message);
        }
    }

    private void LoadData(SqlConnection con, string query, System.Web.UI.WebControls.GridView gv)
    {
        try
        {
            SqlDataAdapter da = new SqlDataAdapter(query, con);
            DataTable dt = new DataTable();
            da.Fill(dt);
            gv.DataSource = dt;
            gv.DataBind();
        }
        catch (Exception ex)
        {
            System.Diagnostics.Debug.WriteLine("Load error: " + ex.Message);
        }
    }
}