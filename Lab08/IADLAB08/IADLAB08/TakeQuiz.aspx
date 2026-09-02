<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="TakeQuiz.aspx.cs" Inherits="QuizManagementSystem.TakeQuiz" %>

<!DOCTYPE html>
<html>
<head runat="server">
    <title>Take Quiz</title>

    <style>
        body {
            font-family: Arial;
            background: #f3f3f3;
        }

        .container {
            width: 800px;
            margin: auto;
            background: white;
            padding: 25px;
            margin-top: 30px;
            border-radius: 10px;
        }

        h2 {
            text-align: center;
        }

        .question {
            font-size: 18px;
            margin-bottom: 20px;
            font-weight: bold;
        }

        .btn {
            background: #667eea;
            color: white;
            padding: 10px;
            border: none;
            cursor: pointer;
            margin-top: 15px;
            width: 100%;
        }

        .btn:hover {
            background: #5563d6;
        }

        table {
            width: 100%;
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
    </style>

</head>

<body>
<form id="form1" runat="server">

<div class="container">

    <h2>Take Quiz</h2>

    <asp:Label ID="lblTimer" runat="server" ForeColor="Red" Font-Bold="true" />

    <div class="question">
        <asp:Label ID="lblQ" runat="server"></asp:Label>
    </div>

    <asp:RadioButtonList ID="rblOptions" runat="server"></asp:RadioButtonList>

    <asp:Button ID="btnNext" runat="server" Text="Next"
        OnClick="btnNext_Click" CssClass="btn" />

    <br /><br />
    <asp:Label ID="lblMsg" runat="server" ForeColor="Green" />
    <asp:Button ID="btnBack" runat="server"
Text="Back to Dashboard"
OnClick="btnBack_Click"
CssClass="btnBack" />
</div>
    
</form>
</body>
</html>