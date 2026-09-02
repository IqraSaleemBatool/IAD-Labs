<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AdminDashboard.aspx.cs" Inherits="PVFC.AdminDashboard" %>
<html>
<body>
 <form runat="server"> 
<h2>Admin Dashboard</h2>
<asp:HyperLink runat="server" NavigateUrl="ProductCatalogUpdate.aspx">Product Catalog Update</asp:HyperLink><br /><br />
<asp:HyperLink runat="server" NavigateUrl="ProductSearch.aspx">Product Search</asp:HyperLink><br /><br />
<asp:HyperLink runat="server" NavigateUrl="CustomerDashboard.aspx">Order Placement</asp:HyperLink><br /><br />
<asp:HyperLink runat="server" NavigateUrl="PaymentProvision.aspx">Payment Provision</asp:HyperLink><br/><br/>
 <asp:HyperLink runat="server" NavigateUrl="CustomerSegmentation.aspx">Customer Segmentation</asp:HyperLink><br /><br />
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
