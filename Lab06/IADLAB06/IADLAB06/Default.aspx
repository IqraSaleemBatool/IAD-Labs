<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="PVFC._Default" %>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>My WEBSITE</title>
    <style>
        .linkStyle { display: inline-block; margin: 10px 0; }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <h2>Role Base Access Control</h2>
        <asp:HyperLink ID="lnkTask1Problem" runat="server"
            NavigateUrl="Problem_Statement.txt"
            CssClass="linkStyle">Problem Statement</asp:HyperLink><br />

        <asp:HyperLink ID="lnkTask1Report" runat="server"
            NavigateUrl="Code_Implementation_Report.pdf"
            CssClass="linkStyle">Code Implementation Report</asp:HyperLink><br />

        <asp:HyperLink ID="lnkTask1Output" runat="server"
            NavigateUrl="Sample_Output.pdf"
            CssClass="linkStyle">Sample Output</asp:HyperLink><br />

        <asp:HyperLink ID="lnkTask1Demo" runat="server"
            NavigateUrl="login.aspx"
            CssClass="linkStyle">Demonstration Page</asp:HyperLink><br />
    </form>
</body>
</html>
