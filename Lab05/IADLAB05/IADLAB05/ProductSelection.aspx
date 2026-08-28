<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ProductSelection.aspx.cs" Inherits="PVFC.ProductSelection" %>

<!DOCTYPE html>
<html>
<head runat="server">
    <title>Product Selection</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f2f2f2;
        }
        .container {
            width: 1000px;
            margin: 40px auto;
            padding: 25px;
            background-color: white;
            border: 1px solid #ccc;
        }
        h2 {
            text-align: center;
            margin-bottom: 20px;
            color: #333;
            border-bottom: 2px solid #4CAF50;
            padding-bottom: 10px;
        }
        h3 {
            color: #4CAF50;
            margin: 20px 0 10px 0;
        }
        .product-table {
            margin-top: 20px;
            margin-bottom: 30px;
            width: 100%;
            border-collapse: collapse;
        }
        .product-table th {
            background: #4CAF50;
            color: white;
            padding: 10px;
            text-align: left;
            border: 1px solid #ddd;
        }
        .product-table td {
            border: 1px solid #ddd;
            padding: 8px;
            text-align: left;
        }
        .product-table tr:hover {
            background-color: #f5f5f5;
            cursor: pointer;
        }
        .order-form {
            background: #f9f9f9;
            padding: 20px;
            border: 1px solid #ddd;
            margin-top: 20px;
        }
        .order-form label {
            display: inline-block;
            width: 100px;
            font-weight: bold;
        }
        .order-form input {
            padding: 8px;
            margin: 5px 0 15px 0;
            width: 200px;
            border: 1px solid #ccc;
            border-radius: 4px;
        }
        .btn {
            padding: 8px 20px;
            margin: 5px;
            cursor: pointer;
            border: none;
            border-radius: 4px;
            color: white;
        }
        .btn-add {
            background: #4CAF50;
        }
        .btn-add:hover {
            background: #45a049;
        }
        .btn-refresh {
            background: #2196F3;
        }
        .btn-refresh:hover {
            background: #0b7dda;
        }
        .btn-back {
            background: #666;
            margin-top: 20px;
        }
        .btn-back:hover {
            background: #555;
        }
        .btn-select {
            background: #FF9800;
            padding: 5px 10px;
            font-size: 12px;
        }
        .btn-select:hover {
            background: #e68900;
        }
        .button-group {
            text-align: center;
            margin-top: 20px;
            padding-top: 20px;
            border-top: 1px solid #ddd;
        }
        .message {
            padding: 10px;
            margin: 10px 0;
            border-radius: 4px;
        }
        .success {
            background: #e8f5e9;
            border: 1px solid #4CAF50;
            color: #2e7d32;
        }
        .error {
            background: #ffebee;
            border: 1px solid #f44336;
            color: #c62828;
        }
        .info {
            background: #e3f2fd;
            border: 1px solid #2196F3;
            color: #1565c0;
        }
        .selected-product {
            background-color: #e8f5e9;
        }
    </style>
    <script type="text/javascript">
        function selectProduct(productId, productName) {
            document.getElementById('<%= txtProductId.ClientID %>').value = productId;
            document.getElementById('<%= txtProductNameDisplay.ClientID %>').value = productName;
            document.getElementById('<%= txtProductId.ClientID %>').style.backgroundColor = '#e8f5e9';
        }
    </script>
</head>
<body>
    <form id="form1" runat="server">
        <div class="container">
            <h2> Product Selection for Order</h2>
            
            <div style="margin-bottom: 15px;">
                <asp:Button ID="btnRefresh" runat="server" Text="Refresh Product List" 
                    CssClass="btn btn-refresh" OnClick="btnRefresh_Click" />
            </div>
            
            <h3>Available Products</h3>
            <asp:GridView ID="gvProducts" runat="server" AutoGenerateColumns="False" 
                Width="100%" CssClass="product-table" OnRowCommand="gvProducts_RowCommand">
                <Columns>
                    <asp:BoundField DataField="Product_Id" HeaderText="ID" />
                    <asp:BoundField DataField="Product_Description" HeaderText="Product Name" />
                    <asp:BoundField DataField="Product_Finish" HeaderText="Finish" />
                    <asp:BoundField DataField="Standard_Price" HeaderText="Price ($)" DataFormatString="{0:C2}" />
                    <asp:ButtonField ButtonType="Button" Text="Select" CommandName="SelectProduct"
                        HeaderText="Action" ItemStyle-HorizontalAlign="Center" />
                </Columns>
                <HeaderStyle BackColor="#4CAF50" ForeColor="White" />
                <AlternatingRowStyle BackColor="#f9f9f9" />
            </asp:GridView>
          
            <div class="order-form">
                <h3> Add Product to Order</h3>
                
                <label>Order ID:</label>
                <asp:TextBox ID="txtOrderId" runat="server" placeholder="Enter Order ID" />
                <br />
                
                <label>Product ID:</label>
                <asp:TextBox ID="txtProductId" runat="server" ReadOnly="true" BackColor="#f0f0f0" />
                <br />
                
                <label>Product Name:</label>
                <asp:TextBox ID="txtProductNameDisplay" runat="server" ReadOnly="true" BackColor="#f0f0f0" />
                <br />
                
                <label>Quantity:</label>
                <asp:TextBox ID="txtQuantity" runat="server" Text="1" />
                <br />
                
                <br />
                <asp:Button ID="btnAdd" runat="server" Text="Add to Order" CssClass="btn btn-add" OnClick="btnAdd_Click" />
            </div>
            
            <asp:Label ID="lblMsg" runat="server" />
            
            <div class="button-group">
                <asp:Button ID="btnBack" runat="server" Text=" Back to Main Page" CssClass="btn btn-back" OnClick="btnBack_Click" />
            </div>
        </div>
    </form>
</body>
</html>