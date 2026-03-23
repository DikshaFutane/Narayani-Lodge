using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Admin_PendingBookings : System.Web.UI.Page
{
    string cs = ConfigurationManager.ConnectionStrings["Lodge"].ConnectionString;

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            LoadPendingBookings();
        }
    }

    private void LoadPendingBookings()
    {
        using (SqlConnection con = new SqlConnection(cs))
        {
            string query = "SELECT * FROM Bookings WHERE BookingStatus = 'Pending' ORDER BY BookingDate DESC";

            using (SqlDataAdapter da = new SqlDataAdapter(query, con))
            {
                DataTable dt = new DataTable();
                da.Fill(dt);

                gvPendingBookings.DataSource = dt;
                gvPendingBookings.DataBind();
            }
        }
    }

    protected void gvPendingBookings_PageIndexChanging(object sender, System.Web.UI.WebControls.GridViewPageEventArgs e)
    {
        gvPendingBookings.PageIndex = e.NewPageIndex;
        LoadPendingBookings();
    }

    protected void gvPendingBookings_RowCommand(object sender, System.Web.UI.WebControls.GridViewCommandEventArgs e)
    {
        int bookingId = Convert.ToInt32(e.CommandArgument);

        if (e.CommandName == "ViewBooking") // Approve
        {
            UpdateBookingStatus(bookingId, "Confirmed");
        }
        else if (e.CommandName == "EditBooking") // Cancel
        {
            UpdateBookingStatus(bookingId, "Cancelled");
        }

        LoadPendingBookings(); // Refresh grid
    }

    private void UpdateBookingStatus(int bookingId, string status)
    {
        using (SqlConnection con = new SqlConnection(cs))
        {
            string query = "";

            if (status == "Cancelled")
            {
                query = @"UPDATE Bookings 
                      SET BookingStatus = @Status,
                          CancellationDate = GETDATE()
                      WHERE BookingId = @BookingId";
            }
            else
            {
                query = @"UPDATE Bookings 
                      SET BookingStatus = @Status
                      WHERE BookingId = @BookingId";
            }

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