<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ProductSearch.aspx.cs" Inherits="PVFC.ProductSearch" %>

<!DOCTYPE html>
<html>
<head runat="server">
    <title>Product Search</title>
    <style>
        body { 
            font-family: Arial, sans-serif;
            background-color: #f2f2f2; 
        }
        .container {
            width: 800px;
            margin: 40px auto;
            padding: 25px;
            background-color: white;
            border: 1px solid #ccc;
            border-radius: 10px;
        }
        h2 { 
            text-align: center; 
            margin-bottom: 20px; 
            color: #333;
            border-bottom: 2px solid #4CAF50;
            padding-bottom: 10px;
        }
        .search-box {
            background: #f9f9f9;
            padding: 20px;
            border: 1px solid #ddd;
            margin-bottom: 20px;
            border-radius: 8px;
        }
        .search-box label {
            font-weight: bold;
            display: block;
            margin-bottom: 5px;
        }
        .search-box select {
            width: 100%;
            padding: 10px;
            margin: 10px 0;
            border: 1px solid #ccc;
            border-radius: 4px;
            font-size: 14px;
        }
        .search-box input {
            width: 100%;
            padding: 10px;
            margin: 10px 0;
            border: 1px solid #ccc;
            border-radius: 4px;
            box-sizing: border-box;
        }
        .btn { 
            padding: 10px 20px; 
            margin: 5px;
            cursor: pointer;
            border: none;
            border-radius: 4px;
            color: white;
            font-size: 14px;
        }
        .btn-search { 
            background: #2196F3;
        }
        .btn-search:hover {
            background: #0b7dda;
        }
        .btn-clear {
            background: #FF9800;
        }
        .btn-clear:hover {
            background: #e68900;
        }
        .btn-back {
            background: #D2691E;
        }
        .btn-back:hover {
            background: #8B4513;
        }
        .result-box {
            margin-top: 20px;
            padding: 15px;
            background: #f5f5f5;
            border: 1px solid #ddd;
            border-radius: 8px;
        }
        .product-detail {
            background: white;
            padding: 15px;
            margin-top: 10px;
            border: 1px solid #ddd;
            border-radius: 8px;
        }
        .product-detail table {
            width: 100%;
        }
        .product-detail td {
            padding: 8px;
        }
        .product-detail .label {
            font-weight: bold;
            width: 120px;
            background: #f0f0f0;
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
        .success {
            background: #e8f5e9;
            border: 1px solid #4CAF50;
            color: #2e7d32;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="container">
            <h2>Product Search</h2>
            
            <div class="search-box">
                <label>Select Product Name:</label>
                <asp:DropDownList ID="ddlProductNames" runat="server" AutoPostBack="true" 
                    OnSelectedIndexChanged="ddlProductNames_SelectedIndexChanged" Width="100%">
                    <asp:ListItem Text="-- Select a Product --" Value="" />
                </asp:DropDownList>
                
                <div style="text-align: center; margin-top: 15px;">
                    <asp:Button ID="btnSearch" runat="server" Text="Search Selected Product" CssClass="btn btn-search" OnClick="btnSearch_Click" />
                    <asp:Button ID="btnClear" runat="server" Text="Clear" CssClass="btn btn-clear" OnClick="btnClear_Click" />
                </div>
            </div>
            
            
            <div class="result-box">
                <h3>Product details</h3>
                <asp:Label ID="lblResultCount" runat="server" Text="Select a product from the dropdown to view details." ForeColor="#666" />
                
                <div class="product-detail" id="productDetail" runat="server" visible="false">
                    <table>
                        <tr>
                            <td class="label">Product ID:</td>
                            <td><asp:Label ID="lblProductId" runat="server" Font-Bold="true" /></td>
                        </tr>
                        <tr>
                            <td class="label">Product Name:</td>
                            <td><asp:Label ID="lblProductName" runat="server" Font-Bold="true" ForeColor="#4CAF50" /></td>
                        </tr>
                        <tr>
                            <td class="label">Finish:</td>
                            <td><asp:Label ID="lblFinish" runat="server" /></td>
                        </tr>
                        <tr>
                            <td class="label">Price:</td>
                            <td><asp:Label ID="lblPrice" runat="server" Font-Bold="true" ForeColor="#2196F3" /></td>
                        </tr>
                        <tr>
                            <td class="label">Category:</td>
                            <td><asp:Label ID="lblCategory" runat="server" /></td>
                        </tr>
                    </table>
                </div>
            </div>
            
            <asp:Label ID="lblMsg" runat="server" CssClass="message" />
            
            <div class="button-group">
                <asp:Button ID="btnBack" runat="server" Text="← Back to Main Page" CssClass="btn btn-back" OnClick="btnBack_Click" />
            </div>
        </div>
    </form>
</body>
</html>