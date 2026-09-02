<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="SurveyList.aspx.cs" Inherits="SurveySystem.SurveyList" %>

<!DOCTYPE html>
<html>
<head runat="server">
    <title>Survey List</title>

    <style>
        body 
        { 
            font-family: Arial; 
            background:#f2f3f3; 

        }

        .container 
        {
            width: 700px;
            margin: 50px auto;
            background: white;
            padding: 25px;
            border-radius: 10px;
        }

        h2 
        { 
            text-align:center; 

        }

        table
        {
            width:100%;
            border-collapse:collapse;
        }

        th 
        {
            background:#808080;
            color:white;
        }

        td, th 
        {
            padding:10px;
            border:1px solid #ccc;
            text-align:center;
        }

        .btnStart 
        {
            padding:5px 10px;
            background:#00ff90;
            color:white;
            border:none;
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
          background: #555;
        }
    </style>
</head>

<body>
<form runat="server">

<div class="container">

    <h2>Available Surveys</h2>

    <asp:GridView ID="GridView1" runat="server"
        AutoGenerateColumns="False"
        OnRowCommand="GridView1_RowCommand">

        <Columns>
            <asp:BoundField DataField="SurveyID" HeaderText="ID" />
            <asp:BoundField DataField="Title" HeaderText="Title" />

            <asp:ButtonField Text="Start"
                CommandName="start" />
        </Columns>

    </asp:GridView>
    <asp:Button ID="btnBack" runat="server"
    Text="Back to Dashboard"
    CssClass="btnBack"
    OnClick="btnBack_Click" />
</div>

</form>
</body>
</html>