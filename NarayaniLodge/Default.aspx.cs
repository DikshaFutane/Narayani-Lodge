using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace NarayaniLodge
{
    public partial class _Default : Page
    {
        string cs = ConfigurationManager.ConnectionStrings["Lodge"].ConnectionString;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // Initial setup if needed
                room.Value = "";
            }
        }

        protected void guest_SelectedIndexChanged(object sender, EventArgs e)
        {
            int roomsNeeded = 0;
            string selected = guest.SelectedValue; // DropDownList uses SelectedValue

            switch (selected)
            {
                case "1A":
                case "2A":
                case "3A":
                case "2A1C":
                    roomsNeeded = 1;
                    break;
                
                case "2A2C":
                case "3A1C":
                    roomsNeeded = 2;
                    break;
                default:
                    roomsNeeded = 0;
                    break;
            }

            room.Value = roomsNeeded.ToString(); // Use .Text for asp:TextBox
        }

        protected void btnCheck_Click1(object sender, EventArgs e)
        {
            try
            {
                DateTime checkIn = Convert.ToDateTime(datein.Value);
                DateTime checkOut = Convert.ToDateTime(dateout.Value);

                string roomType = roomtype.Value;
                int roomsRequested = Convert.ToInt32(room.Value);
                string guests = guest.SelectedValue;

                int totalGuests = 0;

                if (guests == "1A") totalGuests = 1;
                if (guests == "2A") totalGuests = 2;
                if (guests == "2A1C") totalGuests = 3;
                if (guests == "2A2C") totalGuests = 4;
                if (guests == "3A") totalGuests = 3;
                if (guests == "3A1C") totalGuests = 4;

                int allowedGuests = roomsRequested * 3;

                if (totalGuests > allowedGuests)
                {
                    ClientScript.RegisterStartupScript(this.GetType(), "alert",
                        "Swal.fire('Limit Exceeded','Only 3 guests allowed per room','warning');", true);
                    return;
                }

                using (SqlConnection con = new SqlConnection(cs))
                {
                    con.Open();

                    string query = @"
            SELECT RoomId 
            FROM Rooms r
            WHERE r.RoomName=@RoomName AND r.IsAvailable=1
            AND r.RoomId NOT IN (
                SELECT RoomId 
                FROM Bookings
                WHERE BookingStatus='Confirmed'
                AND CheckInDate < @CheckOut
                AND CheckOutDate > @CheckIn
            )";

                    SqlCommand cmd = new SqlCommand(query, con);
                    cmd.Parameters.AddWithValue("@RoomName", roomType);
                    cmd.Parameters.AddWithValue("@CheckIn", checkIn);
                    cmd.Parameters.AddWithValue("@CheckOut", checkOut);

                    List<int> availableRooms = new List<int>();

                    SqlDataReader dr = cmd.ExecuteReader();

                    while (dr.Read())
                    {
                        availableRooms.Add(Convert.ToInt32(dr["RoomId"]));
                    }

                    dr.Close();

                    if (availableRooms.Count == 0)
                    {
                        ClientScript.RegisterStartupScript(this.GetType(), "alert",
                            "Swal.fire('Not Available','No rooms available for selected dates','error');", true);
                        return;
                    }

                    if (availableRooms.Count < roomsRequested)
                    {
                        ClientScript.RegisterStartupScript(this.GetType(), "alert",
                            "Swal.fire('Limited Rooms','Only " + availableRooms.Count + " rooms available','warning');", true);
                        return;
                    }

                    string selectedRooms = string.Join(",", availableRooms.Take(roomsRequested));

                    string redirectUrl = "~/Users/BookingForm.aspx?roomids=" + selectedRooms
                        + "&roomtype=" + roomType
                        + "&checkin=" + checkIn.ToString("yyyy-MM-dd")
                        + "&checkout=" + checkOut.ToString("yyyy-MM-dd")
                        + "&rooms=" + roomsRequested
                        + "&guests=" + guests;

                    if (Session["UserID"] != null)
                    {
                        Response.Redirect(redirectUrl);
                    }
                    else
                    {
                        Response.Redirect("Authentication/Login.aspx?redirect=" + redirectUrl);
                    }
                }
            }
            catch (Exception ex)
            {
                ClientScript.RegisterStartupScript(this.GetType(), "alert",
                    "Swal.fire('Error','Something went wrong','error');", true);
            }
        }

        public void ClearFields()
        {
            datein.Value = "";
            dateout.Value = "";
            guest.SelectedValue = "";
            roomtype.Value = "";
            room.Value = "";
        }
    
}
}