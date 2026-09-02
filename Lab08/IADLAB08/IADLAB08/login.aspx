<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="QuizManagementSystem.Login" %>

<!DOCTYPE html>
<html>
<head runat="server">
    <title>Quiz System - Login</title>

    <style>
        body {
            font-family: Arial;
            background: linear-gradient(135deg, #667eea, #764ba2);
            margin: 0;
            padding: 50px;
        }

        .login-box {
            width: 380px;
            background: white;
            margin: 100px auto;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 10px 25px rgba(0,0,0,0.3);
        }

        h2 {
            text-align: center;
            margin-bottom: 25px;
        }

        .input-group {
            margin-bottom: 15px;
        }

        label {
            font-weight: bold;
        }

        input {
            width: 100%;
            padding: 10px;
            margin-top: 5px;
        }

        .btn-login {
            width: 100%;
            padding: 12px;
            background: #4CAF50;
            color: white;
            border: none;
            cursor: pointer;
        }

        .btn-login:hover {
            background: #667eea;
        }

        .error {
            color: red;
            text-align: center;
            margin-top: 10px;
        }
    </style>
</head>

<body>
<form runat="server">

<div class="login-box">

    <h2>Quiz Management System</h2>

    <div class="input-group">
        <label>Username</label>
        <asp:TextBox ID="txtUsername" runat="server"></asp:TextBox>
    </div>

    <div class="input-group">
        <label>Password</label>
        <asp:TextBox ID="txtPassword" runat="server" TextMode="Password"></asp:TextBox>
    </div>

    <asp:Button ID="btnLogin" runat="server" Text="Login" CssClass="btn-login" OnClick="btnLogin_Click" />

    <asp:Label ID="lblError" runat="server" CssClass="error"></asp:Label>

    <div style="margin-top:15px; font-size:12px; text-align:center;">
        <b> Accounts For Test:</b><br />
        Username:admin      Password:admin345<br />
        Username:teacher1   Password:teacher345<br />
        Username:student1   Password:student345
    </div>

</div>

</form>
</body>
</html>