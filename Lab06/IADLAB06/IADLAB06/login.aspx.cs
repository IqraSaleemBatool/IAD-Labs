using System;
using System.Data.SqlClient;
using System.Configuration;

namespace PVFC
{
    public partial class Login : System.Web.UI.Page
    {
        string connStr = ConfigurationManager.ConnectionStrings["PVFCConnectionString"].ConnectionString;

        protected void btnLogin_Click(object sender, EventArgs e)
        {
            using (SqlConnection connect = new SqlConnection(connStr))
            {
                connect.Open();

                
                SqlCommand command = new SqlCommand("SELECT UserID "+
                    "FROM Users "+
                    "WHERE Username=@u AND Password=@p AND IsActive=1", connect);

                command.Parameters.AddWithValue("@u", txtUser.Text);
                command.Parameters.AddWithValue("@p", txtPass.Text);

                object userId = command.ExecuteScalar();

                if (userId == null)
                {
                    lblMsg.Text = "Invalid username or password!";
                    return;
                }

                int uid = Convert.ToInt32(userId);

            
                Session["UserID"] = uid;

              
                SqlCommand commandRole = new SqlCommand("SELECT r.RoleName " +
                    "FROM UserRoles ur " +
                    "JOIN Roles r ON ur.RoleID = r.RoleID " +
                    "WHERE ur.UserID=@uid", connect);

                commandRole.Parameters.AddWithValue("@uid", uid);

                string Role = commandRole.ExecuteScalar()?.ToString();

                if (Role == null)
                {
                    lblMsg.Text = "No role assigned!";
                    return;
                }

                Session["Role"] = Role;

               
                if (Role == "Admin")
                {
                    Response.Redirect("AdminDashboard.aspx");
                }
                else if (Role == "Manager")
                {
                    Response.Redirect("ManagerDashboard.aspx");
                }
                else if (Role == "Salesperson")
                {
                    Response.Redirect("SalesDashboard.aspx");
                }
                else if (Role == "Customer")
                {
                    Response.Redirect("CustomerDashboard.aspx");
                }
                else
                {
                    lblMsg.Text = "Unknown role!";
                }
            }
        }
    }
}