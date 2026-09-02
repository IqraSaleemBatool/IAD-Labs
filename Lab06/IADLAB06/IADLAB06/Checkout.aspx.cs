using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;

namespace PVFC
{
    public partial class Checkout : BasePage
    {
        string connStr = ConfigurationManager.ConnectionStrings["PVFCConnectionString"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            // Security check - only logged in users can access checkout
            if (Session["UserID"] == null)
            {
                Response.Redirect("Login.aspx");
                return;
            }

            if (!IsPostBack)
            {
                LoadOrder();
            }
        }

        private void LoadOrder()
        {
            DataTable cart = Session["CheckoutCart"] as DataTable;
            if (cart == null || cart.Rows.Count == 0)
            {
                Response.Redirect("CustomerDashboard.aspx");
                return;
            }

            DataTable display = new DataTable();
            display.Columns.Add("Product_Name");
            display.Columns.Add("Price");
            display.Columns.Add("Quantity");
            display.Columns.Add("Total");

            decimal total = 0;
            foreach (DataRow row in cart.Rows)
            {
                display.Rows.Add(row["Product_Name"], row["Price"], row["Quantity"], row["Total"]);
                total += Convert.ToDecimal(row["Total"]);
            }

            gvOrder.DataSource = display;
            gvOrder.DataBind();
            lblTotal.Text = "$" + total.ToString("N2");
        }

        protected void btnConfirm_Click(object sender, EventArgs e)
        {
            DataTable cart = Session["CheckoutCart"] as DataTable;
            if (cart == null || cart.Rows.Count == 0)
            {
                ShowMessage("No items to order!", "error");
                return;
            }

            // Validate payment
            if (string.IsNullOrEmpty(ddlPaymentMethod.SelectedValue))
            {
                ShowMessage("Please select a payment method!", "error");
                return;
            }

            if (string.IsNullOrEmpty(txtAccountNo.Text))
            {
                ShowMessage("Please enter account/card number!", "error");
                return;
            }

            if (Session["UserID"] == null)
            {
                Response.Redirect("Login.aspx");
                return;
            }

            try
            {
                using (SqlConnection con = new SqlConnection(connStr))
                {
                    con.Open();
                    SqlTransaction trans = con.BeginTransaction();

                    try
                    {
                        int userId = Convert.ToInt32(Session["UserID"]);

                        // Insert order
                        SqlCommand cmdOrder = new SqlCommand(
                            "INSERT INTO Orders_t (UserID, Order_Date) OUTPUT INSERTED.Order_Id VALUES (@uid, GETDATE())",
                            con, trans);
                        cmdOrder.Parameters.AddWithValue("@uid", userId);
                        int orderId = Convert.ToInt32(cmdOrder.ExecuteScalar());

                        // Insert order items
                        foreach (DataRow row in cart.Rows)
                        {
                            SqlCommand cmdItem = new SqlCommand(
                                "INSERT INTO Order_line_t (Order_Id, Product_Id, Ordered_Quantity) VALUES (@oid, @pid, @qty)",
                                con, trans);
                            cmdItem.Parameters.AddWithValue("@oid", orderId);
                            cmdItem.Parameters.AddWithValue("@pid", row["Product_Id"]);
                            cmdItem.Parameters.AddWithValue("@qty", row["Quantity"]);
                            cmdItem.ExecuteNonQuery();
                        }

                        trans.Commit();

                        // Show confirmation with payment details
                        lblOrderId.Text = orderId.ToString();
                        lblPaymentMethod.Text = ddlPaymentMethod.SelectedItem.Text;
                        lblPaidAmount.Text = lblTotal.Text;

                        paymentBox.Visible = false;
                        confirmBox.Visible = true;
                        btnConfirm.Visible = false;
                        btnBack.Visible = false;
                        btnContinue.Visible = true;

                        // Clear carts
                        Session["Cart"] = null;
                        Session["CheckoutCart"] = null;

                        ShowMessage("Order placed successfully! Order ID: " + orderId, "success");
                    }
                    catch
                    {
                        trans.Rollback();
                        throw;
                    }
                }
            }
            catch (Exception ex)
            {
                ShowMessage("Error: " + ex.Message, "error");
            }
        }

        protected void btnBack_Click(object sender, EventArgs e)
        {
            Response.Redirect("CustomerDashboard.aspx");
        }

        protected void btnContinue_Click(object sender, EventArgs e)
        {
            Response.Redirect("CustomerDashboard.aspx");
        }

        private void ShowMessage(string msg, string type)
        {
            lblMsg.Text = msg;
            lblMsg.CssClass = type;
        }
    }
}