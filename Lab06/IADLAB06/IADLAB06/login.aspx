<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="PVFC.Login" %>

<!DOCTYPE html>
<html>
<head runat="server">
    <title>Login - PVFC System</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f0f0f0;
            margin: 0;
            padding: 20px;
        }
        .login-container {
            max-width: 450px;
            margin: 50px auto;
            background: white;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
        }
        h2 {
            text-align: center;
            color: #333;
            border-bottom: 2px solid #4CAF50;
            padding-bottom: 10px;
        }
        .demo-credentials {
            background: #e8f5e9;
            border: 1px solid #4CAF50;
            padding: 15px;
            margin: 20px 0;
            border-radius: 8px;
        }
        .demo-credentials h3 {
            margin: 0 0 10px 0;
            color: #2e7d32;
            font-size: 16px;
        }
        .demo-credentials table {
            width: 100%;
            font-size: 14px;
        }
        .demo-credentials td {
            padding: 5px;
        }
        .demo-credentials .role {
            font-weight: bold;
            color: #4CAF50;
        }
        input {
            width: 100%;
            padding: 10px;
            margin: 8px 0;
            border: 1px solid #ddd;
            border-radius: 4px;
            box-sizing: border-box;
        }
        .btn-login {
            width: 100%;
            padding: 10px;
            background: #4CAF50;
            color: white;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-size: 16px;
        }
        .btn-login:hover {
            background: #45a049;
        }
        .register-link {
            text-align: center;
            margin-top: 15px;
        }
        .register-link a {
            color: #4CAF50;
            text-decoration: none;
        }
        .error-msg {
            color: red;
            text-align: center;
            margin: 10px 0;
        }
        .info-msg {
            color: #2196F3;
            text-align: center;
            margin: 10px 0;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="login-container">
            <h2>PVFC Management System</h2>
            
         
            <div class="demo-credentials">
                <h3> Demo Credentials </h3>
                <table>
                    <tr>
                        <td class="role"> Admin:</td>
                        <td>Username: <strong>admin1</strong></td>
                        <td>Password: <strong>admin123</strong></td>
                    </tr>
                    <tr>
                        <td class="role"> Manager:</td>
                        <td>Username: <strong>manager1</strong></td>
                        <td>Password: <strong>manager123</strong></td>
                    </tr>
                    <tr>
                        <td class="role"> Salesperson:</td>
                        <td>Username: <strong>sales1</strong></td>
                        <td>Password: <strong>sales123</strong></td>
                    </tr>
                    <tr>
                        <td class="role"> Customer:</td>
                        <td>Username: <strong>laiba</strong></td>
                        <td>Password: <strong>laiba123</strong></td>
                    </tr>
                </table>
                <p style="font-size: 12px; color: #666; margin: 10px 0 0 0; text-align: center;">
                     Each role has different access permissions
                </p>
            </div>
            
            <asp:Label ID="lblMsg" runat="server" CssClass="error-msg" />
            
            <asp:TextBox ID="txtUser" runat="server" placeholder="Username" /><br />
            <asp:TextBox ID="txtPass" runat="server" TextMode="Password" placeholder="Password" /><br />
            
            <asp:Button ID="btnLogin" runat="server" Text="Login" CssClass="btn-login" OnClick="btnLogin_Click" />
            
            <div class="register-link">
                <a href="CustomerRegistration.aspx">New Customer? Register Here</a>
            </div>
        </div>
    </form>
</body>
</html>