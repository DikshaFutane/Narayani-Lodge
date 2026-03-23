using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Admin_AddBooking : System.Web.UI.Page
{
    string cs = ConfigurationManager.ConnectionStrings["Lodge"].ConnectionString;

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            LoadRooms();
        }
    }

    // LOAD ROOMS
    void LoadRooms()
    {
        using (SqlConnection con = new SqlConnection(cs))
        {
            string query = @"
        SELECT RoomID,
               RoomName + ' (Room ' + CAST(RoomCode AS VARCHAR) + ')' AS DisplayName
        FROM Rooms
        WHERE IsDeleted = 0 and IsAvailable = 1";

            SqlCommand cmd = new SqlCommand(query, con);
            con.Open();

            ddlRoom.DataSource = cmd.ExecuteReader();
            ddlRoom.DataTextField = "DisplayName";
            ddlRoom.DataValueField = "RoomID";
            ddlRoom.DataBind();
        }

        ddlRoom.Items.Insert(0, new ListItem("-- Select Room --", "0"));
    }


    // CALCULATE TOTAL
    void CalculateTotal()
    {
        if (ddlRoom.SelectedIndex == 0 ||
            string.IsNullOrEmpty(CheckIn.Text) ||
            string.IsNullOrEmpty(Checkout.Text))
        {
            txtTotalAmount.Text = "";
            return;
        }

        DateTime checkIn = Convert.ToDateTime(CheckIn.Text);
        DateTime checkOut = Convert.ToDateTime(Checkout.Text);

        int days = (checkOut - checkIn).Days;

        if (days <= 0)
        {
            txtTotalAmount.Text = "0";
            return;
        }

        using (SqlConnection con = new SqlConnection(cs))
        {
            string query = "SELECT PricePerNight FROM Rooms WHERE RoomID = @RoomID";
            SqlCommand cmd = new SqlCommand(query, con);
            cmd.Parameters.AddWithValue("@RoomID", ddlRoom.SelectedValue);

            con.Open();
            object result = cmd.ExecuteScalar();

            if (result != null)
            {
                decimal price = Convert.ToDecimal(result);

                // ✅ GET NUMBER OF ROOMS
                int noOfRooms = 1;
                int.TryParse(txtNumRooms.Text, out noOfRooms);

                if (noOfRooms <= 0)
                    noOfRooms = 1;

                // ✅ FINAL TOTAL
                decimal total = price * days * noOfRooms;

                txtTotalAmount.Text = total.ToString("0.00");

                CalculateRemaining();
            }
        }
    }
    // PAID AMOUNT CHANGE
    protected void txtpaidAmount_TextChanged(object sender, EventArgs e)
    {
        CalculateRemaining();
    }

    // CALCULATE REMAINING
    void CalculateRemaining()
    {
        decimal total = 0;
        decimal paid = 0;

        decimal.TryParse(txtTotalAmount.Text, out total);
        decimal.TryParse(txtpaidAmount.Text, out paid);

        if (paid > total)
            paid = total;

        decimal remaining = total - paid;

        txtremainingAmount.Text = remaining.ToString("0.00");

        if (remaining == 0)
            ddlPaymentStatus.SelectedValue = "Paid";
        else if (paid == 0)
            ddlPaymentStatus.SelectedValue = "Pending";
        else
            ddlPaymentStatus.SelectedValue = "Partial";
    }

    protected void txtpaidAmount_TextChanged1(object sender, EventArgs e)
    {
        CalculateRemaining();
    }

    protected void btnSaveBooking_Click1(object sender, EventArgs e)
    {
        using (SqlConnection con = new SqlConnection(cs))
        {
            con.Open();

            // 🔹 STEP 1: CHECK ROOM AVAILABILITY
            string checkRoom = "SELECT IsAvailable FROM Rooms WHERE RoomID = @RoomID";
            SqlCommand checkCmd = new SqlCommand(checkRoom, con);
            checkCmd.Parameters.AddWithValue("@RoomID", ddlRoom.SelectedValue);

            object result = checkCmd.ExecuteScalar();

            if (result != null && Convert.ToBoolean(result) == true)
            {
                // ✅ ROOM IS AVAILABLE

                // 🔹 STEP 2: INSERT BOOKING
                string insertQuery = @"INSERT INTO Bookings
            (BookingDate, GuestName, GuestEmail, GuestPhone, GuestAddress,
             RoomId, RoomType, CheckInDate, CheckOutDate, IDProofType, IDProofNumber,
             PaymentMode, PaymentStatus,
             TotalAmount, PaidAmount, RemainingAmount,
             BookingStatus, CreatedAt, BookingSource)
            VALUES
            (GETDATE(), @GuestName, @GuestEmail, @GuestPhone, @GuestAddress,
             @RoomId, @RoomType, @CheckInDate, @CheckOutDate, @IDProofType, @IDProofNumber,
             @PaymentMode, @PaymentStatus,
             @TotalAmount, @PaidAmount, @RemainingAmount,
             'Confirmed', GETDATE(), 'Manual')";

                SqlCommand cmd = new SqlCommand(insertQuery, con);

                // Add all parameters here
                cmd.Parameters.AddWithValue("@GuestName", txtGuestName.Value);
                cmd.Parameters.AddWithValue("@GuestEmail", txtGuestEmail.Value);
                cmd.Parameters.AddWithValue("@GuestPhone", txtGuestPhone.Value);
                cmd.Parameters.AddWithValue("@GuestAddress", txtAddress.Value);
                cmd.Parameters.AddWithValue("@RoomId", ddlRoom.SelectedValue);
                cmd.Parameters.AddWithValue("@RoomType", ddlRoom.SelectedItem.Text);
                cmd.Parameters.AddWithValue("@CheckInDate", CheckIn.Text);
                cmd.Parameters.AddWithValue("@CheckOutDate", Checkout.Text);
                cmd.Parameters.AddWithValue("@IDProofType", ddlIDProof.SelectedValue);
                cmd.Parameters.AddWithValue("@IDProofNumber", txtIDProofNo.Value);
                cmd.Parameters.AddWithValue("@PaymentMode", ddlPaymentMode.SelectedValue);
                cmd.Parameters.AddWithValue("@PaymentStatus", ddlPaymentStatus.SelectedValue);
                cmd.Parameters.AddWithValue("@TotalAmount", txtTotalAmount.Text);
                cmd.Parameters.AddWithValue("@PaidAmount", txtpaidAmount.Text);
                cmd.Parameters.AddWithValue("@RemainingAmount", txtremainingAmount.Text);

                cmd.ExecuteNonQuery();

                // 🔹 STEP 3: UPDATE ROOM STATUS
                string updateRoom = "UPDATE Rooms SET IsAvailable = 0 WHERE RoomID = @RoomID";
                SqlCommand updateCmd = new SqlCommand(updateRoom, con);
                updateCmd.Parameters.AddWithValue("@RoomID", ddlRoom.SelectedValue);
                updateCmd.ExecuteNonQuery();
                ClearFields();
                ScriptManager.RegisterStartupScript(this, this.GetType(), "success",
                "Swal.fire({icon: 'success', title: 'Booking Successful!', timer: 2000, showConfirmButton: false}).then(()=>{ window.location='AllBookings.aspx'; });", true);
            }
            else
            {

                ScriptManager.RegisterStartupScript(this, this.GetType(), "error",
                   "Swal.fire({icon: 'error', title: 'Room Not Available!', text: 'Please select another room.'});", true);
            }
        }
    }
    void ClearFields()
    {
        txtGuestName.Value = "";
        txtGuestEmail.Value = "";
        txtGuestPhone.Value = "";
        ddlRoom.SelectedIndex = 0;
        CheckIn.Text = "";
        Checkout.Text = "";
        ddlPaymentMode.SelectedIndex = 0;
        ddlPaymentStatus.SelectedIndex = 0;
        txtTotalAmount.Text = "";
        txtpaidAmount.Text = "";
        txtremainingAmount.Text = "";
        txtAddress.Value = "";
        txtIDProofNo.Value = "";
        txtNumRooms.Text = "1";
    }
    protected void ddlRoom_SelectedIndexChanged1(object sender, EventArgs e)
    {
        CalculateTotal();
    }

    protected void CheckIn_TextChanged1(object sender, EventArgs e)
    {
        CalculateTotal();

    }

    protected void Checkout_TextChanged(object sender, EventArgs e)
    {
        CalculateTotal();
    }
    protected void txtNumRooms_TextChanged(object sender, EventArgs e)
    {
        CalculateTotal();
    }
}