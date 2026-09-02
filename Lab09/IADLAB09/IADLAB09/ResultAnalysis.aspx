<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ResultAnalysis.aspx.cs" Inherits="SurveySystem.ResultAnalysis" %>

<!DOCTYPE html>
<html>
<head runat="server">
    <title>Survey Results</title>

    <style>
    body 
    {
        font-family: Arial;
        background: #eff1f7;
        margin: 0;
        padding: 0;
    }

    .container 
    {
        width: 900px;
        margin: 40px auto;
        background: #eff;
        padding: 25px;
        border-radius: 12px;
        box-shadow: 0 8px 20px rgba(0,0,0,0.08);
    }

    h2 
    {
        text-align: center;
        color: #333;
        margin-bottom: 20px;
    }

    select 
    {
        width: 100%;
        padding: 10px;
        border-radius: 6px;
        border: 1px solid #ccc;
        margin-bottom: 10px;
    }

    .btn 
    {
        width: 100%;
        padding: 10px;
        background: #667eea;
        color: white;
        border: none;
        border-radius: 6px;
        cursor: pointer;
        margin-bottom: 20px;
        font-size: 15px;
    }

    .btn:hover 
    {
        background: #555;
    }

    .question-box 
    {
        margin-bottom: 20px;
        padding: 15px;
        border-left: 5px solid #00ffff;
        background: #f9f9f9;
        border-radius: 6px;
    }

    .question-box h3 
    {
        margin: 0 0 10px 0;
        color: #222;
    }

    .option 
    {
        padding: 6px 0;
        font-size: 14px;
    }

    .votes 
    {
        color: #668eea;
        font-weight: bold;
    }

    .btnBack
    {
        width: 100%;
        padding: 10px;
        background: #333;
        color: white;
        border: none;
        border-radius: 6px;
        cursor: pointer;
        margin-top: 10px;
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

    <h2>Survey Result Analysis</h2>

<asp:DropDownList ID="ddlSurvey" runat="server"></asp:DropDownList>

<asp:Button ID="btnLoad" runat="server"
    Text="Load Results"
    OnClick="btnLoad_Click" />

<hr />

<asp:Repeater ID="rptResults" runat="server">
    <ItemTemplate>

        <div style="margin-bottom:25px; padding:10px; border:1px solid #ccc;">
            <h3><%# Eval("QuestionText") %></h3>

            <asp:Repeater ID="rptOptions" runat="server"
                DataSource='<%# GetOptions(Eval("QuestionID")) %>'>

                <ItemTemplate>
                    <div>
                        <%# Eval("OptionText") %> :
                        <b><%# GetVotes(Eval("QuestionID"), Eval("OptionText")) %></b> votes
                    </div>
                </ItemTemplate>

            </asp:Repeater>

        </div>

    </ItemTemplate>
</asp:Repeater>

<asp:Button ID="btnBack" runat="server"
    Text="Back to Dashboard"
    OnClick="btnBack_Click" />

</div>

</form>
</body>
</html>