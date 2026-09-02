<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="task_01_payment_provision.aspx.cs" Inherits="PVFC.task_01_payment_provision" %>

<!DOCTYPE html>
<html>
<head runat="server">
<title>Payment Provision</title>

<style>

form{
width:420px;
margin:40px auto;
padding:25px;
border:1px solid #ccc;
background-color:white;
}

h2{
text-align:center;
}

input{
width:200px;
padding:5px;
}

button{
padding:6px 10px;
margin-right:5px;
}

</style>

</head>

<body>

<form id="form1" runat="server">

<h2>Payment Provision</h2>

Order ID:<br />
<asp:TextBox ID="txtOrderId" runat="server"></asp:TextBox>

<br /><br />

Account Number:<br />
<asp:TextBox ID="txtAccount" runat="server"></asp:TextBox>

<br /><br />

Payment Method:<br />

<asp:Button ID="btnCash"
runat="server"
Text="Cash"
OnClick="btnCash_Click" />

<asp:Button ID="btnOnline"
runat="server"
Text="Online"
OnClick="btnOnline_Click" />

<asp:Button ID="btnOthers"
runat="server"
Text="Others"
OnClick="btnOthers_Click" />

<br /><br />

<asp:Button ID="btnSubmit"
runat="server"
Text="Submit Payment"
OnClick="btnSubmit_Click" />

<br /><br />

<asp:Label ID="lblOutput"
runat="server"
ForeColor="Green"></asp:Label>

</form>

</body>
</html>