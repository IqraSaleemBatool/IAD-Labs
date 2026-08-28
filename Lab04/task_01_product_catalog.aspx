<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="task_01_product_catalog.aspx.cs" Inherits="PVFC.task_01_product_catalog" %>

<!DOCTYPE html>
<html>
<head runat="server">
    <title>Product Catalog Update</title>
</head>
<body>
<form id="form1" runat="server">
    <h2>Product Catalog Update</h2>

    Product ID:<br />
    <asp:TextBox ID="txtProductId" runat="server" /><br /><br />

    Product Line:<br />
    <asp:DropDownList ID="ddlProductLine" runat="server">
        <asp:ListItem Text="Select Line" Value="" />
        <asp:ListItem Text="Cherry Tree" Value="1" />
        <asp:ListItem Text="Scandinavia" Value="2" />
        <asp:ListItem Text="Country Look" Value="3" />
    </asp:DropDownList><br /><br />

    Description:<br />
    <asp:TextBox ID="txtDescription" runat="server" /><br /><br />

    Finish:<br />
    <asp:TextBox ID="txtFinish" runat="server" /><br /><br />

    Standard Price:<br />
    <asp:TextBox ID="txtPrice" runat="server" /><br /><br />

    <asp:Button ID="btnUpdate" runat="server"
        Text="Update Product"
        OnClick="btnUpdate_Click" />

    <br /><br />
    <asp:Label ID="lblMsg" runat="server" ForeColor="Green" />
</form>
</body>
</html>