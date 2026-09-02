<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ManagerDashboard.aspx.cs" Inherits="PVFC.ManagerDashboard" %>

<html>
<body>
<form runat="server">

<h2>Manager Dashboard</h2>

<asp:HyperLink runat="server" NavigateUrl="ProductSearch.aspx">
    Product Search
</asp:HyperLink>
<br /><br />

<asp:HyperLink runat="server" NavigateUrl="CustomerDashboard.aspx">
    Order Placement
</asp:HyperLink>
<br /><br />

<asp:HyperLink runat="server" NavigateUrl="PaymentProvision.aspx">
    Payment Provision
</asp:HyperLink>
<br /><br />
    <asp:HyperLink runat="server" NavigateUrl="DemandForecast.aspx">
    Demand Forecast
</asp:HyperLink>
    <br /><br />
    <div class="button-group">
                <asp:Button ID="btnLogout" runat="server" Text="Logout" CssClass="btn-logout" OnClick="btnLogout_Click" />
     </div>


</form>
</body>
</html>