<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="CustomerDashboard.aspx.cs" Inherits="PVFC.CustomerDashboard" %>

<!DOCTYPE html>
<html>
<head runat="server">
    <title>Customer Store</title>
    <style>
        body { font-family: Arial; margin: 20px; background: #f5f5f5; }
        .container { max-width: 1200px; margin: auto; background: white; padding: 20px; border: 1px solid #ddd; }
        h2 { color: #333; border-bottom: 2px solid #4CAF50; padding-bottom: 10px; }
        h3 { color: #4CAF50; margin: 20px 0 10px 0; }
        table { width: 100%; border-collapse: collapse; margin-bottom: 20px; }
        th { background: #4CAF50; color: white; padding: 10px; text-align: left; }
        td { padding: 8px; border: 1px solid #ddd; }
        .cart-table th { background: #FF9800; }
        .btn { padding: 5px 10px; margin: 2px; cursor: pointer; border: none; border-radius: 3px; color: white; }
        .btn-add { background: #4CAF50; }
        .btn-remove { background: #f44336; }
        .btn-checkout { background: #2196F3; padding: 8px 20px; font-size: 14px; }
        .btn-clear { background: #FF9800; }
        .btn-back { background: #666; }
        .search-box { margin-bottom: 15px; padding: 10px; background: #f9f9f9; }
        .cart-summary { background: #e8f5e9; padding: 10px; margin: 10px 0; text-align: right; }
        .qty-box { width: 50px; padding: 3px; text-align: center; }
        .success { background: #e8f5e9; border: 1px solid #4CAF50; color: #2e7d32; padding: 8px; margin: 10px 0; }
        .error { background: #ffebee; border: 1px solid #f44336; color: #c62828; padding: 8px; margin: 10px 0; }
        .info { background: #e3f2fd; border: 1px solid #2196F3; color: #1565c0; padding: 8px; margin: 10px 0; }
        .button-group { text-align: center; margin-top: 20px; padding-top: 20px; border-top: 1px solid #ddd; }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="container">
            <h2>Shopping Store</h2>
            
            <!-- Search -->
            <div class="search-box">
                <asp:TextBox ID="txtSearch" runat="server" placeholder="Search product..." />
                <asp:Button ID="btnSearch" runat="server" Text="Search" CssClass="btn btn-add" OnClick="btnSearch_Click" />
                <asp:Button ID="btnShowAll" runat="server" Text="Show All" CssClass="btn btn-clear" OnClick="btnShowAll_Click" />
            </div>
            
            <!-- Products -->
            <h3>Products</h3>
            <asp:GridView ID="gvProducts" runat="server" AutoGenerateColumns="False" 
                DataKeyNames="Product_Id" OnRowCommand="gvProducts_RowCommand" Width="100%">
                <Columns>
                    <asp:BoundField DataField="Product_Id" HeaderText="ID" />
                    <asp:BoundField DataField="Product_Description" HeaderText="Name" />
                    <asp:BoundField DataField="Standard_Price" HeaderText="Price" DataFormatString="{0:C2}" />
                    <asp:TemplateField HeaderText="Qty">
                        <ItemTemplate>
                            <asp:TextBox ID="txtQty" runat="server" Text="1" Width="40px" CssClass="qty-box" />
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:ButtonField ButtonType="Button" Text="Add to Cart" CommandName="AddToCart" />
                </Columns>
                <HeaderStyle BackColor="#4CAF50" ForeColor="White" />
            </asp:GridView>
            
            <!-- Cart -->
            <h3>Your Cart</h3>
            <asp:GridView ID="gvCart" runat="server" AutoGenerateColumns="False" 
                OnRowCommand="gvCart_RowCommand" Width="100%" CssClass="cart-table" 
                EmptyDataText="Cart is empty">
                <Columns>
                    <asp:BoundField DataField="Product_Name" HeaderText="Product" />
                    <asp:BoundField DataField="Price" HeaderText="Price" DataFormatString="{0:C2}" />
                    <asp:BoundField DataField="Quantity" HeaderText="Qty" />
                    <asp:BoundField DataField="Total" HeaderText="Total" DataFormatString="{0:C2}" />
                    <asp:ButtonField ButtonType="Button" Text="Remove" CommandName="Remove" />
                </Columns>
                <HeaderStyle BackColor="#FF9800" ForeColor="White" />
            </asp:GridView>
            <h3>Customers who bought this also bought:</h3>
<asp:GridView ID="gvRecommendations" runat="server"></asp:GridView>
            <!-- Summary -->
            <div class="cart-summary">
                <strong>Total: <asp:Label ID="lblTotal" runat="server" Text="$0.00" /></strong>
                <br />
                <asp:Button ID="btnClearCart" runat="server" Text="Clear Cart" CssClass="btn btn-clear" OnClick="btnClearCart_Click" />
                <asp:Button ID="btnCheckout" runat="server" Text="Checkout" CssClass="btn btn-checkout" OnClick="btnCheckout_Click" />
            </div>
            
            <asp:Label ID="lblMsg" runat="server" />
            <h3>Buy Again</h3>
<asp:GridView ID="gvReorder" runat="server"></asp:GridView>

            <div class="button-group">
                <asp:Button ID="btnBack" runat="server" Text="Back to Main" CssClass="btn btn-back" OnClick="btnBack_Click" />
            </div>
            <br /><br />
           
        </div>
    </form>
</body>
</html>