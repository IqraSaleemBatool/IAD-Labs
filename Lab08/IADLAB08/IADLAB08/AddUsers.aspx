<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AddUsers.aspx.cs" Inherits="QuizManagementSystem.AddUser" %>

<!DOCTYPE html>
<html>
<head runat="server">
    <title>Add User</title>
    <style>
       
body 
{ 
    font-family: Arial; 
    background:#f4f4f4; 

}
.container 
{ 
    width:800px; 
    margin:auto; 
    background:white; 
    padding:20px; 
    margin-top:30px; 

}
h2 
{ 
    margin-bottom:20px; 

}
input, select 
{ 
    padding:8px; 
    margin:5px 0; 
    width:100%; 

}
button, .btn {
    background:#667ffa; 
    color:white; 
    padding:10px;
    border:none; 
    cursor:pointer; 
    margin-top:10px;
}
table 
{ 
    width:100%; 
    margin-top:20px; 
    border-collapse:collapse;

}
td, th 
{ 
    padding:10px; 
    border:1px solid #ccc; 

}
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

<h2>Add User</h2>

Username:
<asp:TextBox ID="txtUser" runat="server"></asp:TextBox><br /><br />

Password:
<asp:TextBox ID="txtPass" runat="server"></asp:TextBox><br /><br />

Role:
<asp:DropDownList ID="ddlRole" runat="server">
    <asp:ListItem>Admin</asp:ListItem>
    <asp:ListItem>Teacher</asp:ListItem>
    <asp:ListItem>Student</asp:ListItem>
</asp:DropDownList><br /><br />

<asp:Button ID="btnAdd" runat="server" Text="Add User" OnClick="btnAdd_Click" />

<asp:Label ID="lblMsg" runat="server"></asp:Label>
    <asp:Button ID="btnBack" runat="server"
    Text="Back to Dashboard"
    OnClick="btnBack_Click"
    CssClass="btnBack" />

</form>
</body>
</html>