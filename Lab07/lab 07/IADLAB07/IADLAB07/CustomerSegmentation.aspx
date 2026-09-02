<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="CustomerSegmentation.aspx.cs" Inherits="CustomerSegmentation" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Customer Segmentation Analysis</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 20px;
            background-color: #f5f5f5;
        }
        
        .container {
            max-width: 1300px;
            margin: auto;
            background: white;
            padding: 20px;
            border: 1px solid #ddd;
            border-radius: 8px;
        }
        
        h2 {
            color: #333;
            margin-top: 0;
            padding-bottom: 10px;
            border-bottom: 2px solid #4CAF50;
            text-align: center;
        }
        
        .stats {
            background: #e8f5e9;
            padding: 15px;
            margin: 20px 0;
            border: 1px solid #c8e6c9;
            border-radius: 5px;
            display: flex;
            justify-content: space-around;
            flex-wrap: wrap;
        }
        
        .stat-card {
            text-align: center;
            padding: 10px 20px;
            background: white;
            border-radius: 5px;
            min-width: 150px;
        }
        
        .stat-number {
            font-size: 24px;
            font-weight: bold;
            color: #4CAF50;
        }
        
        .stat-label {
            font-size: 12px;
            color: #666;
            margin-top: 5px;
        }
        
        .segment {
            margin-bottom: 30px;
            border: 1px solid #ddd;
            background: white;
            border-radius: 5px;
            overflow: hidden;
        }
        
        .segment-title {
            background: #4CAF50;
            color: white;
            padding: 12px 15px;
            font-weight: bold;
            font-size: 16px;
        }
        
        .segment-desc {
            font-size: 12px;
            font-weight: normal;
            margin-left: 10px;
            opacity: 0.9;
        }
        
        table {
            width: 100%;
            border-collapse: collapse;
        }
        
        th {
            background: #f2f2f2;
            padding: 10px;
            text-align: left;
            border: 1px solid #ddd;
            font-weight: bold;
        }
        
        td {
            padding: 8px 10px;
            border: 1px solid #ddd;
        }
        
        tr:hover {
            background-color: #f9f9f9;
        }
        
        .btn {
            padding: 8px 20px;
            margin: 5px;
            cursor: pointer;
            border: none;
            background: #4CAF50;
            color: white;
            border-radius: 4px;
        }
        
        .btn-back {
            background: #666;
        }
        
        .btn:hover {
            background: #45a049;
        }
        
        .footer {
            text-align: center;
            margin-top: 20px;
            padding-top: 20px;
            border-top: 1px solid #ddd;
            color: #666;
            font-size: 12px;
        }
        
        .refresh-btn {
            text-align: right;
            margin-bottom: 15px;
        }
        
        .button-group {
            text-align: center;
            margin-top: 20px;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="container">
            <h2> Customer Segmentation Analysis</h2>
            
            <div class="refresh-btn">
                <asp:Button ID="btnRefresh" runat="server" Text=" Refresh Data" 
                    CssClass="btn" OnClick="btnRefresh_Click" />
            </div>
          
            <div class="stats">
                <div class="stat-card">
                    <div class="stat-number"><asp:Label ID="lblTotalCustomers" runat="server" Text="0" /></div>
                    <div class="stat-label">Total Customers</div>
                </div>
                <div class="stat-card">
                    <div class="stat-number"><asp:Label ID="lblActiveCustomers" runat="server" Text="0" /></div>
                    <div class="stat-label">Active Customers</div>
                </div>
                <div class="stat-card">
                    <div class="stat-number"><asp:Label ID="lblInactiveCustomers" runat="server" Text="0" /></div>
                    <div class="stat-label">Inactive/New Customers</div>
                </div>
                <div class="stat-card">
                    <div class="stat-number">$<asp:Label ID="lblTotalRevenue" runat="server" Text="0" /></div>
                    <div class="stat-label">Total Revenue</div>
                </div>
            </div>
            
            <!-- Premium Customers -->
            <div class="segment">
                <div class="segment-title"> Premium Customers <span class="segment-desc">(Total spent more than $2,000)</span></div>
                <asp:GridView ID="gvPremium" runat="server" AutoGenerateColumns="True" 
                    EmptyDataText="No premium customers found" Width="100%" />
            </div>
            
            <!-- Frequent Customers -->
            <div class="segment">
                <div class="segment-title"> Frequent Customers <span class="segment-desc">(More than 3 orders)</span></div>
                <asp:GridView ID="gvFrequent" runat="server" AutoGenerateColumns="True" 
                    EmptyDataText="No frequent customers found" Width="100%" />
            </div>
            
            <!-- Bulk Buyers -->
            <div class="segment">
                <div class="segment-title"> Bulk Buyers <span class="segment-desc">(Average quantity more than 3 per order)</span></div>
                <asp:GridView ID="gvBulk" runat="server" AutoGenerateColumns="True" 
                    EmptyDataText="No bulk buyers found" Width="100%" />
            </div>
            
            <!-- Occasional Customers -->
            <div class="segment">
                <div class="segment-title"> Occasional Customers <span class="segment-desc">(1 or 0 orders)</span></div>
                <asp:GridView ID="gvOccasional" runat="server" AutoGenerateColumns="True" 
                    EmptyDataText="No occasional customers found" Width="100%" />
            </div>
            
            <!-- Low Value Customers -->
            <div class="segment">
                <div class="segment-title"> Low Value Customers <span class="segment-desc">(Total spent less than $500)</span></div>
                <asp:GridView ID="gvLow" runat="server" AutoGenerateColumns="True" 
                    EmptyDataText="No low value customers found" Width="100%" />
            </div>
            
            <!-- Inactive Customers -->
            <div class="segment">
                <div class="segment-title"> Inactive Customers <span class="segment-desc">(No orders in last 6 months)</span></div>
                <asp:GridView ID="gvInactive" runat="server" AutoGenerateColumns="True" 
                    EmptyDataText="No inactive customers found" Width="100%" />
            </div>
            
            <!-- Loyal Customers -->
            <div class="segment">
                <div class="segment-title"> Loyal Customers <span class="segment-desc">(Frequent + Premium - More than 3 orders and spent > $2000)</span></div>
                <asp:GridView ID="gvLoyal" runat="server" AutoGenerateColumns="True" 
                    EmptyDataText="No loyal customers found" Width="100%" />
            </div>
            
            <div class="footer">
                <p>Data generated on: <asp:Label ID="lblGeneratedDate" runat="server" /></p>
                <p>Based on order history from database</p>
            </div>
            
            <div class="button-group">
                <asp:Button ID="btnBack" runat="server" Text="Back to Dashboard" CssClass="btn btn-back" OnClick="btnBack_Click" />
            </div>
        </div>
    </form>
</body>
</html>