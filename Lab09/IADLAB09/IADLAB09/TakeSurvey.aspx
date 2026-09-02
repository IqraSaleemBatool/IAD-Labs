<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="TakeSurvey.aspx.cs" Inherits="SurveySystem.TakeSurvey" %>

<!DOCTYPE html>
<html>
<head runat="server">
    <title>Take Survey</title>

    <style>
        body 
        { 
            font-family: Arial; 
            background:#f3f4f4; }

        .container 
        {
            width: 700px;
            margin: 40px auto;
            background: white;
            padding: 25px;
            border-radius: 10px;
        }

        .question 
        {
            margin-bottom: 20px;
            padding: 10px;
            border-bottom: 1px solid #ddd;
        }

        .btn 
        {
            width: 100%;
            padding: 12px;
            background: #667eea;
            color: white;
            border: none;
        }
        .btnBack 
        {
             background: #333;
            color: white;
            padding: 10px;
            border: none;
           margin-top: 15px;
             width: 100%;
           cursor: pointer;
             border-radius: 5px;
         }

        .btnBack:hover
        {
            background: #444;
         }
    </style>
</head>

<body>
<form runat="server">

<div class="container">

    <h2>Survey</h2>

    <asp:Repeater ID="rptQuestions" runat="server">
        <ItemTemplate>

            <div class="question">
                <b><%# Eval("QuestionText") %></b>

                <asp:RadioButtonList ID="rblOptions" runat="server"
                    DataSource='<%# GetOptions(Eval("QuestionID")) %>'
                    DataTextField="OptionText"
                    DataValueField="OptionText">
                </asp:RadioButtonList>

                <asp:HiddenField ID="hdQID" runat="server"
                    Value='<%# Eval("QuestionID") %>' />

            </div>

        </ItemTemplate>
    </asp:Repeater>

    <asp:Button ID="btnSubmit" runat="server"
        Text="Submit Survey"
        CssClass="btn"
        OnClick="btnSubmit_Click" />

    <asp:Label ID="lblMsg" runat="server"></asp:Label>
     <asp:Button ID="btnBack" runat="server"
Text="Back to Dashboard"
CssClass="btnBack"
OnClick="btnBack_Click" />
</div>

</form>
</body>
</html>