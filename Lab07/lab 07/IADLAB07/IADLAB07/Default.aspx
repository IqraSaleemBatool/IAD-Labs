<%@ Page Language="C#" AutoEventWireup="true" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Lab 7 - Customer Segmentation</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 50px;
            background-color: #f5f5f5;
        }
        .container {
            max-width: 500px;
            margin: auto;
            background: white;
            padding: 30px;
            border: 1px solid #ddd;
            border-radius: 10px;
            text-align: center;
        }
        h1 {
            color: #4CAF50;
            border-bottom: 2px solid #4CAF50;
            padding-bottom: 10px;
        }
        .link {
            display: block;
            padding: 12px 20px;
            margin: 15px 0;
            background: #4CAF50;
            color: white;
            text-decoration: none;
            border-radius: 5px;
            font-size: 16px;
        }
        .link:hover {
            background: #45a049;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="container">
            <h1> Lab 7 - Customer Segmentation</h1>
            
            <a href="CustomerSegmentation.aspx" class="link">
                 Customer Segmentation Analysis
            </a>
            
            <a href="TargetedMarketing.aspx" class="link">
                 Targeted Marketing Automation
            </a>
            
            <hr />
           
        </div>
    </form>
</body>
</html>