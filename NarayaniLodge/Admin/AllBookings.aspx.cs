using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace NarayaniLodge.Admin
{
    public partial class AllBookings : System.Web.UI.Page
    {
        string cs = ConfigurationManager.ConnectionStrings["Lodge"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadBookings();
            }
        }
        protected void gvAllBookings_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            gvAllBookings.PageIndex = e.NewPageIndex;
            LoadBookings();
        }

        protected void gvAllBookings_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "ViewBooking")
            {
                Response.Redirect("ViewBooking.aspx?BookingId=" + e.CommandArgument);
            }

            if (e.CommandName == "EditBooking")
            {
                Response.Redirect("EditBooking.aspx?BookingId=" + e.CommandArgument);
            }

            if (e.CommandName == "CancelBooking")
            {
                int bookingId = Convert.ToInt32(e.CommandArgument);


                using (SqlConnection con = new SqlConnection(cs))
                {
                    string query = "UPDATE Bookings SET BookingStatus='Cancelled', CancellationDate=@date WHERE BookingID=@id";

                    SqlCommand cmd = new SqlCommand(query, con);
                     con.Open();
                    //cmd.CommandText = "UPDATE Bookings SET BookingStatus='Cancelled', CancellationDate=@date WHERE BookingID=@id";
                    cmd.Parameters.AddWithValue("@date", DateTime.Now);
                    cmd.Parameters.AddWithValue("@id", bookingId);
                    cmd.ExecuteNonQuery();
                    con.Close();
                }

                // Refresh GridView
                LoadBookings();

                // Optional Success Message
                ScriptManager.RegisterStartupScript(this, this.GetType(), "alert",
                    "alert('Booking cancelled successfully!');", true);
            }
        }
        
        private void LoadBookings()
        {
            string query = "SELECT * FROM Bookings ORDER BY BookingDate DESC";

            SqlConnection con = new SqlConnection(cs);
            SqlDataAdapter da = new SqlDataAdapter(query, con);
            DataTable dt = new DataTable();
            da.Fill(dt);

            gvAllBookings.DataSource = dt;
            gvAllBookings.DataBind();
        }
    }
}