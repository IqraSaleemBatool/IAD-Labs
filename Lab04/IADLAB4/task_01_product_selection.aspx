<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="task_01_product_selection.aspx.cs" Inherits="PVFC.task_01_product_selection" %>

<!DOCTYPE html>
<html>
<head runat="server">
<title>Product Selection</title>
</head>

<body>

<form id="form1" runat="server">

<h2>Select Product For Order</h2>

Order ID:<br />
<asp:TextBox ID="txtOrderId" runat="server"></asp:TextBox>

<br /><br />

Product ID:<br />
<asp:TextBox ID="txtProductId" runat="server"></asp:TextBox>

<br /><br />

Quantity:<br />
<asp:TextBox ID="txtQuantity" runat="server"></asp:TextBox>

<br /><br />

<asp:Button ID="btnAdd"
runat="server"
Text="Add Product"
OnClick="btnAdd_Click" />

<br /><br />

<asp:Label ID="lblMsg" runat="server"></asp:Label>

</form>

</body>
</html>