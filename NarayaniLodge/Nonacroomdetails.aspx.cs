using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Nonacroomdetails : System.Web.UI.Page
{
    //Connection String
    string cs = ConfigurationManager.ConnectionStrings["Lodge"].ConnectionString;
    protected void Page_Load(object sender, EventArgs e)
    {

    }

    protected void Unnamed_ServerClick(object sender, EventArgs e)
    {
        string inDate = datein.Value;
        string outDate = dateout.Value;


        if (string.IsNullOrEmpty(datein.Value) || string.IsNullOrEmpty(dateout.Value))
        {
            ScriptManager.RegisterStartupScript(
    this, GetType(), "alert",
    "Swal.fire({ icon:'warning', title:'Select Dates', text:'Please select check-in & check-out dates.', width: 300, padding: '1em' });",
    true);

            return;
        }

        DateTime checkIn = DateTime.Parse(datein.Value);
        DateTime checkOut = DateTime.Parse(dateout.Value);

        using (SqlConnection con = new SqlConnection(cs))
        {
            con.Open();

            string query = @"
            SELECT COUNT(*) 
            FROM Bookings 
            WHERE RoomId = @RoomId
              AND BookingStatus = 'Confirmed'
              AND NOT (@CheckOut <= CheckInDate OR @CheckIn >= CheckOutDate)";

            using (SqlCommand cmd = new SqlCommand(query, con))
            {
                cmd.Parameters.AddWithValue("@RoomId", 2); // AC / Non-AC room ID
                cmd.Parameters.AddWithValue("@CheckIn", checkIn);
                cmd.Parameters.AddWithValue("@CheckOut", checkOut);

                int count = (int)cmd.ExecuteScalar();

                if (count > 0)
                {
                    // ❌ Not Available
                    ScriptManager.RegisterStartupScript(
              this, GetType(), "alert",
              @"Swal.fire({
                    icon: 'error',
                    title: 'Not Available',
                    text: 'Room already booked for selected dates. For More details contact us',
                    width: 280,
                    timer: 2000,
                    showConfirmButton: false
                });",
              true);

                }
                else
                {
                    // ✅ Available
                    ScriptManager.RegisterStartupScript(
              this, GetType(), "alert",
              @"Swal.fire({
                    icon: 'success',
                    title: 'Available',
                    text: 'Room is available for selected dates. For More details contact us',
                    width: 280,
                    timer: 3000,
                    showConfirmButton: false
                }).then(() => {
                    document.getElementById('" + datein.ClientID + @"').value = '';
                    document.getElementById('" + dateout.ClientID + @"').value = '';
                });",
              true);
                }
                datein.Value = inDate;
                dateout.Value = outDate;
            }
        }
    }
}