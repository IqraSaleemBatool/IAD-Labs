<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="task_01.aspx.cs" Inherits="IADLAB4.task_01" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <style>
    .linkStyle {
        display: inline-block;
        margin: 10px 0;
    }
</style>
</head>
<body>
    <form id="form1" runat="server">
                <asp:HyperLink runat="server" NavigateUrl="task_01_Customer_Registration.aspx" CssClass="linkStyle">
Customer Registration 

</asp:HyperLink>
<br />
        <asp:HyperLink runat="server" NavigateUrl="task_01_product_catalog.aspx" CssClass="linkStyle">
Product Catalog  
</asp:HyperLink>
<br />

<asp:HyperLink runat="server" NavigateUrl="task_01_product_search.aspx" CssClass="linkStyle">
Product Search  
</asp:HyperLink>
<br />

<asp:HyperLink runat="server" NavigateUrl="task_01_product_selection.aspx" CssClass="linkStyle">
Product Selection  
</asp:HyperLink>
<br />

<asp:HyperLink runat="server" NavigateUrl="task_01_payment_provision.aspx" CssClass="linkStyle">
Payment Provision  
</asp:HyperLink>
<br />
    </form>
</body>
</html>
