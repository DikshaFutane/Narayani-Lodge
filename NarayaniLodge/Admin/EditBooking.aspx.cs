using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Admin_EditBooking : System.Web.UI.Page
{
    string cs = ConfigurationManager.ConnectionStrings["Lodge"].ConnectionString;

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            if (Request.QueryString["BookingId"] != null)
            {
                int bookingId = Convert.ToInt32(Request.QueryString["BookingId"]);
                LoadBookingData(bookingId);
            }
        }
    }

    private void LoadBookingData(int bookingId)
    {
        using (SqlConnection con = new SqlConnection(cs))
        {
            string query = "SELECT * FROM Bookings WHERE BookingId = @BookingId";

            SqlCommand cmd = new SqlCommand(query, con);
            cmd.Parameters.AddWithValue("@BookingId", bookingId);

            con.Open();
            SqlDataReader dr = cmd.ExecuteReader();
            if (dr.Read())
            {
                hfBookingId.Value = dr["BookingId"].ToString();

                txtGuestName.Text = dr["GuestName"].ToString();
                txtEmail.Text = dr["GuestEmail"].ToString();
                txtPhone.Text = dr["GuestPhone"].ToString();
                ddlRoomType.Text = dr["RoomType"].ToString();

                txtCheckIn.Text = Convert.ToDateTime(dr["CheckInDate"]).ToString("yyyy-MM-dd");
                txtCheckOut.Text = Convert.ToDateTime(dr["CheckOutDate"]).ToString("yyyy-MM-dd");

                txtNoOfRooms.Text = dr["NoOfRooms"].ToString();
                txtid.Text = dr["IdProofType"].ToString();
                txtNo.Text = dr["IdProofNumber"].ToString();

                ddlPaymentStatus.Text = dr["PaymentStatus"].ToString();

                txtTotal.Text = dr["TotalAmount"].ToString();
                txtPending.Text = dr["RemainingAmount"].ToString();

                ddlBookingStatus.Text = dr["BookingStatus"].ToString();
            }
            txtTotal.ReadOnly = true;
            con.Close();
        }
    }

    protected void btnUpdate_Click(object sender, EventArgs e)
    {
        int rooms = int.Parse(txtNoOfRooms.Text);
        DateTime checkIn = DateTime.Parse(txtCheckIn.Text);
        DateTime checkOut = DateTime.Parse(txtCheckOut.Text);
        int nights = (checkOut - checkIn).Days;
        if (nights <= 0) nights = 1;

        int pricePerNight = 0;
        if (ddlRoomType.Text == "AC Room") pricePerNight = 2000;
        else if (ddlRoomType.Text == "Non-AC Room") pricePerNight = 1200;

        int total = pricePerNight * rooms * nights;
        txtTotal.Text = total.ToString();

        // 2️⃣ Calculate pending amount
        int paid = 0;
        if (!string.IsNullOrEmpty(txtPaid.Text))
            paid = int.Parse(txtPaid.Text);

        int pending = total - paid;
        txtPending.Text = pending.ToString();

        SqlConnection con = new SqlConnection(cs);

        string query = @"UPDATE Bookings SET
                        GuestName=@GuestName,
                        GuestEmail=@GuestEmail,
                        GuestPhone=@GuestPhone,
                        RoomType=@RoomType,
                        CheckInDate=@CheckInDate,
                        CheckOutDate=@CheckOutDate,
                        NoOfRooms=@NoOfRooms,
                        IdProofType=@IdProofType,
                        IdProofNumber=@IdProofNumber,
                        PaymentStatus=@PaymentStatus,
                        TotalAmount=@TotalAmount,
                        RemainingAmount=@RemainingAmount,
                        BookingStatus=@BookingStatus
                        WHERE BookingId=@BookingId";

        SqlCommand cmd = new SqlCommand(query, con);

        cmd.Parameters.AddWithValue("@BookingId", hfBookingId.Value);
        cmd.Parameters.AddWithValue("@GuestName", txtGuestName.Text);
        cmd.Parameters.AddWithValue("@GuestEmail", txtEmail.Text);
        cmd.Parameters.AddWithValue("@GuestPhone", txtPhone.Text);
        cmd.Parameters.AddWithValue("@RoomType", ddlRoomType.Text);
        cmd.Parameters.AddWithValue("@CheckInDate", txtCheckIn.Text);
        cmd.Parameters.AddWithValue("@CheckOutDate", txtCheckOut.Text);
        cmd.Parameters.AddWithValue("@NoOfRooms", txtNoOfRooms.Text);
        cmd.Parameters.AddWithValue("@IdProofType", txtid.Text);
        cmd.Parameters.AddWithValue("@IdProofNumber", txtNo.Text);
        cmd.Parameters.AddWithValue("@PaymentStatus", ddlPaymentStatus.Text);
        cmd.Parameters.AddWithValue("@TotalAmount", txtTotal.Text);
        cmd.Parameters.AddWithValue("@RemainingAmount", txtPending.Text);
        cmd.Parameters.AddWithValue("@BookingStatus", ddlBookingStatus.Text);

        con.Open();
        cmd.ExecuteNonQuery();
        con.Close();

        Response.Redirect("AllBookings.aspx");
    }
}
