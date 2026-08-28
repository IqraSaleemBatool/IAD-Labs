<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="CustomerRegistration.aspx.cs" Inherits="PVFC.CustomerRegistration" %>

<!DOCTYPE html>
<html>
<head runat="server">
    <title>Customer Registration</title>
    <style>
          .btn-back {
      background: #666;
      margin-top: 20px;
  }
    </style>
</head>
    
<body>
<form id="form1" runat="server">
    <h2>New Customer Registration</h2>

    Customer ID:<br />
    <asp:TextBox ID="txtId" runat="server" /><br /><br />

    Customer Name:<br />
    <asp:TextBox ID="txtName" runat="server" /><br /><br />

    Address:<br />
    <asp:TextBox ID="txtAddress" runat="server" /><br /><br />

    State:<br />
    <asp:TextBox ID="txtState" runat="server" /><br /><br />

    City:<br />
    <asp:DropDownList ID="ddlCity" runat="server" AutoPostBack="true"
        OnSelectedIndexChanged="ddlCity_SelectedIndexChanged">
        <asp:ListItem Text="Lahore" Value="54000" />
        <asp:ListItem Text="Karachi" Value="74000" />
        <asp:ListItem Text="Islamabad" Value="44000" />
        <asp:ListItem Text="Rawalpindi" Value="46000" />
    </asp:DropDownList><br /><br />

    Postal Code:<br />
    <asp:TextBox ID="txtPostal" runat="server" ReadOnly="true" /><br /><br />

    <asp:Button ID="btnRegister" runat="server"
        Text="Register Customer"
        OnClick="btnRegister_Click" />

    <br /><br />
    <asp:Label ID="lblMsg" runat="server" ForeColor="Green" />
    <div class="button-group">
    <asp:Button ID="btnBack" runat="server" Text=" Back to Main Page" CssClass="btn btn-back" OnClick="btnBack_Click" />
</div>
</form>
</body>
</html>