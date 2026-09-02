<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AddQuestions.aspx.cs" Inherits="QuizManagementSystem.AddQuestions" %>

<!DOCTYPE html>
<html>
<head runat="server">
    <title>Add Questions</title>

    <style>
        body { font-family: Arial; background:#f2f2f2; }

        .box {
            width: 500px;
            margin: 40px auto;
            background: white;
            padding: 20px;
            border-radius: 10px;
        }

        input, select {
            width: 100%;
            padding: 8px;
            margin: 5px 0;
        }

        .btn {
            background: #4CAF50;
            color: white;
            border: none;
            padding: 10px;
            width: 100%;
            cursor: pointer;
        }

        .btn:hover { background: #667eea; }

        .msg { color: red; }
        .btnBack 
        {
    background: #333;
    color: white;
    padding: 8px 12px;
    border: none;
    cursor: pointer;
    margin-bottom: 15px;
    border-radius: 5px;
}

.btnBack:hover {
    background: #555;
}
    </style>

</head>

<body>
<form runat="server">

<div class="box">

    <h2>Add Question</h2>

    <asp:Label ID="lblMsg" runat="server" CssClass="msg"></asp:Label>

    <br />

    <!-- Subject -->
    <asp:DropDownList ID="ddlSubject" runat="server"></asp:DropDownList>

    <!-- Question -->
    <asp:TextBox ID="txtQuestion" runat="server" placeholder="Enter Question"></asp:TextBox>

    <!-- Options -->
    <asp:TextBox ID="txtA" runat="server" placeholder="Option A"></asp:TextBox>
    <asp:TextBox ID="txtB" runat="server" placeholder="Option B"></asp:TextBox>
    <asp:TextBox ID="txtC" runat="server" placeholder="Option C"></asp:TextBox>
    <asp:TextBox ID="txtD" runat="server" placeholder="Option D"></asp:TextBox>

    <!-- Correct -->
    <asp:Label ID="lblInstruction" runat="server" Text="Select the correct option:" />
    <asp:DropDownList ID="ddlCorrect" runat="server">
        <asp:ListItem Value="A">Option A</asp:ListItem>
        <asp:ListItem Value="B">Option B</asp:ListItem>
        <asp:ListItem Value="C">Option C</asp:ListItem>
        <asp:ListItem Value="D">Option D</asp:ListItem>
    </asp:DropDownList>

    <asp:Button ID="btnSave" runat="server" Text="Save Question" CssClass="btn" OnClick="btnSave_Click" />

    <asp:Button ID="btnBack" runat="server"
    Text="Back to Dashboard"
    OnClick="btnBack_Click"
    CssClass="btnBack" />
</div>

</form>
</body>
</html>