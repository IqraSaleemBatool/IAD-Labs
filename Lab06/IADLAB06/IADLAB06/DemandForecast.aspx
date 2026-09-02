<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="DemandForecast.aspx.cs" Inherits="PVFC.DemandForecast" %>

<!DOCTYPE html>
<html>
<head runat="server">
    <title>Demand Forecast</title>

    <style>
        body { font-family: Arial; background: #f5f5f5; }
        .container {
            width: 80%;
            margin: auto;
            background: white;
            padding: 20px;
            margin-top: 30px;
            border: 1px solid #ddd;
        }
        h2 { color: #333; }
        table { width: 100%; border-collapse: collapse; }
        th {
            background: #4CAF50;
            color: white;
            padding: 10px;
        }
        td {
            padding: 8px;
            border: 1px solid #ddd;
        }
        .info {
            background: #e3f2fd;
            padding: 10px;
            margin-bottom: 15px;
            border: 1px solid #2196F3;
        }
    </style>
</head>

<body>
<form runat="server">

<div class="container">

    <h2>Demand Forecast</h2>

    <div class="info">
        This report shows high-demand products based on previous orders.
    </div>

    <asp:GridView ID="gvForecast" runat="server" AutoGenerateColumns="False">
        <Columns>
            <asp:BoundField DataField="Product_Id" HeaderText="Product ID" />
            <asp:BoundField DataField="Product_Description" HeaderText="Product Name" />
            <asp:BoundField DataField="DemandScore" HeaderText="Demand Score" />
            <asp:BoundField DataField="Action" HeaderText="Manager Decision" />
        </Columns>
    </asp:GridView>

    <br />

    <asp:Button ID="btnBack" runat="server" Text="Back To DashBoard" OnClick="btnBack_Click" />

</div>

</form>
</body>
</html>