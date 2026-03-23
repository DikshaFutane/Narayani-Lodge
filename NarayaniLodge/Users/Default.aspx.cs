using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Drawing;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Users_Default : System.Web.UI.Page
{
    string cs = ConfigurationManager.ConnectionStrings["Lodge"].ConnectionString;

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            if (Session["UserEmail"] != null && Session["UserName"] != null)
            {
                lblUserName.Text = Session["UserName"].ToString();
                LoadBookings();
            }
            else
            {
                Response.Redirect("~/Users/Login.aspx");
            }
        }
    }

    protected void gvAllBookings_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        //if (e.CommandName == "CancelBooking")
        //{
        //    int bookingId = Convert.ToInt32(e.CommandArgument);

        //    using (SqlConnection con = new SqlConnection(cs))
        //    {
        //        string query = "UPDATE Bookings SET BookingStatus='Cancelled', CancellationDate=@date WHERE BookingID=@id";

        //        SqlCommand cmd = new SqlCommand(query, con);
        //        cmd.Parameters.AddWithValue("@date", DateTime.Now);
        //        cmd.Parameters.AddWithValue("@id", bookingId);

        //        con.Open();
        //        cmd.ExecuteNonQuery();
        //        con.Close();
        //    }

        //    LoadBookings();

        //    ScriptManager.RegisterStartupScript(this, this.GetType(), "alert",
        //    "alert('Booking cancelled successfully!');", true);
        //}
    }
    void LoadBookings()
    {
        if (Session["UserEmail"] == null)
            return;

        string email = Session["UserEmail"].ToString();

        using (SqlConnection con = new SqlConnection(cs))
        {
            string query = @"SELECT BookingId, RoomType, CheckInDate, CheckOutDate, BookingStatus
                         FROM Bookings
                         WHERE GuestEmail = @Email
                         ORDER BY BookingDate DESC";

            SqlCommand cmd = new SqlCommand(query, con);

            cmd.Parameters.AddWithValue("@Email", email);

            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();

            da.Fill(dt);

            gvBookings.DataSource = dt;
            gvBookings.DataBind();
        }
    }


}