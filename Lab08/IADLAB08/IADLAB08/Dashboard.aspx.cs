using System;
using System.Web.UI;

namespace QuizManagementSystem
{
    public partial class Dashboard : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["UserID"] == null)
            {
                Response.Redirect("Login.aspx");
            }

            lblUser.Text = Session["UserName"].ToString();
            lblRole.Text = Session["Role"].ToString();

            if (!IsPostBack)
            {
                pnlTeacher.Visible = false;

                pnlStudent.Visible = false;

                pnlAdmin.Visible = false;

                string Role = Session["Role"].ToString();

                if (Role == "Teacher")
                    pnlTeacher.Visible = true;

                else if (Role == "Student")
                    pnlStudent.Visible = true;

                else if (Role == "Admin")
                    pnlAdmin.Visible = true;
            }
        }

        protected void btnLogout_Click(object sender, EventArgs e)
        {
            Session.Clear();
            Response.Redirect("Login.aspx");
        }
    }
}