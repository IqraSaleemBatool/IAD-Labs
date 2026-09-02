<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="CustomerSegmentation.aspx.cs" Inherits="PVFC.CustomerSegmentation" %>

<!DOCTYPE html>
<html>
<head runat="server">
    <title>Customer Segmentation</title>

    <style>
        body {
            font-family: Arial;
            background-color: #f4f6f8;
            margin: 0;
            padding: 20px;
        }

        .container {
            width: 90%;
            margin: auto;
            background: white;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0px 0px 10px #ccc;
        }

        h2 {
            text-align: center;
            color: #333;
        }

        h3 {
            background: #4CAF50;
            color: white;
            padding: 8px;
            border-radius: 4px;
        }

        .grid {
            margin-bottom: 10px;
        }

        .btn {
            padding: 6px 15px;
            background: #4CAF50;
            color: white;
            border: none;
            border-radius: 4px;
            cursor: pointer;
        }

        .btn:hover {
            background: #45a049;
        }

        .msg {
            display: block;
            margin-top: 5px;
            color: #333;
            font-weight: bold;
        }

        .back-btn {
            background: #555;
        }

        .back-btn:hover {
            background: #333;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin-bottom: 5px;
        }

        th, td {
            border: 1px solid #ddd;
            padding: 6px;
        }

        th {
            background: #eee;
        }
    </style>
</head>

<body>
<form runat="server">

<div class="container">

<h2>Customer Segmentation & Marketing</h2>
<asp:Button ID="btnRefresh" runat="server" Text="Refresh Data" 
    OnClick="btnRefresh_Click" CssClass="btn" />

<h3>Premium Customers (Spent > $2000)</h3>
<asp:GridView ID="gvPremium" runat="server" CssClass="grid" />
<asp:Button ID="btnPremium" runat="server" CssClass="btn" Text="Send Offer" OnClick="btnPremium_Click"/>
<asp:Label ID="lblPremium" runat="server" CssClass="msg" /><br /><br />

<h3>Frequent Customers (Orders > 3)</h3>
<asp:GridView ID="gvFrequent" runat="server" CssClass="grid" />
<asp:Button ID="btnFrequent" runat="server" CssClass="btn" Text="Send Offer" OnClick="btnFrequent_Click"/>
<asp:Label ID="lblFrequent" runat="server" CssClass="msg" /><br /><br />

<h3> Bulk Buyers (Avg Quantity > 3)</h3>
<asp:GridView ID="gvBulk" runat="server" CssClass="grid" />
<asp:Button ID="btnBulk" runat="server" CssClass="btn" Text="Send Offer" OnClick="btnBulk_Click"/>
<asp:Label ID="lblBulk" runat="server" CssClass="msg" /><br /><br />

<h3>Occasional Customers</h3>
<asp:GridView ID="gvOccasional" runat="server" CssClass="grid" />
<asp:Button ID="btnOccasional" runat="server" CssClass="btn" Text="Send Offer" OnClick="btnOccasional_Click"/>
<asp:Label ID="lblOccasional" runat="server" CssClass="msg" /><br /><br />

<h3>Low Value Customers (Spent < $500)</h3>
<asp:GridView ID="gvLow" runat="server" CssClass="grid" />
<asp:Button ID="btnLow" runat="server" CssClass="btn" Text="Send Offer" OnClick="btnLow_Click"/>
<asp:Label ID="lblLow" runat="server" CssClass="msg" /><br /><br />

<h3>Inactive Customers (No orders in 6 months)</h3>
<asp:GridView ID="gvInactive" runat="server" CssClass="grid" />
<asp:Button ID="btnInactive" runat="server" CssClass="btn" Text="Send Offer" OnClick="btnInactive_Click"/>
<asp:Label ID="lblInactive" runat="server" CssClass="msg" /><br /><br />

<br />


<asp:Button ID="btnBack" runat="server" CssClass="btn back-btn" Text="Back to Admin Dashboard" OnClick="btnBack_Click"/>

</div>

</form>
</body>
</html>