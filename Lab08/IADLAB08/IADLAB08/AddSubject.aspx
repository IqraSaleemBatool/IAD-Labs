<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AddSubject.aspx.cs" Inherits="QuizManagementSystem.AddSubject" %>

<!DOCTYPE html>
<html>
<head runat="server">
    <title>Add Subject</title>

    <style>
        body {
            font-family: Arial;
            background: #f2f2f2;
        }

        .container {
            width: 500px;
            margin: 60px auto;
            background: white;
            padding: 25px;
            border-radius: 10px;
            box-shadow: 0px 0px 10px #ccc;
        }

        h2 {
            text-align: center;
            margin-bottom: 20px;
        }

        label {
            font-weight: bold;
        }

        .txt {
            width: 100%;
            padding: 10px;
            margin-top: 8px;
            margin-bottom: 15px;
            border: 1px solid #ccc;
            border-radius: 5px;
        }

        .btn {
            width: 100%;
            padding: 10px;
            background: #667eea;
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            margin-top: 10px;
        }

        .btn:hover {
            background: #5563d6;
        }

        .btnBack {
            width: 100%;
            padding: 10px;
            background: #333;
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            margin-top: 10px;
        }

        .btnBack:hover {
            background: #555;
        }

        .msg {
            text-align: center;
            margin-top: 10px;
            font-weight: bold;
        }
    </style>

</head>

<body>

<form id="form1" runat="server">

<div class="container">

    <h2>Add Subject</h2>

    <label>Subject Name</label>
    <asp:TextBox ID="txtSubject" runat="server" CssClass="txt"></asp:TextBox>

    <asp:Button ID="btnAdd" runat="server"
        Text="Add Subject"
        OnClick="btnAdd_Click"
        CssClass="btn" />

    <asp:Label ID="lblMsg" runat="server" CssClass="msg"></asp:Label>

    <asp:Button ID="btnBack" runat="server"
        Text="Back to Dashboard"
        OnClick="btnBack_Click"
        CssClass="btnBack" />

</div>

</form>

</body>
</html>