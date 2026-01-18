using System;
using System.Collections;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Drawing;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace NarayaniLodge.Admin
{
    public partial class New_Bookings : System.Web.UI.Page
    {
        string cs = ConfigurationManager.ConnectionStrings["Lodge"].ConnectionString;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadRooms();
            }

        }


        void LoadRooms()
        {
            using (SqlConnection con = new SqlConnection(cs))
            {
                string query = "SELECT RoomID, RoomName FROM Rooms WHERE IsAvailable = 1";
                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    SqlDataAdapter da = new SqlDataAdapter(cmd);
                    DataTable dt = new DataTable();
                    da.Fill(dt);

                    ddlRoom.DataSource = dt;
                    ddlRoom.DataTextField = "RoomName";  // what the user will see
                    ddlRoom.DataValueField = "RoomID";   // actual value
                    ddlRoom.DataBind();
                }

                ddlRoom.Items.Insert(0, new ListItem("--Select Room--", "0"));
            }
        }


        protected void btnSaveBooking_Click(object sender, EventArgs e)
        {
            //Response.Write("<script>alert('SAVE CLICKED');</script>");


            using (SqlConnection con = new SqlConnection(cs))
            {
                con.Open(); 

                SqlTransaction tran = con.BeginTransaction();

               try
                {
                // 1️⃣ Insert Booking
                string insertBooking = @"
                INSERT INTO Bookings
                (BookingDate, GuestName,GuestEmail,GuestPhone,GuestAddress,RoomId,RoomType,CheckInDate,CheckOutDate,IDProofType,IDProofNumber,PaymentMode,PaymentStatus, TotalAmount,BookingStatus,CreatedAt )
                VALUES ( GETDATE(), @GuestName, @GuestEmail,@GuestPhone, @GuestAddress,@RoomId,@RoomType, @CheckInDate,@CheckOutDate, @IDProofType,@IDProofNumber,@PaymentMode,@PaymentStatus,@TotalAmount,'Confirmed',GETDATE())";

                SqlCommand cmd = new SqlCommand(insertBooking, con, tran);

                cmd.Parameters.AddWithValue("@GuestName", txtGuestName.Value);
                cmd.Parameters.AddWithValue("@GuestEmail", txtGuestEmail.Value);
                cmd.Parameters.AddWithValue("@GuestPhone", txtGuestPhone.Value);
                cmd.Parameters.AddWithValue("@GuestAddress", txtAddress.Value);
                cmd.Parameters.AddWithValue("@RoomId", ddlRoom.SelectedValue);
                cmd.Parameters.AddWithValue("@RoomType", ddlRoom.SelectedItem.Text);
                cmd.Parameters.AddWithValue("@CheckInDate", Convert.ToDateTime(txtCheckIn.Value));
                cmd.Parameters.AddWithValue("@CheckOutDate", Convert.ToDateTime(txtCheckOut.Value));
                cmd.Parameters.AddWithValue("@IDProofType", ddlIDProof.SelectedValue);
                cmd.Parameters.AddWithValue("@IDProofNumber", txtIDProofNo.Value);
                cmd.Parameters.AddWithValue("@PaymentMode", ddlPaymentMode.SelectedValue);
                cmd.Parameters.AddWithValue("@PaymentStatus", ddlPaymentStatus.SelectedValue);
                cmd.Parameters.AddWithValue("@TotalAmount", string.IsNullOrEmpty(txtTotalAmount.Value) ? 0 : Convert.ToDecimal(txtTotalAmount.Value));

                    cmd.ExecuteNonQuery();

                // 2️⃣ Update Room Availability
                string updateRoom = @"UPDATE Rooms SET IsAvailable = 0,UpdatedDate = GETDATE()  WHERE RoomID = @RoomId";

                SqlCommand cmdRoom = new SqlCommand(updateRoom, con, tran);
                cmdRoom.Parameters.AddWithValue("@RoomId", ddlRoom.SelectedValue);
                cmdRoom.ExecuteNonQuery();

                // 3️⃣ Commit
                tran.Commit();
                    // ClearFields();

                    // Success
                    ScriptManager.RegisterStartupScript(
                        this,
                        GetType(),
                        "success",
                        "Swal.fire({ icon:'success', title:'Saved', timer:1500, showConfirmButton:false }).then(()=>{ window.location='New_Bookings.aspx'; });",
                        true
                    );

                }
                catch (Exception ex)
                {
                tran.Rollback();
                    ScriptManager.RegisterStartupScript(this,GetType(),"warning", "Swal.fire('Warning','Please select room and dates','warning');",true);
                }
            }

    }



        protected void ddlRoom_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (ddlRoom.SelectedIndex == 0 ||
        string.IsNullOrEmpty(txtCheckIn.Value) ||
        string.IsNullOrEmpty(txtCheckOut.Value))
            {
                txtTotalAmount.Value = "";
                return;
            }

            DateTime checkIn = Convert.ToDateTime(txtCheckIn.Value);
            DateTime checkOut = Convert.ToDateTime(txtCheckOut.Value);

            int nights = (checkOut - checkIn).Days;

            if (nights <= 0)
            {
                txtTotalAmount.Value = "";
                return;
            }

            using (SqlConnection con = new SqlConnection(cs))
            {
                string query = "SELECT PricePerNight FROM Rooms WHERE RoomID = @RoomID";
                SqlCommand cmd = new SqlCommand(query, con);
                cmd.Parameters.AddWithValue("@RoomID", ddlRoom.SelectedValue);

                con.Open();
                decimal pricePerNight = Convert.ToDecimal(cmd.ExecuteScalar());

                decimal totalAmount = pricePerNight * nights;
                txtTotalAmount.Value = totalAmount.ToString("0.00");
            }
        }
    }
}