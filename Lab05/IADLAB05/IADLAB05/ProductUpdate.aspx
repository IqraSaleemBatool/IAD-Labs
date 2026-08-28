<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ProductUpdate.aspx.cs" Inherits="PVFC.ProductUpdate" %>

<!DOCTYPE html>
<html>
<head runat="server">
    <title>Product Catalog Update</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 20px;
            background-color: #f5f5f5;
        }
        .container {
            max-width: 1000px;
            margin: auto;
            background: white;
            padding: 20px;
            border: 1px solid #ddd;
            border-radius: 10px;
        }
        h2 {
            color: #333;
            border-bottom: 2px solid #4CAF50;
            padding-bottom: 10px;
        }
        .select-product {
            background: #f9f9f9;
            padding: 20px;
            border: 1px solid #ddd;
            margin-bottom: 20px;
            border-radius: 8px;
        }
        .select-product label {
            font-weight: bold;
            display: block;
            margin-bottom: 5px;
        }
        .select-product select {
            width: 100%;
            padding: 10px;
            margin: 10px 0;
            border: 1px solid #ccc;
            border-radius: 4px;
            font-size: 14px;
        }
        .update-form {
            margin-top: 20px;
            padding: 20px;
            border: 1px solid #ddd;
            background: #fafafa;
            border-radius: 8px;
        }
        .update-form h3 {
            margin-top: 0;
            color: #4CAF50;
        }
        .update-form label {
            display: inline-block;
            width: 120px;
            font-weight: bold;
        }
        .update-form input, .update-form select {
            padding: 8px;
            margin: 5px 0 15px 0;
            width: 250px;
            border: 1px solid #ccc;
            border-radius: 4px;
        }
        .btn {
            padding: 8px 20px;
            margin: 5px;
            cursor: pointer;
            border: none;
            color: white;
            border-radius: 4px;
        }
        .btn-update {
            background: #4CAF50;
        }
        .btn-update:hover {
            background: #45a049;
        }
        .btn-select {
            background: #FF9800;
        }
        .btn-select:hover {
            background: #e68900;
        }
        .btn-back {
            background: #D2691E;
        }
        .btn-back:hover {
            background: #8B4513;
        }
        .button-group {
            text-align: center;
            margin-top: 20px;
            padding-top: 20px;
            border-top: 1px solid #ddd;
        }
        .success {
            background: #e8f5e9;
            border: 1px solid #4CAF50;
            color: #2e7d32;
            padding: 10px;
            margin: 10px 0;
        }
        .error {
            background: #ffebee;
            border: 1px solid #f44336;
            color: #c62828;
            padding: 10px;
            margin: 10px 0;
        }
        .info {
            background: #e3f2fd;
            border: 1px solid #2196F3;
            color: #1565c0;
            padding: 10px;
            margin: 10px 0;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="container">
            <h2>Product Catalog Management</h2>
            
            <div class="select-product">
                <h3>Select Product to Update</h3>
                <label>Choose Product:</label>
                <asp:DropDownList ID="ddlProducts" runat="server" AutoPostBack="true" 
                    OnSelectedIndexChanged="ddlProducts_SelectedIndexChanged" Width="100%">
                    <asp:ListItem Text="-- Select a Product --" Value="" />
                </asp:DropDownList>
            </div>
        
            <div class="update-form" id="updateForm">
                <h3>Update Product Details</h3>
                
                <label>Product ID:</label>
                <asp:TextBox ID="txtProductId" runat="server" ReadOnly="true" BackColor="#f0f0f0" />
                <br />

                <label>Category:</label>
                <asp:DropDownList ID="ddlProductLine" runat="server">
                    <asp:ListItem Text="-- Select Category --" Value="" />
                    <asp:ListItem Text="Cherry Tree" Value="1" />
                    <asp:ListItem Text="Scandinavia" Value="2" />
                    <asp:ListItem Text="Country Look" Value="3" />
                </asp:DropDownList>
                <br />

                <label>Product Name:</label>
                <asp:TextBox ID="txtDescription" runat="server" />
                <br />

                <label>Finish:</label>
                <asp:TextBox ID="txtFinish" runat="server" />
                <br />

                <label>Price ($):</label>
                <asp:TextBox ID="txtPrice" runat="server" />
                <br />

                <br />
                <asp:Button ID="btnUpdate" runat="server" Text="Update Product" 
                    CssClass="btn btn-update" OnClick="btnUpdate_Click" />
            </div>
            
            <asp:Label ID="lblMsg" runat="server" />
            
            <div class="button-group">
                <asp:Button ID="btnBackToMain" runat="server" Text="← Back to Main Page" 
                    CssClass="btn btn-back" OnClick="btnBackToMain_Click" />
            </div>
        </div>
    </form>
</body>
</html>