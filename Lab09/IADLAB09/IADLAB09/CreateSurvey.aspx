<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="CreateSurvey.aspx.cs" Inherits="SurveySystem.CreateSurvey" %>

<!DOCTYPE html>
<html>
<head runat="server">
    <title>Create Survey</title>

    <style>
        body 
        { 
            font-family: Arial; 
            background:white; }

        .container 
        {
            width: 450px;
            margin: 80px auto;
            background: white;
            padding: 25px;
            border-radius: 10px;
        }

        h2 
        { 
            text-align:center; 

        }

        input 
        {
            width: 100%;
            padding: 10px;
            margin: 10px 0;
        }

        .btn 
        {
            width: 100%;
            padding: 10px;
            background:#655fea;
            color:white;
            border:none;
        }

        .btn:hover 
        { 
            background:#ffd800; 

        }

        .msg 
        { 
            text-align:center; 

        }
         .btnBack 
         {
            background: #444;
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

    <h2>Create Survey</h2>

    <label>Title</label>
    <asp:TextBox ID="txtTitle" runat="server"></asp:TextBox>

    <asp:Button ID="btnCreate" runat="server"
        Text="Create Survey"
        CssClass="btn"
        OnClick="btnCreate_Click" />

    <asp:Label ID="lblMsg" runat="server" CssClass="msg"></asp:Label>
    <asp:Button ID="btnBack" runat="server"
    Text="Back to Dashboard"
    CssClass="btnBack"
    OnClick="btnBack_Click" />
</div>

</form>
</body>
</html>