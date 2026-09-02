<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="OrderPlacement.aspx.cs" Inherits="PVFC.OrderPlacement" %>

<!DOCTYPE html>
<html>
<head runat="server">
<title>Product Selection</title>
</head>

<body>

<form id="form1" runat="server">

<h2>Confirm Your Order</h2>

<asp:Label ID="lblProduct" runat="server"></asp:Label>

<br /><br />

Quantity:<br />
<asp:TextBox ID="txtQuantity" runat="server" Text="1"></asp:TextBox>

<br /><br />

<asp:Button ID="btnConfirm"
runat="server"
Text="Confirm Order"
OnClick="btnConfirm_Click" />

<br /><br />

<asp:Label ID="lblMsg" runat="server"></asp:Label>

</form>

</body>
</html>