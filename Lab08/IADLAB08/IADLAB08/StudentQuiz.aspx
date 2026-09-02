<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="StudentQuiz.aspx.cs" Inherits="QuizManagementSystem.StudentQuiz" %>

<!DOCTYPE html>
<html>
<head runat="server">
    <title>Available Quizzes</title>

    <style>
        body {
            font-family: Arial;
            background: #f2f2f2;
        }

        .box {
            width: 700px;
            margin: 50px auto;
            background: white;
            padding: 20px;
            border-radius: 10px;
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

        table {
            width: 100%;
        }
    </style>

</head>

<body>

<form id="form1" runat="server">

<div class="box">

    <h2>Available Quizzes</h2>

    <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False"
        OnRowCommand="GridView1_RowCommand">

        <Columns>
            <asp:BoundField DataField="QuizID" HeaderText="ID" />
            <asp:BoundField DataField="Title" HeaderText="Quiz Title" />

            <asp:ButtonField Text="Start Quiz"
                CommandName="StartQuiz"
                ButtonType="Button" />
        </Columns>

    </asp:GridView>

    <br />

    <asp:Button ID="btnBack" runat="server"
        Text="Back to Dashboard"
        OnClick="btnBack_Click"
        CssClass="btnBack" />

</div>

</form>

</body>
</html>