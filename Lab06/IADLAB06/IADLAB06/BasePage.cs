using System;
using System.Web.UI;

namespace PVFC
{
    public class BasePage : Page
    {
        protected void CheckAccess(string[] allowedRoles)
        {
            if (Session["Role"] == null)
            {
                Response.Redirect("Login.aspx");
                return;
            }

            string role = Session["Role"].ToString();

            bool allowed = false;

            foreach (string r in allowedRoles)
            {
                if (r == role)
                {
                    allowed = true;
                    break;
                }
            }

            if (!allowed)
            {
                Response.Write("Access Denied!");
                Response.End();
            }
        }
        protected void RedirectToDashboard()
        {
            if (Session["Role"] == null)
            {
                Response.Redirect("Login.aspx");
                return;
            }

            string role = Session["Role"].ToString();

            switch (role)
            {
                case "Admin":
                    Response.Redirect("AdminDashboard.aspx");
                    break;

                case "Manager":
                    Response.Redirect("ManagerDashboard.aspx");
                    break;

                case "Salesperson":
                    Response.Redirect("SalesDashboard.aspx");
                    break;

                case "Customer":
                    Response.Redirect("Login.aspx");
                    break;

                default:
                    Response.Redirect("Login.aspx");
                    break;
            }
        }
    }
}