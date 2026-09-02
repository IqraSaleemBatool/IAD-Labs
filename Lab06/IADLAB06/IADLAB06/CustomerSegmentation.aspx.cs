using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;

namespace PVFC
{

public partial class CustomerSegmentation : System.Web.UI.Page
{
    string connectionString = ConfigurationManager.ConnectionStrings["PVFCConnectionString"].ConnectionString;

    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["Role"] == null || Session["Role"].ToString() != "Admin")
        {
            Response.Write("Access Denied!");
            Response.End();
        }

        if (!IsPostBack)
        {
            LoadAll();
        }
    }

   
    private void LoadAll()
    {
        LoadSegment("Select C.Customer_Id AS [ID]," +
                        " C.Customer_Name AS [Customer Name], " +
                        "C.Customer_City AS [City]," +
                        "ISNULL(SUM(P.Standard_Price * OL.Ordered_Quantity), 0) AS [Total Spent]," +
                        "COUNT(DISTINCT O.Order_Id) AS [Orders] " +
                    "from CUSTOMER_t C " +
                    "LEFT JOIN Users U ON C.Customer_Id = U.Customer_Id " +
                    "LEFT JOIN Orders_t O ON U.UserID = O.UserID " +
                    "LEFT JOIN Order_line_t OL ON O.Order_Id = OL.Order_Id " +
                    "LEFT JOIN PRODUCT_t P ON OL.Product_Id = P.Product_Id " +
                    "GROUP BY C.Customer_Id, C.Customer_Name, C.Customer_City " +
                    "HAVING ISNULL(SUM(P.Standard_Price * OL.Ordered_Quantity), 0) > 2000 " +
                    "ORDER BY [Total Spent] DESC",
            gvPremium);

        LoadSegment( " SELECT C.Customer_Id AS[ID], "+
                        "C.Customer_Name AS [Customer Name], " +
                        "C.Customer_City AS [City], " +
                        "COUNT(DISTINCT O.Order_Id) AS [Orders], " +
                        "ISNULL(SUM(P.Standard_Price * OL.Ordered_Quantity), 0) AS [Total Spent] " +
                    "FROM CUSTOMER_t C " +
                    "LEFT JOIN Users U ON C.Customer_Id = U.Customer_Id " +
                    "LEFT JOIN Orders_t O ON U.UserID = O.UserID " +
                    "LEFT JOIN Order_line_t OL ON O.Order_Id = OL.Order_Id " +
                    "LEFT JOIN PRODUCT_t P ON OL.Product_Id = P.Product_Id " +
                    "GROUP BY C.Customer_Id, C.Customer_Name, C.Customer_City " +
                    "HAVING COUNT(DISTINCT O.Order_Id) >3  AND  isnull(SUM(P.Standard_Price * OL.Ordered_Quantity),0) <=2000  " +
                    "ORDER BY [Orders] DESC",
            gvFrequent);

        LoadSegment("SELECT C.Customer_Id AS [ID], " +
                        "C.Customer_Name AS [Customer Name], " +
                        "C.Customer_City AS [City], " +
                        "CAST(AVG(CAST(OL.Ordered_Quantity AS FLOAT)) AS DECIMAL(10,2)) AS [Avg Quantity], " +
                        "SUM(OL.Ordered_Quantity) AS [Total Items] " +
                    "FROM CUSTOMER_t C " +
                    "INNER JOIN Users U ON C.Customer_Id = U.Customer_Id " +
                    "INNER JOIN Orders_t O ON U.UserID = O.UserID " +
                    "INNER JOIN Order_line_t OL ON O.Order_Id = OL.Order_Id " +
                    "GROUP BY C.Customer_Id, C.Customer_Name, C.Customer_City " +
                    "HAVING AVG(CAST(OL.Ordered_Quantity AS FLOAT)) > 3 " +
                    "ORDER BY [Avg Quantity] DESC",
            gvBulk);

        LoadSegment("SELECT  C.Customer_Id AS [ID], " +
                        "C.Customer_Name AS [Customer Name], " +
                        "C.Customer_City AS [City], " +
                        "ISNULL(COUNT(DISTINCT O.Order_Id), 0) AS [Orders], " +
                        "ISNULL(SUM(P.Standard_Price * OL.Ordered_Quantity), 0) AS [Total Spent] " +
                    "FROM CUSTOMER_t C " +
                    "LEFT JOIN Users U ON C.Customer_Id = U.Customer_Id " +
                    "LEFT JOIN Orders_t O ON U.UserID = O.UserID " +
                    "LEFT JOIN Order_line_t OL ON O.Order_Id = OL.Order_Id " +
                    "LEFT JOIN PRODUCT_t P ON OL.Product_Id = P.Product_Id " +
                    "GROUP BY C.Customer_Id, C.Customer_Name, C.Customer_City " +
                    "HAVING ISNULL(COUNT(DISTINCT O.Order_Id), 0) <= 1 " +
                    "ORDER BY [Orders] DESC",
            gvOccasional);

        LoadSegment("SELECT C.Customer_Id AS [ID], " +
                        "C.Customer_Name AS [Customer Name], " +
                        "C.Customer_City AS [City], " +
                        "ISNULL(SUM(P.Standard_Price * OL.Ordered_Quantity), 0) AS [Total Spent], " +
                        "ISNULL(COUNT(DISTINCT O.Order_Id), 0) AS [Orders] " +
                    "FROM CUSTOMER_t C " +
                    "LEFT JOIN Users U ON C.Customer_Id = U.Customer_Id " +
                    "LEFT JOIN Orders_t O ON U.UserID = O.UserID " +
                    "LEFT JOIN Order_line_t OL ON O.Order_Id = OL.Order_Id " +
                    "LEFT JOIN PRODUCT_t P ON OL.Product_Id = P.Product_Id " +
                    "GROUP BY C.Customer_Id, C.Customer_Name, C.Customer_City " +
                    "HAVING ISNULL(SUM(P.Standard_Price * OL.Ordered_Quantity), 0) < 500 " +
                    "ORDER BY [Total Spent] ASC",
            gvLow);

        LoadSegment("SELECT C.Customer_Id AS [ID], " +
                        "C.Customer_Name AS [Customer Name], " +
                        "C.Customer_City AS [City], " +
                        "CASE " +
                             "WHEN MAX(O.Order_Date) IS NULL THEN 'Never Ordered' " +
                            "ELSE CONVERT(VARCHAR, MAX(O.Order_Date), 106) " +
                        "END AS [Last Order], " +
                        "CASE  " +
                            "WHEN MAX(O.Order_Date) IS NULL THEN 999 " +
                            "ELSE DATEDIFF(MONTH, MAX(O.Order_Date), GETDATE()) " +
                        "END AS [Months Inactive] " +
                    "FROM CUSTOMER_t C " +
                    "LEFT JOIN Users U ON C.Customer_Id = U.Customer_Id " +
                    "LEFT JOIN Orders_t O ON U.UserID = O.UserID " +
                    "GROUP BY C.Customer_Id, C.Customer_Name, C.Customer_City " +
                    "HAVING MAX(O.Order_Date) IS NULL  " +
                        "OR MAX(O.Order_Date) < DATEADD(MONTH, -6, GETDATE()) " +
                    "ORDER BY [Months Inactive] DESC",
            gvInactive);
    }

    private void LoadSegment(string query, System.Web.UI.WebControls.GridView gv)
    {
        using (SqlConnection connect = new SqlConnection(connectionString))
        {
            SqlDataAdapter dataAdapter = new SqlDataAdapter(query, connect);
            DataTable dataTable = new DataTable();
            dataAdapter.Fill(dataTable);
            gv.DataSource = dataTable;
            gv.DataBind();
        }
    }

  
    private void ShowMessage(System.Web.UI.WebControls.GridView gv,
                             System.Web.UI.WebControls.Label lbl,
                             string message)
    {
        int count = gv.Rows.Count;

        if (count > 0)
            lbl.Text = $"{message} ({count} customers)";
        else
            lbl.Text = "No customers found.";
    }

    protected void btnRefresh_Click(object sender, EventArgs e)
    {
            LoadAll();
    }

        protected void btnPremium_Click(object sender, EventArgs e)
    {
        ShowMessage(gvPremium, lblPremium, "15% Discount Sent To Premium Customers");
    }

    protected void btnFrequent_Click(object sender, EventArgs e)
    {
        ShowMessage(gvFrequent, lblFrequent, "Loyalty Points Sent To Frequent Customers");
    }

    protected void btnBulk_Click(object sender, EventArgs e)
    {
        ShowMessage(gvBulk, lblBulk, "30% Bulk Discount Sent");
    }

    protected void btnOccasional_Click(object sender, EventArgs e)
    {
        ShowMessage(gvOccasional, lblOccasional, "Special Offer Sent To Occasional Customers");
    }

    protected void btnLow_Click(object sender, EventArgs e)
    {
        ShowMessage(gvLow, lblLow, "Free Shipping Offer Sent");
    }

    protected void btnInactive_Click(object sender, EventArgs e)
    {
        ShowMessage(gvInactive, lblInactive, "Welcome Back Discount Sent");
    }

    protected void btnBack_Click(object sender, EventArgs e)
    {
        Response.Redirect("AdminDashboard.aspx");
    }
}
}