using System;

namespace PVFC
{
    public partial class AdminDashboard : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            CheckAccess(new string[] { "Admin" });
        }
        protected void btnLogout_Click(object sender, EventArgs e)
        {
            Session.Clear();
            Session.Abandon();
            Response.Redirect("Login.aspx");
        }

    }


}