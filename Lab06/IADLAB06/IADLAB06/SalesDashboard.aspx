<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="SalesDashboard.aspx.cs" Inherits="PVFC.SalesDashboard" %>
<html>
<body>
<form runat="server"> 
<h2>Salesperson Dashboard</h2>
<asp:HyperLink runat="server" NavigateUrl="CustomerDashboard.aspx">Order Placement</asp:HyperLink><br /><br />
<asp:HyperLink runat="server" NavigateUrl="PaymentProvision.aspx">Payment Provision</asp:HyperLink>
 <br /><br />
    <div class="button-group">
                <asp:Button ID="btnLogout" runat="server" Text="Logout" CssClass="btn-logout" OnClick="btnLogout_Click" />
            </div>
</form>
</body>
</html>
