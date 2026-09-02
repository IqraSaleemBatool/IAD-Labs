<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Dashboard.aspx.cs"
    Inherits="QuizManagementSystem.Dashboard" %>

<!DOCTYPE html>
<html>
<head runat="server">
    <title>Dashboard</title>

    <style>
        body {
            font-family: Arial;
            background: #f2f2f2;
        }

        .box {
            width: 650px;
            margin: 50px auto;
            background: white;
            padding: 20px;
            border-radius: 10px;
        }

        .menu a {
            display: block;
            padding: 10px;
            margin: 8px 0;
            background: #667eea;
            color: white;
            text-decoration: none;
            border-radius: 5px;
        }

        .menu a:hover {
            background: #4CAF50;
        }

        .logout {
            float: right;
            background: red;
            color: white;
            border: none;
            padding: 8px;
            cursor: pointer;
        }

        h3 {
            margin-top: 20px;
        }
    </style>

</head>
<body>

<form id="form1" runat="server">

<div class="box">

    <asp:Button ID="btnLogout" runat="server" Text="Logout"
        CssClass="logout" OnClick="btnLogout_Click" />

    <h2>Welcome</h2>

    <p>
        <b>User:</b>
        <asp:Label ID="lblUser" runat="server"></asp:Label>
        <br />
        <b>Role:</b>
        <asp:Label ID="lblRole" runat="server"></asp:Label>
    </p>

    <hr />

    <!-- Teacher's Tasks -->
    <asp:Panel ID="pnlTeacher" runat="server" Visible="false">
        <h3>Teacher Menu</h3>

        <div class="menu">
            <a href="AddQuestion.aspx"> Add Questions</a>
            <a href="CreateQuiz.aspx"> Create Quiz</a>
            <a href="TeacherResults.aspx">View Student Results</a>
        </div>
    </asp:Panel>

    <!--  Student's Task-->
    <asp:Panel ID="pnlStudent" runat="server" Visible="false">
        <h3>Student Menu</h3>

        <div class="menu">
            
            <a href="StudentQuiz.aspx"> Take Quiz</a>
            <a href="QuizResult.aspx"> My Results</a>
        </div>
    </asp:Panel>

    <!-- Admin's task -->
    <asp:Panel ID="pnlAdmin" runat="server" Visible="false">
        <h3>Admin Menu</h3>

        <div class="menu">
            <a href="AddUsers.aspx">Add Users</a>
            <a href="AddSubject.aspx">Add Subjects</a>
        </div>
    </asp:Panel>

</div>

</form>

</body>
</html>