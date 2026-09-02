using System;
using System.Web.UI;

namespace SurveySystem
{
    public partial class Dashboard : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // Login check
            if (Session["UserID"] == null)
            {
                Response.Redirect("Login.aspx");
                return;
            }

            if( Session["Role"] == null)
            {
                Response.Redirect("Login.aspx");
                return;
            }

            // Showing  user info
            lblUser.Text = Session["UserName"] != null
                ? Session["UserName"].ToString()
                : Session["UserID"].ToString();

            lblRole.Text = Session["Role"].ToString();

            if (!IsPostBack)
            {
                
                pnlAdmin.Visible = false;
                pnlBuilder.Visible = false;
                pnlSurveyor.Visible = false;

                string Role = Session["Role"].ToString();

                
                if (Role == "Admin")
                    pnlAdmin.Visible = true;

                else if (Role == "Builder")
                    pnlBuilder.Visible = true;

                else if (Role == "Surveyor")
                    pnlSurveyor.Visible = true;
            }
        }

        // Logout function
        protected void btnLogout_Click(object sender, EventArgs ex)
        {
            Session.Clear();
            Response.Redirect("Login.aspx");
        }
    }
}