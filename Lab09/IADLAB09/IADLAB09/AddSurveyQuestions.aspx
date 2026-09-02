<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AddSurveyQuestions.aspx.cs" Inherits="SurveySystem.AddSurveyQuestions" %>

<!DOCTYPE html>
<html>
<head runat="server">
    <title>Add Survey Questions</title>

    <style>
        body { font-family: Arial; background:#f2f2f2; }

        .container {
            width: 550px;
            margin: 50px auto;
            background: white;
            padding: 25px;
            border-radius: 10px;
            box-shadow: 0px 0px 10px #ccc;
        }

        h2 
        { 
            text-align:center; 

        }

        label 
        { 
            font-weight:bold; 

        }

        input, select 
        {
            width: 100%;
            padding: 10px;
            margin: 8px 0;
        }

        .btn 
        {
            width: 100%;
            padding: 10px;
            background: #668ffa;
            color: white;
            border: none;
            cursor: pointer;
            border-radius: 5px;
        }

        .btn:hover 
        { 
            background:#4BAF50; 

        }

        .msg 
        { 
            text-align:center; 
            margin-top:10px; 

        }
        .btnBack 
        {
           background: #668ffa;
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

    <h2>Add Question</h2>

    <label>Survey</label>
    <asp:DropDownList ID="ddlSurvey" runat="server"></asp:DropDownList>

    <label>Question</label>
    <asp:TextBox ID="txtQ" runat="server"></asp:TextBox>

    <label>Type</label>
    <asp:DropDownList ID="ddlType" runat="server" AutoPostBack="true" OnSelectedIndexChanged="ddlType_SelectedIndexChanged">
        <asp:ListItem>MCQ</asp:ListItem>
        <asp:ListItem>TF</asp:ListItem>
    </asp:DropDownList>

    <!-- MCQ OPTIONS -->
    <asp:Panel ID="pnlMCQ" runat="server">
        <label>Option A</label>
        <asp:TextBox ID="txtA" runat="server"></asp:TextBox>

        <label>Option B</label>
        <asp:TextBox ID="txtB" runat="server"></asp:TextBox>

        <label>Option C</label>
        <asp:TextBox ID="txtC" runat="server"></asp:TextBox>
    </asp:Panel>

    <!-- TF -->
    <asp:Panel ID="pnlTF" runat="server" Visible="false">
        <p><b>Options:</b> True / False</p>
    </asp:Panel>

    <asp:Button ID="btnSave" runat="server"
        Text="Save Question"
        CssClass="btn"
        OnClick="btnSave_Click" />

    <asp:Label ID="lblMsg" runat="server" CssClass="msg"></asp:Label>
    <asp:Button ID="btnBack" runat="server"
    Text="Back to Dashboard"
    CssClass="btnBack"
    OnClick="btnBack_Click" />
</div>

</form>
</body>
</html>