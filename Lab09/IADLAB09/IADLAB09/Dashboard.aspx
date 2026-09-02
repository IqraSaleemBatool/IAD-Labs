<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Dashboard.aspx.cs" Inherits="SurveySystem.Dashboard" %>

<!DOCTYPE html>
<html>
<head runat="server">
    <title>Dashboard</title>

    <style>
        body 
        {
            font-family: Arial;
            background: #f3f2f2;
        }

        .box 
        {
            width: 650px;
            margin: 50px auto;
            background: white;
            padding: 20px;
            border-radius: 10px;
        }

        .menu a 
        {
            display: block;
            padding: 10px;
            margin: 8px 0;
            background: #808080;
            color: white;
            text-decoration: none;
            border-radius: 5px;
        }

        .menu a:hover 
        {
            background: #4CAB50;
        }

        .logout 
        {
            float: right;
            background: red;
            color: white;
            border: none;
            padding: 8px;
            cursor: pointer;
        }
    </style>
</head>

<body>
<form runat="server">

<div class="box">

    <!-- Logout Button -->
    <asp:Button ID="btnLogout" runat="server" Text="Logout"
        CssClass="logout" OnClick="btnLogout_Click" />

    <h2>Survey Management Dashboard</h2>

    <!-- User's Info -->
    <p>
        <b>User:</b> <asp:Label ID="lblUser" runat="server"></asp:Label><br />
        <b>Role:</b> <asp:Label ID="lblRole" runat="server"></asp:Label>
    </p>

    <hr />

    <!-- Admin tasks -->
    <asp:Panel ID="pnlAdmin" runat="server" Visible="false">
        <h3>Admin Panel</h3>
        <div class="menu">
       <a href="ResultAnalysis.aspx">View Results</a>
        </div>
    </asp:Panel>

    <!-- Builder Tasks -->
    <asp:Panel ID="pnlBuilder" runat="server" Visible="false">
        <h3>Survey Builder</h3>
        <div class="menu">
            <a href="CreateSurvey.aspx">Create Survey</a>
            <a href="AddSurveyQuestions.aspx">Add Questions</a>
            <a href="ResultAnalysis.aspx">View Results</a>
        </div>
    </asp:Panel>

    <!-- Surveyor Tasks -->
    <asp:Panel ID="pnlSurveyor" runat="server" Visible="false">
        <h3>Surveyor</h3>
        <div class="menu">
            <a href="SurveyList.aspx">Take Survey</a>
        </div>
    </asp:Panel>

</div>

</form>
</body>
</html>