<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="IADLAB08.Default" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <style>
        .linkStyle {
     display: block;
     margin: 10px 0;
     font-size: 16px;
 }
 body {
     font-family: Arial, sans-serif;
     margin: 40px;
     background-color: #f5f5f5;
 }
 .container {
     max-width: 700px;
     margin: auto;
     background: white;
     padding: 30px;
     border: 1px solid #ddd;
     border-radius: 8px;
 }
 h2 {
     color: #333;
     border-bottom: 2px solid #4CAF50;
     padding-bottom: 10px;
 }
 .footer {
     margin-top: 30px;
     padding-top: 15px;
     border-top: 1px solid #ddd;
     text-align: center;
     font-size: 12px;
     color: #666;
 }
</style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="container">
    <h2>Lab 08  Quiz Mnagement System </h2>
    
    <asp:HyperLink ID="lnkSegmentation" runat="server"
        NavigateUrl="login.aspx"
        CssClass="linkStyle">
        Demonstration Page
    </asp:HyperLink>
    
  
    <asp:HyperLink ID="lnkProblem" runat="server"
        NavigateUrl="Problem_Statement.txt"
        CssClass="linkStyle">
        Problem Statement
    </asp:HyperLink>
    
    <asp:HyperLink ID="lnkReport" runat="server"
        NavigateUrl="Code_Implementation_Report.pdf"
        CssClass="linkStyle">
        Code Implementation Report
    </asp:HyperLink>
    
    <asp:HyperLink ID="lnkOutput" runat="server"
        NavigateUrl="Sample_Output.pdf"
        CssClass="linkStyle">
        Sample Output
    </asp:HyperLink>
    
    
</div>
    </form>
</body>
</html>
