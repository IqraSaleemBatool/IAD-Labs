<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="task_01_product_search.aspx.cs" Inherits="PVFC.task_01_product_search" %>

<!DOCTYPE html>
<html>
<head runat="server">
    <title>Product Search</title>
    <style>
        body { 
            font-family: Arial, sans-serif;
               background-color: #f2f2f2; 

        }
        form 
        { 
            width: 800px; 
            margin: 40px auto; 
            padding: 25px; 
            background-color: white; 
            border: 1px solid #ccc; 

        }
        h2 
        { 
            text-align: center; 
            margin-bottom: 20px; 

        }
        input, select 
        { width: 200px; 
          padding: 5px; 
          margin-bottom: 15px; 

        }
        .btnSearch 
        { 
            padding: 6px 12px; 

        }
        #GridView1 
        { 
            margin-top: 20px; 
            width: 100%; 
            border-collapse: collapse; 

        }
        #GridView1 th, #GridView1 td 
        { 
            border: 1px solid #ccc; 
            padding: 5px; 
            text-align: left; 

        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <h2>Product Search</h2>

        <label>Enter Product Name:</label><br />
        <asp:TextBox ID="txtSearch" runat="server"></asp:TextBox><br />

        <asp:Button ID="btnSearch" runat="server" Text="Search Product" CssClass="btnSearch"
            OnClick="btnSearch_Click" /><br />

        <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="true"></asp:GridView>
    </form>
</body>
</html>