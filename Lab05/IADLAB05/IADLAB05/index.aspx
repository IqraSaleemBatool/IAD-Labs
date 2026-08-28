<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Index.aspx.cs" Inherits="WebApp.Index" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<title>PVFC Management System</title>

<style>
.linkStyle{
display:block;
margin:10px;
font-size:18px;
}
</style>

</head>

<body>

<form id="form1" runat="server">

<h2>PVFC Project</h2>

<asp:HyperLink ID="lnkCustomer" runat="server"
NavigateUrl="CustomerRegistration.aspx"
CssClass="linkStyle">
Customer Registration
</asp:HyperLink>

<asp:HyperLink ID="lnkProduct" runat="server"
NavigateUrl="ProductUpdate.aspx"
CssClass="linkStyle">
Product Catalog Update
</asp:HyperLink>

<asp:HyperLink ID="HyperLink1" runat="server"
NavigateUrl="ProductSelection.aspx"
CssClass="linkStyle">
Product Selection
</asp:HyperLink>

<asp:HyperLink ID="HyperLink2" runat="server"
NavigateUrl="ProductSearch.aspx"
CssClass="linkStyle">
Product Search
</asp:HyperLink>

</form>

</body>
</html>