<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="SurveySystem.Login" %>

<!DOCTYPE html>
<html>
<head runat="server">
    <title>Survey Management System - Login</title>

    <style>
        body 
        {
            font-family: Arial;
            background: linear-gradient(135deg, #667eea, #764ba2);
            margin: 0;
            padding: 50px;
        }

        .login-box 
        {
            width: 380px;
            background: white;
            margin: 100px auto;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 10px 25px rgba(0,0,0,0.3);
        }

        h2 
        {
            text-align: center;
            margin-bottom: 25px;
        }

        .txt 
        {
            width: 100%;
            padding: 10px;
            margin-top: 5px;
            margin-bottom: 15px;
        }

        .btn-login 
        {
            width: 100%;
            padding: 12px;
            background: #808080;
            color: white;
            border: none;
            cursor: pointer;
        }

        .btn-login:hover 
        {
            background: #00ffff;
        }

        .error 
        {
            color: red;
            text-align: center;
            margin-top: 10px;
        }
    </style>
</head>

<body>
<form id="form1" runat="server">

<div class="login-box">

    <h2>Survey System Login</h2>

    <label>Username</label>
    <asp:TextBox ID="txtUsername" runat="server" CssClass="txt"></asp:TextBox>

    <label>Password</label>
    <asp:TextBox ID="txtPassword" runat="server" TextMode="Password" CssClass="txt"></asp:TextBox>

    <asp:Button ID="btnLogin" runat="server"
        Text="Login"
        CssClass="btn-login"
        OnClick="btnLogin_Click" />

    <br />

    <asp:Label ID="lblError" runat="server" CssClass="error"></asp:Label>

    <div style="margin-top:15px; font-size:12px; text-align:center;">
        <b>Test Accounts:</b><br />
        Username:admin       Password:admin345<br />
        Username:builder1    Password:builder345<br />
        Useranme:user1       Password: user345
    </div>

</div>

</form>
</body>
</html>