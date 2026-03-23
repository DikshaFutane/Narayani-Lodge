using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Users_BookingForm : System.Web.UI.Page
{
    string cs = ConfigurationManager.ConnectionStrings["Lodge"].ConnectionString;

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            if (Request.QueryString["roomtype"] != null)
            {
                string roomType = Request.QueryString["roomtype"];
                txtRoomType.Text = roomType;
                if (roomType == "AC Room")
                {
                    txtPrice.Text = "2000";
                }
                else if (roomType == "Non-AC Room")
                {
                    txtPrice.Text = "1600";
                }
            }

            // Fill data from query string and session
            if (Session["UserID"] != null)
            {
                txtGuestName.Text = Session["UserName"].ToString();
                txtEmail.Text = Session["UserEmail"].ToString();
                txtPhone.Text = Session["UserPhone"]?.ToString(); // Optional if stored


                txtCheckIn.Text = Request.QueryString["checkin"];
                txtCheckOut.Text = Request.QueryString["checkout"];
                txtRoomType.Text = Request.QueryString["roomtype"];
                txtNoOfRooms.Text = Request.QueryString["rooms"];
                txtGuests.Text = Request.QueryString["guests"];
            }

            CalculateTotalAmount();
        }
    }


    protected void ddlIDProof_SelectedIndexChanged(object sender, EventArgs e)
    {
        revAadhar.Enabled = false;
        revPAN.Enabled = false;
        revPassport.Enabled = false;

        if (ddlIDProof.SelectedValue == "Aadhar")
        {
            revAadhar.Enabled = true;
        }
        else if (ddlIDProof.SelectedValue == "PAN")
        {
            revPAN.Enabled = true;
        }
        else if (ddlIDProof.SelectedValue == "Passport")
        {
            revPassport.Enabled = true;
        }
    }
    void CalculateTotalAmount()
    {
        if (txtCheckIn.Text != "" && txtCheckOut.Text != "" && txtPrice.Text != "" && txtNoOfRooms.Text != "")
        {
            DateTime checkIn = Convert.ToDateTime(txtCheckIn.Text);
            DateTime checkOut = Convert.ToDateTime(txtCheckOut.Text);

            int nights = (checkOut - checkIn).Days;

            if (nights <= 0)
            {
                txtTotalAmount.Text = "0";
                return;
            }

            int price = Convert.ToInt32(txtPrice.Text);
            int rooms = Convert.ToInt32(txtNoOfRooms.Text);

            int total = price * rooms * nights;

            txtTotalAmount.Text = total.ToString();
        }
    }

    protected void btnBook_Click1(object sender, EventArgs e)
    {
        try
        {
            DateTime checkIn = Convert.ToDateTime(txtCheckIn.Text);
            DateTime checkOut = Convert.ToDateTime(txtCheckOut.Text);

            // ❌ Prevent past check-in
            if (checkIn < DateTime.Today)
            {
                ClientScript.RegisterStartupScript(this.GetType(), "alert",
                    "Swal.fire('Error','Check-in date cannot be before today','error');", true);
                return;
            }

            // ❌ Prevent invalid dates
            if (checkOut <= checkIn)
            {
                ClientScript.RegisterStartupScript(this.GetType(), "alert",
                    "Swal.fire('Error','Check-out must be after Check-in','error');", true);
                return;
            }

            int pricePerRoom = Convert.ToInt32(txtPrice.Text);
            int numberOfRooms = Convert.ToInt32(txtNoOfRooms.Text);

            int nights = (checkOut - checkIn).Days;

            int totalAmount = pricePerRoom * numberOfRooms * nights;

            using (SqlConnection con = new SqlConnection(cs))
            {
                con.Open();

                int roomId = Convert.ToInt32(Request.QueryString["roomid"]);

                // 🔎 CHECK ROOM AVAILABILITY
                string checkQuery = @"SELECT COUNT(*) FROM Bookings
                                  WHERE RoomId=@RoomId
                                  AND BookingStatus!='Cancelled'
                                  AND (@CheckIn < CheckOutDate AND @CheckOut > CheckInDate)";

                SqlCommand checkCmd = new SqlCommand(checkQuery, con);

                checkCmd.Parameters.AddWithValue("@RoomId", roomId);
                checkCmd.Parameters.AddWithValue("@CheckIn", checkIn);
                checkCmd.Parameters.AddWithValue("@CheckOut", checkOut);

                int count = (int)checkCmd.ExecuteScalar();

                if (count > 0)
                {
                    ClientScript.RegisterStartupScript(this.GetType(), "alert",
                        "Swal.fire('Room Not Available','Room already booked for selected dates','warning');", true);
                    return;
                }

                // ✅ INSERT BOOKING
                string query = @"
            INSERT INTO Bookings
            (RoomId, BookingDate, GuestName, GuestEmail, GuestPhone, GuestAddress,
             RoomType, NoOfRooms, CheckInDate, CheckOutDate,
             IDProofType, IDProofNumber, PaymentMode, PaymentStatus,
             TotalAmount, BookingStatus, CreatedAt, BookingSource,
             PaidAmount, RemainingAmount, CancellationDate)
            VALUES
            (@RoomId, GETDATE(), @GuestName, @GuestEmail, @GuestPhone, @GuestAddress,
             @RoomType, @NoOfRooms, @CheckIn, @CheckOut,
             @IDProofType, @IDProofNumber, @PaymentMode, @PaymentStatus,
             @TotalAmount, @BookingStatus, GETDATE(), @BookingSource,
             @PaidAmount, @RemainingAmount, @CancellationDate)";

                SqlCommand cmd = new SqlCommand(query, con);

                cmd.Parameters.AddWithValue("@RoomId", roomId);
                cmd.Parameters.AddWithValue("@GuestName", txtGuestName.Text);
                cmd.Parameters.AddWithValue("@GuestEmail", txtEmail.Text);
                cmd.Parameters.AddWithValue("@GuestPhone", txtPhone.Text);
                cmd.Parameters.AddWithValue("@GuestAddress", txtAddress.Text);
                cmd.Parameters.AddWithValue("@RoomType", txtRoomType.Text);
                cmd.Parameters.AddWithValue("@NoOfRooms", numberOfRooms);
                cmd.Parameters.AddWithValue("@CheckIn", checkIn);
                cmd.Parameters.AddWithValue("@CheckOut", checkOut);
                cmd.Parameters.AddWithValue("@IDProofType", ddlIDProof.SelectedValue);
                cmd.Parameters.AddWithValue("@IDProofNumber", txtIDNumber.Text);
                cmd.Parameters.AddWithValue("@PaymentMode", txtPaymentMode.Text);
                cmd.Parameters.AddWithValue("@PaymentStatus", "Pending");
                cmd.Parameters.AddWithValue("@TotalAmount", totalAmount);
                cmd.Parameters.AddWithValue("@BookingStatus", "Pending");
                cmd.Parameters.AddWithValue("@BookingSource", "Website");

                cmd.Parameters.AddWithValue("@PaidAmount", 0);
                cmd.Parameters.AddWithValue("@RemainingAmount", totalAmount);

                cmd.Parameters.AddWithValue("@CancellationDate", DBNull.Value);

                cmd.ExecuteNonQuery();

                ClientScript.RegisterStartupScript(this.GetType(), "alert",
                    "Swal.fire('Success','Booking Confirmed! Total Amount: ₹" + totalAmount + "','success');", true);

                Response.Redirect("~/Users/MyBookings.aspx");

                ClearForm();
            }
        }
        catch (Exception ex)
        {
            ClientScript.RegisterStartupScript(this.GetType(), "alert",
                "Swal.fire('Error','" + ex.Message + "','error');", true);
        }
    }

    private void ClearForm()
    {
        txtPhone.Text = "";
        txtAddress.Text = "";
        ddlIDProof.SelectedIndex = 0;
        txtIDNumber.Text = "";
    }


}
