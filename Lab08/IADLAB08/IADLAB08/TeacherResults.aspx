<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="TeacherResults.aspx.cs" Inherits="QuizManagementSystem.TeacherResults" %>

<!DOCTYPE html>
<html>
<head runat="server">
    <title>View Results</title>

    <style>
        body {
            font-family: Arial;
            background: #f3f3f3;
        }

        .container {
            width: 900px;
            margin: auto;
            background: white;
            padding: 25px;
            margin-top: 30px;
            border-radius: 10px;
        }

        h2 {
            text-align: center;
        }

        table {
            width: 100%;
            margin-top: 20px;
            border-collapse: collapse;
        }

        td, th {
            padding: 10px;
            border: 1px solid #ccc;
            text-align: center;
        }

        th {
            background: #667eea;
            color: white;
        }
        .btnBack {
    background: #333;
    color: white;
    padding: 8px 12px;
    border: none;
    cursor: pointer;
    margin-bottom: 15px;
    border-radius: 5px;
    text-align: center;
    margin-top: 20px;
}

.btnBack:hover {
    background: #555;
}
    </style>

</head>

<body>

<form id="form1" runat="server">

<div class="container">

    <h2>All Student Results</h2>

    <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="true"></asp:GridView>
    <asp:Button ID="btnBack" runat="server"
Text="Back to Dashboard"
OnClick="btnBack_Click"
CssClass="btnBack" />
</div>
    
</form>

</body>
</html>