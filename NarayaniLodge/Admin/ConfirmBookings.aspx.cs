using System;
using System.Activities.Statements;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Admin_ConfirmBookings : System.Web.UI.Page
{
    string cs = ConfigurationManager.ConnectionStrings["Lodge"].ConnectionString;

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            LoadConfirmBookings();
        }
    }

    private void LoadConfirmBookings()
    {
        using (SqlConnection con = new SqlConnection(cs))
        {
            string query = "SELECT * FROM Bookings WHERE BookingStatus IN ('Confirmed', 'CheckedIn') ORDER BY BookingDate DESC";

            using (SqlDataAdapter da = new SqlDataAdapter(query, con))
            {
                DataTable dt = new DataTable();
                da.Fill(dt);

                gvConfirmedBookings.DataSource = dt;
                gvConfirmedBookings.DataBind();
            }
        }
    }

    private decimal GetRemainingAmount(int bookingId)
    {
        decimal remaining = 0;

        using (SqlConnection con = new SqlConnection(cs))
        {
            string query = "SELECT (TotalAmount - ISNULL(PaidAmount,0)) FROM Bookings WHERE BookingId = @BookingId";

            using (SqlCommand cmd = new SqlCommand(query, con))
            {
                cmd.Parameters.AddWithValue("@BookingId", bookingId);
                con.Open();

                object result = cmd.ExecuteScalar();
                if (result != null)
                {
                    remaining = Convert.ToDecimal(result);
                }
            }
        }

        return remaining;
    }

    protected void gvConfirmedBookings_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        gvConfirmedBookings.PageIndex = e.NewPageIndex;
        LoadConfirmBookings();
    }

    protected void gvConfirmedBookings_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            string status = DataBinder.Eval(e.Row.DataItem, "BookingStatus").ToString();

            Button btnCheckIn = (Button)e.Row.FindControl("btnCheckIn");
            Button btnComplete = (Button)e.Row.FindControl("btnComplete");

            if (status == "Confirmed")
            {
                btnComplete.Visible = false;
            }
            else if (status == "CheckedIn")
            {
                btnCheckIn.Visible = false;
            }
        }
    }

    protected void gvConfirmedBookings_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        int bookingId = Convert.ToInt32(e.CommandArgument);

        if (e.CommandName == "CheckIn")
        {
            UpdateBookingStatus(bookingId, "CheckedIn");
        }
        else if (e.CommandName == "Complete")
        {
            decimal remaining = GetRemainingAmount(bookingId);

            if (remaining > 0)
            {
                hfBookingId.Value = bookingId.ToString();
                lblRemaining.Text = remaining.ToString("0.00");

                pnlPaymentOverlay.Visible = true;
                return;
            }

            UpdateBookingStatus(bookingId, "Completed");
        }

        else if (e.CommandName == "CancelBooking")
        {
            UpdateBookingStatus(bookingId, "Cancelled");
        }

        LoadConfirmBookings();
    }

    protected void btnCollectPayment_Click(object sender, EventArgs e)
    {
        int bookingId = Convert.ToInt32(hfBookingId.Value);
        decimal collectAmount = Convert.ToDecimal(txtCollectAmount.Text);

        using (SqlConnection con = new SqlConnection(cs))
        {
            string query = "UPDATE Bookings SET PaidAmount = ISNULL(PaidAmount,0) + @Amount WHERE BookingId = @BookingId";

            using (SqlCommand cmd = new SqlCommand(query, con))
            {
                cmd.Parameters.AddWithValue("@Amount", collectAmount);
                cmd.Parameters.AddWithValue("@BookingId", bookingId);

                con.Open();
                cmd.ExecuteNonQuery();
            }
        }

        decimal remaining = GetRemainingAmount(bookingId);

        LoadConfirmBookings();

        if (remaining > 0)
        {
            lblRemaining.Text = remaining.ToString("0.00");

            ScriptManager.RegisterStartupScript(this, GetType(),
                "ReOpenModal",
                "var myModal = new bootstrap.Modal(document.getElementById('paymentModal')); myModal.show();",
                true);
        }
        else
        {
            UpdateBookingStatus(bookingId, "Completed");

            ScriptManager.RegisterStartupScript(this, GetType(),
                "CloseModal",
                "bootstrap.Modal.getInstance(document.getElementById('paymentModal')).hide();",
                true);
        }

        pnlPaymentOverlay.Visible = false;
        LoadConfirmBookings();
    }
    private void UpdateBookingStatus(int bookingId, string status)
    {
        using (SqlConnection con = new SqlConnection(cs))
        {
            string query = "UPDATE Bookings SET BookingStatus = @Status WHERE BookingId = @BookingId";

            using (SqlCommand cmd = new SqlCommand(query, con))
            {
                cmd.Parameters.AddWithValue("@Status", status);
                cmd.Parameters.AddWithValue("@BookingId", bookingId);

                con.Open();
                cmd.ExecuteNonQuery();
            }
        }
    }


    protected void btnClosePopup_Click(object sender, EventArgs e)
    {
        ScriptManager.RegisterStartupScript(this, GetType(),
            "CloseModal",
            "bootstrap.Modal.getInstance(document.getElementById('paymentModal')).hide();",
            true);
        Response.Redirect("ConfirmBookings.aspx");
    }

    private void UpdatePaymentStatus(int bookingId, string status)
    {
        using (SqlConnection con = new SqlConnection(cs))
        {
            string query = "UPDATE Bookings SET PaymentStatus = @Status WHERE BookingId = @BookingId";

            using (SqlCommand cmd = new SqlCommand(query, con))
            {
                cmd.Parameters.AddWithValue("@Status", status);
                cmd.Parameters.AddWithValue("@BookingId", bookingId);

                con.Open();
                cmd.ExecuteNonQuery();
            }
        }
    }
}