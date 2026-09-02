<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Checkout.aspx.cs" Inherits="PVFC.Checkout" %>

<!DOCTYPE html>
<html>
<head runat="server">
    <title>Checkout - Payment</title>
    <style>
        body { font-family: Arial; margin: 20px; background: #f5f5f5; }
        .container { max-width: 800px; margin: auto; background: white; padding: 20px; border: 1px solid #ddd; border-radius: 10px; }
        h2 { color: #333; border-bottom: 2px solid #4CAF50; padding-bottom: 10px; }
        h3 { color: #4CAF50; }
        table { width: 100%; border-collapse: collapse; margin: 15px 0; }
        th { background: #4CAF50; color: white; padding: 8px; text-align: left; }
        td { padding: 8px; border: 1px solid #ddd; }
        .summary { background: #e8f5e9; padding: 10px; text-align: right; margin: 15px 0; }
        .payment-box { background: #f9f9f9; padding: 15px; border: 1px solid #ddd; margin: 15px 0; border-radius: 5px; }
        .payment-box label { display: inline-block; width: 120px; font-weight: bold; }
        .payment-box input, .payment-box select { padding: 6px; margin: 5px 0; width: 200px; }
        .btn { padding: 8px 20px; margin: 5px; cursor: pointer; border: none; border-radius: 3px; color: white; }
        .btn-confirm { background: #4CAF50; font-size: 16px; }
        .btn-back { background: #666; }
        .btn-pay { background: #2196F3; }
        .confirm-box { background: #e3f2fd; padding: 15px; text-align: center; margin: 15px 0; border: 1px solid #2196F3; border-radius: 5px; }
        .success { background: #e8f5e9; border: 1px solid #4CAF50; color: #2e7d32; padding: 8px; }
        .error { background: #ffebee; border: 1px solid #f44336; color: #c62828; padding: 8px; }
        .button-group { text-align: center; margin-top: 20px; padding-top: 20px; border-top: 1px solid #ddd; }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="container">
            <h2>Checkout & Payment</h2>
            
            <h3>Order Summary</h3>
            <asp:GridView ID="gvOrder" runat="server" AutoGenerateColumns="False" Width="100%">
                <Columns>
                    <asp:BoundField DataField="Product_Name" HeaderText="Product" />
                    <asp:BoundField DataField="Price" HeaderText="Price" DataFormatString="{0:C2}" />
                    <asp:BoundField DataField="Quantity" HeaderText="Qty" />
                    <asp:BoundField DataField="Total" HeaderText="Total" DataFormatString="{0:C2}" />
                </Columns>
                <HeaderStyle BackColor="#4CAF50" ForeColor="White" />
            </asp:GridView>
            
            <div class="summary">
                <strong>Grand Total: <asp:Label ID="lblTotal" runat="server" Text="$0.00" /></strong>
            </div>
            
            <!-- Payment Section -->
            <div class="payment-box" id="paymentBox" runat="server" visible="true">
                <h3>Payment Details</h3>
                <label>Payment Method:</label>
                <asp:DropDownList ID="ddlPaymentMethod" runat="server">
                    <asp:ListItem Text="-- Select Payment Method --" Value="" />
                    <asp:ListItem Text="Cash on Delivery" Value="Cash" />
                    <asp:ListItem Text="Credit Card" Value="Credit Card" />
                    <asp:ListItem Text="Debit Card" Value="Debit Card" />
                    <asp:ListItem Text="Online Banking" Value="Online Banking" />
                </asp:DropDownList>
                <br />
                
                <label>Card/Account Number:</label>
                <asp:TextBox ID="txtAccountNo" runat="server" placeholder="Enter card/account number" />
                <br />
                
                <label>Name on Card:</label>
                <asp:TextBox ID="txtCardName" runat="server" placeholder="Enter name" />
                <br />
                
                <div id="cardDetails" runat="server">
                    <label>Expiry Date:</label>
                    <asp:TextBox ID="txtExpiry" runat="server" placeholder="MM/YY" />
                    <br />
                    
                    <label>CVV:</label>
                    <asp:TextBox ID="txtCVV" runat="server" TextMode="Password" placeholder="123" Width="80px" />
                    <br />
                </div>
            </div>
            
            <!-- Confirmation Box -->
            <div id="confirmBox" runat="server" class="confirm-box" visible="false">
                <h3>Order Confirmed & Payment Successful!</h3>
                <p>Order ID: <strong><asp:Label ID="lblOrderId" runat="server" /></strong></p>
                <p>Payment Method: <strong><asp:Label ID="lblPaymentMethod" runat="server" /></strong></p>
                <p>Total Amount: <strong><asp:Label ID="lblPaidAmount" runat="server" /></strong></p>
                <p>Thank you for your purchase!</p>
            </div>
            
            <asp:Label ID="lblMsg" runat="server" />
            
            <div class="button-group">
                <asp:Button ID="btnConfirm" runat="server" Text="Confirm Order & Pay" CssClass="btn btn-confirm" OnClick="btnConfirm_Click" />
                <asp:Button ID="btnBack" runat="server" Text="Back to Cart" CssClass="btn btn-back" OnClick="btnBack_Click" />
                <asp:Button ID="btnContinue" runat="server" Text="Continue Shopping" CssClass="btn btn-back" OnClick="btnContinue_Click" Visible="false" />
            </div>
        </div>
    </form>
</body>
</html>