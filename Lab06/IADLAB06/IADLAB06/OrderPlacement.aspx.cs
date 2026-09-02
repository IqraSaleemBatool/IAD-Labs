using System;
using System.Configuration;
using System.Data.SqlClient;

namespace PVFC
{
    public partial class OrderPlacement : BasePage
    {
        string connectionString = ConfigurationManager.ConnectionStrings["PVFCConnectionString"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["UserID"] == null)
            {
                Response.Redirect("Login.aspx");
                return;
            }

            if (!IsPostBack)
            {
                if (Session["SelectedProduct"] == null)
                {
                    Response.Redirect("CustomerDashboard.aspx");
                    return;
                }

                lblProduct.Text = "Selected Product ID: " + Session["SelectedProduct"].ToString();
            }
        }

        protected void btnConfirm_Click(object sender, EventArgs e)
        {
            try
            {
                if (Session["SelectedProduct"] == null || Session["UserID"] == null)
                {
                    lblMsg.Text = "Invalid session.";
                    return;
                }

                int productId = Convert.ToInt32(Session["SelectedProduct"]);
                int quantity = Convert.ToInt32(txtQuantity.Text);
                int userId = Convert.ToInt32(Session["UserID"]);

                using (SqlConnection connect = new SqlConnection(connectionString))
                {
                    connect.Open();

                   
                    SqlCommand commandOrder = new SqlCommand("INSERT INTO Orders_t (UserID, Order_Date)"+
                        "OUTPUT INSERTED.Order_Id"+
                        "VALUES (@uid, GETDATE())", connect);

                    commandOrder.Parameters.AddWithValue("@uid", userId);

                    int orderId = Convert.ToInt32(commandOrder.ExecuteScalar());

                   
                    SqlCommand commandLine = new SqlCommand("INSERT INTO Order_line_t (Order_Id, Product_Id, Ordered_Quantity)"+
                        "VALUES (@oid, @pid, @qty)", connect);

                    commandLine.Parameters.AddWithValue("@oid", orderId);
                    commandLine.Parameters.AddWithValue("@pid", productId);
                    commandLine.Parameters.AddWithValue("@qty", quantity);

                    commandLine.ExecuteNonQuery();

                    Session["OrderID"] = orderId;

                    lblMsg.Text = "Order placed successfully!";
                    Response.Redirect("PaymentProvision.aspx");
                }
            }
            catch (Exception ex)
            {
                lblMsg.Text = ex.Message;
            }
        }
    }
}