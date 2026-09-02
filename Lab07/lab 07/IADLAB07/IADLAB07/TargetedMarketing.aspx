<%@ Page Language="C#" AutoEventWireup="true" %>

<!DOCTYPE html>
<html>
<head runat="server">
    <title>Targeted Marketing</title>
    <style>
        body { font-family: Arial; margin: 20px; background: #f5f5f5; }
        .container { max-width: 1000px; margin: auto; background: white; padding: 20px; border: 1px solid #ddd; }
        h2 { color: #333; border-bottom: 2px solid #4CAF50; padding-bottom: 10px; }
        .segment { margin-bottom: 20px; padding: 15px; border: 1px solid #ddd; background: #fafafa; }
        .segment h3 { margin: 0 0 10px 0; color: #4CAF50; }
        .btn { padding: 8px 15px; margin: 5px; cursor: pointer; border: none; background: #4CAF50; color: white; }
        .btn-back { background: #666; }
        .message { padding: 10px; margin: 10px 0; }
        .success { background: #e8f5e9; border: 1px solid #4CAF50; color: #2e7d32; }
        table { width: 100%; border-collapse: collapse; margin-top: 10px; }
        th { background: #f2f2f2; padding: 8px; text-align: left; border: 1px solid #ddd; }
        td { padding: 8px; border: 1px solid #ddd; }
        .button-group { text-align: center; margin-top: 20px; }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="container">
            <h2> Targeted Marketing</h2>
            
            <!-- Royal Customers -->
            <div class="segment">
                <h3> Royal Customers (Premium + Frequent)</h3>
                <p>Offer: Complimentary Gift + 25% Discount + Thank You Message</p>
                <asp:Button ID="btnRoyal" runat="server" Text="Send to Royal Customers" CssClass="btn" OnClick="btnRoyal_Click" />
                <asp:Label ID="lblRoyal" runat="server" />
                <asp:GridView ID="gvRoyal" runat="server" AutoGenerateColumns="True" Width="100%" EmptyDataText="No royal customers" />
            </div>
            
            <!-- Premium Customers -->
            <div class="segment">
                <h3> Premium Customers (Spent > $2000)</h3>
                <p>Offer: 15% Discount + VIP Access</p>
                <asp:Button ID="btnPremium" runat="server" Text="Send to Premium Customers" CssClass="btn" OnClick="btnPremium_Click" />
                <asp:Label ID="lblPremium" runat="server" />
                <asp:GridView ID="gvPremium" runat="server" AutoGenerateColumns="True" Width="100%" EmptyDataText="No premium customers" />
            </div>
            
            <!-- Frequent Customers -->
            <div class="segment">
                <h3> Frequent Customers (Orders > 3)</h3>
                <p>Offer: Loyalty Points + Buy 3 Get 1 Free</p>
                <asp:Button ID="btnFrequent" runat="server" Text="Send to Frequent Customers" CssClass="btn" OnClick="btnFrequent_Click" />
                <asp:Label ID="lblFrequent" runat="server" />
                <asp:GridView ID="gvFrequent" runat="server" AutoGenerateColumns="True" Width="100%" EmptyDataText="No frequent customers" />
            </div>
            
            <!-- Inactive Customers -->
            <div class="segment">
                <h3> Inactive Customers (No orders in 6 months)</h3>
                <p>Offer: 20% Welcome Back Discount</p>
                <asp:Button ID="btnInactive" runat="server" Text="Send to Inactive Customers" CssClass="btn" OnClick="btnInactive_Click" />
                <asp:Label ID="lblInactive" runat="server" />
                <asp:GridView ID="gvInactive" runat="server" AutoGenerateColumns="True" Width="100%" EmptyDataText="No inactive customers" />
            </div>
            
            <!-- Low Value Customers -->
            <div class="segment">
                <h3> Low Value Customers (Spent < $500)</h3>
                <p>Offer: Free Shipping + First Purchase Discount</p>
                <asp:Button ID="btnLow" runat="server" Text="Send to Low Value Customers" CssClass="btn" OnClick="btnLow_Click" />
                <asp:Label ID="lblLow" runat="server" />
                <asp:GridView ID="gvLow" runat="server" AutoGenerateColumns="True" Width="100%" EmptyDataText="No low value customers" />
            </div>
            
            <!-- Bulk Buyers -->
            <div class="segment">
                <h3> Bulk Buyers (Avg Quantity > 3)</h3>
                <p>Offer: 30% Volume Discount + Wholesale Pricing</p>
                <asp:Button ID="btnBulk" runat="server" Text="Send to Bulk Buyers" CssClass="btn" OnClick="btnBulk_Click" />
                <asp:Label ID="lblBulk" runat="server" />
                <asp:GridView ID="gvBulk" runat="server" AutoGenerateColumns="True" Width="100%" EmptyDataText="No bulk buyers" />
            </div>
            
            <div class="button-group">
                <asp:Button ID="btnBack" runat="server" Text="Back To DashBoard" CssClass="btn btn-back" OnClick="btnBack_Click" />
            </div>
        </div>
    </form>

    <script runat="server">
        string connentionString = System.Configuration.ConfigurationManager.ConnectionStrings["PVFCConnectionString"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadCustomers();
            }
        }

        private void LoadCustomers()
        {
            LoadRoyal();
            LoadPremium();
            LoadFrequent();
            LoadInactive();
            LoadLowValue();
            LoadBulk();
        }

        private void LoadRoyal()
        {
            string sql = @"
                SELECT C.Customer_Name, C.Customer_City, 
                       COUNT(O.Order_Id) AS Orders,
                       SUM(P.Standard_Price * OL.Ordered_Quantity) AS TotalSpent
                FROM CUSTOMER_t C
                JOIN Users U ON C.Customer_Id = U.Customer_Id
                JOIN Orders_t O ON U.UserID = O.UserID
                JOIN Order_line_t OL ON O.Order_Id = OL.Order_Id
                JOIN PRODUCT_t P ON OL.Product_Id = P.Product_Id
                GROUP BY C.Customer_Name, C.Customer_City
                HAVING COUNT(O.Order_Id) > 3 AND SUM(P.Standard_Price * OL.Ordered_Quantity) > 2000";
            LoadData(sql, gvRoyal);
        }

        private void LoadPremium()
        {
            string sql = @"
                SELECT C.Customer_Name, C.Customer_City, 
                       SUM(P.Standard_Price * OL.Ordered_Quantity) AS TotalSpent
                FROM CUSTOMER_t C
                JOIN Users U ON C.Customer_Id = U.Customer_Id
                JOIN Orders_t O ON U.UserID = O.UserID
                JOIN Order_line_t OL ON O.Order_Id = OL.Order_Id
                JOIN PRODUCT_t P ON OL.Product_Id = P.Product_Id
                GROUP BY C.Customer_Name, C.Customer_City
                HAVING SUM(P.Standard_Price * OL.Ordered_Quantity) > 2000";
            LoadData(sql, gvPremium);
        }

        private void LoadFrequent()
        {
            string sql = @"
                SELECT C.Customer_Name, C.Customer_City, COUNT(O.Order_Id) AS Orders
                FROM CUSTOMER_t C
                JOIN Users U ON C.Customer_Id = U.Customer_Id
                JOIN Orders_t O ON U.UserID = O.UserID
                GROUP BY C.Customer_Name, C.Customer_City
                HAVING COUNT(O.Order_Id) > 3";
            LoadData(sql, gvFrequent);
        }

        private void LoadInactive()
        {
            string sql = @"
                SELECT C.Customer_Name, C.Customer_City, MAX(O.Order_Date) AS LastOrder
                FROM CUSTOMER_t C
                JOIN Users U ON C.Customer_Id = U.Customer_Id
                LEFT JOIN Orders_t O ON U.UserID = O.UserID
                GROUP BY C.Customer_Name, C.Customer_City
                HAVING MAX(O.Order_Date) < DATEADD(MONTH, -6, GETDATE()) OR MAX(O.Order_Date) IS NULL";
            LoadData(sql, gvInactive);
        }

        private void LoadLowValue()
        {
            string sql = @"
                SELECT C.Customer_Name, C.Customer_City, 
                       ISNULL(SUM(P.Standard_Price * OL.Ordered_Quantity), 0) AS TotalSpent
                FROM CUSTOMER_t C
                JOIN Users U ON C.Customer_Id = U.Customer_Id
                LEFT JOIN Orders_t O ON U.UserID = O.UserID
                LEFT JOIN Order_line_t OL ON O.Order_Id = OL.Order_Id
                LEFT JOIN PRODUCT_t P ON OL.Product_Id = P.Product_Id
                GROUP BY C.Customer_Name, C.Customer_City
                HAVING ISNULL(SUM(P.Standard_Price * OL.Ordered_Quantity), 0) < 500";
            LoadData(sql, gvLow);
        }

        private void LoadBulk()
        {
            string sql = @"
                SELECT C.Customer_Name, C.Customer_City, 
                       AVG(CAST(OL.Ordered_Quantity AS FLOAT)) AS AvgQuantity
                FROM CUSTOMER_t C
                JOIN Users U ON C.Customer_Id = U.Customer_Id
                JOIN Orders_t O ON U.UserID = O.UserID
                JOIN Order_line_t OL ON O.Order_Id = OL.Order_Id
                GROUP BY C.Customer_Name, C.Customer_City
                HAVING AVG(CAST(OL.Ordered_Quantity AS FLOAT)) > 3";
            LoadData(sql, gvBulk);
        }

        protected void btnRoyal_Click(object sender, EventArgs e)
        {
            int count = gvRoyal.Rows.Count;
            if (count > 0)
                lblRoyal.Text = $" Offer sent to {count} Royal customers! Gift via courier + 25% discount";
            else
                lblRoyal.Text = " No royal customers found.";
        }

        protected void btnPremium_Click(object sender, EventArgs e)
        {
            int count = gvPremium.Rows.Count;
            lblPremium.Text = count > 0 ? $" 15% discount sent to {count} Premium customers!" : " No premium customers found.";
        }

        protected void btnFrequent_Click(object sender, EventArgs e)
        {
            int count = gvFrequent.Rows.Count;
            lblFrequent.Text = count > 0 ? $" Loyalty points offer sent to {count} Frequent customers!" : " No frequent customers found.";
        }

        protected void btnInactive_Click(object sender, EventArgs e)
        {
            int count = gvInactive.Rows.Count;
            lblInactive.Text = count > 0 ? $" 20% welcome back discount sent to {count} Inactive customers!" : " No inactive customers found.";
        }

        protected void btnLow_Click(object sender, EventArgs e)
        {
            int count = gvLow.Rows.Count;
            lblLow.Text = count > 0 ? $" Free shipping offer sent to {count} Low Value customers!" : " No low value customers found.";
        }

        protected void btnBulk_Click(object sender, EventArgs e)
        {
            int count = gvBulk.Rows.Count;
            lblBulk.Text = count > 0 ? $" 30% volume discount sent to {count} Bulk buyers!" : " No bulk buyers found.";
        }

        protected void btnBack_Click(object sender, EventArgs e)
        {
            Response.Redirect("Default.aspx");
        }

        private void LoadData(string sql, System.Web.UI.WebControls.GridView gv)
        {
            using (System.Data.SqlClient.SqlConnection con = new System.Data.SqlClient.SqlConnection(connentionString))
            {
                System.Data.SqlClient.SqlDataAdapter da = new System.Data.SqlClient.SqlDataAdapter(sql, con);
                System.Data.DataTable dt = new System.Data.DataTable();
                da.Fill(dt);
                gv.DataSource = dt;
                gv.DataBind();
            }
        }
    </script>
</body>
</html>