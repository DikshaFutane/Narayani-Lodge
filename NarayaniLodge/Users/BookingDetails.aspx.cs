using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Users_BookingDetails : System.Web.UI.Page
{
    string cs = ConfigurationManager.ConnectionStrings["Lodge"].ConnectionString;

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            LoadBookingDetails();
        }
    }

    void LoadBookingDetails()
    {
        if (Request.QueryString["id"] != null)
        {
            int bookingId = Convert.ToInt32(Request.QueryString["id"]);

            SqlConnection con = new SqlConnection(cs);
            con.Open();

            SqlCommand cmd = new SqlCommand("SELECT b.*, r.RoomCode FROM Bookings b INNER JOIN Rooms r ON b.RoomId = r.RoomID WHERE b.BookingId=@id", con); cmd.Parameters.AddWithValue("@id", bookingId);

            SqlDataReader dr = cmd.ExecuteReader();

            if (dr.Read())
            {
                lblBookingId.Text = dr["BookingId"].ToString();
                lblGuestName.Text = dr["GuestName"].ToString();
                lblRoomType.Text = dr["RoomType"].ToString();
                lblRoomNumber.Text = dr["RoomCode"].ToString();
                lblCheckIn.Text = Convert.ToDateTime(dr["CheckInDate"]).ToString("dd MMM yyyy");
                lblCheckOut.Text = Convert.ToDateTime(dr["CheckOutDate"]).ToString("dd MMM yyyy");
                lblAmount.Text = dr["TotalAmount"].ToString();
                lblStatus.Text = dr["BookingStatus"].ToString();
            }

            con.Close();
        }
    }
}