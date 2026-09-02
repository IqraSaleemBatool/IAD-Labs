using System;

namespace PVFC
{
    public partial class PaymentProvision : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Session["OrderID"] != null)
                {
                    txtOrderId.Text = Session["OrderID"].ToString();
                }
            }
        }

        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            lblOutput.Text = "Payment successful for Order ID: " + txtOrderId.Text;

            Session["OrderID"] = null;
            Session["SelectedProduct"] = null;

            RedirectToDashboard();
        }

        protected void btnCash_Click(object sender, EventArgs e)
        {
            lblOutput.Text = "Cash selected";
        }

        protected void btnOnline_Click(object sender, EventArgs e)
        {
            lblOutput.Text = "Online selected";
        }

        protected void btnOthers_Click(object sender, EventArgs e)
        {
            lblOutput.Text = "Other payment selected";
        }
    }
}