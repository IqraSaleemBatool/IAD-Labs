<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="CreateQuiz.aspx.cs" Inherits="QuizManagementSystem.CreateQuiz" %>

<!DOCTYPE html>
<html>
<head runat="server">
    <title>Create Quiz</title>
    <style>
        body 
        { 
            font-family: Arial; 
            background: #f3f3f3; 

        }
        .navbar 
        { 
            background: #444; 
            color: white; 
            padding: 15px; 

        }
        
        .container 
        { 
            width: 600px; 
            margin: 50px auto; 
            background: white; 
            padding: 20px; 
            border-radius: 10px; 

        }
        .form-group 
        { 
            margin-bottom: 15px; 

        }
        label 
        { 
            font-weight: bold; 
            display: block; 
            margin-bottom: 5px; 

        }
        input, select 
        { 
            width: 100%; 
            padding: 8px; 
            border: 1px solid #ddd; 
            border-radius: 4px; 

        }
        .question-list 
        { 
            border: 1px solid #ddd; 
            padding: 10px; 
            height: 200px; 
            overflow-y: auto; 

        }
        .btn 
        { 
            padding: 10px 20px; 
            background: #28a745; 
            color: white; 
            border: none; 
            border-radius: 4px; 
            cursor: pointer; 

        }
        .checkbox-group 
        { 
            margin: 10px 0; 

        }
        .btnBack {
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
    <form id="form1" runat="server">
        <div class="navbar">
            <h2>Create Quiz</h2>
            
        </div>
        
        <div class="container">
            <asp:Label ID="lblMessage" runat="server" ForeColor="Red" Visible="false"></asp:Label>
            <div class="form-group">
                <label>Select Subject:</label>
                <asp:DropDownList ID="ddlSubject" runat="server" AutoPostBack="True" OnSelectedIndexChanged="ddlSubject_SelectedIndexChanged"></asp:DropDownList>
            </div>
            
            <div class="form-group">
                <label>Quiz Title:</label>
                <asp:TextBox ID="txtQuizTitle" runat="server"></asp:TextBox>
            </div>
            
            <div class="form-group">
                <label>Time Allowed (minutes):</label>
                <asp:TextBox ID="txtTimeAllowed" runat="server" TextMode="Number"></asp:TextBox>
            </div>
            
            <div class="checkbox-group">
                <asp:CheckBox ID="chkShuffleQuestions" runat="server" Text=" Shuffle Questions" />
            </div>
            
            <div class="checkbox-group">
                <asp:CheckBox ID="chkShuffleOptions" runat="server" Text=" Shuffle Options" />
            </div>
            
            <div class="checkbox-group">
                <asp:CheckBox ID="chkAttemptOnce" runat="server" Text=" Allow Only One Attempt" />
            </div>
            
            <div class="form-group">
                <label>Select Questions:</label>
                <div class="question-list">
                    <asp:CheckBoxList ID="cblQuestions" runat="server"></asp:CheckBoxList>
                </div>
            </div>
            
            <asp:Button ID="btnCreate" runat="server" Text="Create Quiz" CssClass="btn" OnClick="btnCreate_Click" />
            <asp:Button ID="btnBack" runat="server"
               Text="Back to Dashboard"
              OnClick="btnBack_Click"
         CssClass ="btnBack" />
        </div>
    </form>
</body>
</html>