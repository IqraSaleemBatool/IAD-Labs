<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="WebApp._Default" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>My WEBSITE</title>

    <style>
        .linkStyle {
            display: inline-block;
            margin: 10px 0;
        }
    </style>
</head>
<body>

    <form id="form1" runat="server">

        <asp:HyperLink ID="lnkTask1Problem" runat="server"
            NavigateUrl="task_01_problem_statement.txt"
            CssClass="linkStyle">
            Task_01 Problem Statement
        </asp:HyperLink>
        <br />

        <asp:HyperLink ID="lnkTask1Report" runat="server"
            NavigateUrl="task_01_Code_Implementation_report.pdf"
            CssClass="linkStyle">
            Task_01 Code Implementation Report
        </asp:HyperLink>
        <br />

        <asp:HyperLink ID="lnkTask1Output" runat="server"
            NavigateUrl="task_01_sample_output.pdf"
            CssClass="linkStyle">
            Task_01 Sample Output
        </asp:HyperLink>
        <br />

        <asp:HyperLink ID="lnkTask1Demo" runat="server"
            NavigateUrl="task_01.aspx"
            CssClass="linkStyle">
            Task_01 Demonstration Page
        </asp:HyperLink>
        <br />

      


    </form>

</body>
</html>