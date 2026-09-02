<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="QuizResult.aspx.cs" Inherits="QuizManagementSystem.QuizResult" %>

<!DOCTYPE html>
<html>
<head runat="server">
    <title>Quiz Result</title>

    <style>
        body { font-family: Arial; background:#f3f3f3; }

        .container {
            width: 800px;
            margin: auto;
            background: white;
            padding: 20px;
            margin-top: 30px;
            border-radius: 10px;
        }

        h2 
        { 
            text-align: center; 

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

    <h2>Your Quiz Results</h2>

    <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="true"></asp:GridView>
<asp:Button ID="btnBack" runat="server"
Text="Back to Dashboard"
OnClick="btnBack_Click"
CssClass="btnBack" />
</div>
    
</form>

</body>
</html>