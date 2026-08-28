using System;

namespace PVFC
{
    public partial class task_01_payment_provision : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btnCash_Click(object sender, EventArgs e)
        {
            lblOutput.Text = "You selected Cash on Delivery.";
        }

        protected void btnOnline_Click(object sender, EventArgs e)
        {
            lblOutput.Text = "You selected Online Payment.";
        }

        protected void btnOthers_Click(object sender, EventArgs e)
        {
            lblOutput.Text = "You selected Other Payment Method.";
        }

        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            string account = txtAccount.Text;

            lblOutput.Text = "Payment submitted successfully using account: " + account;
        }
    }
}