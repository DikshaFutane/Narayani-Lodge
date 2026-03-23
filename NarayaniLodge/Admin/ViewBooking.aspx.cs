using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Admin_ViewBooking : System.Web.UI.Page
{
    string cs = ConfigurationManager.ConnectionStrings["Lodge"].ConnectionString;

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            string id = Request.QueryString["BookingId"];
            LoadBooking(id);
        }
    }

    private void LoadBooking(string id)
    {
        string query = "SELECT * FROM Bookings WHERE BookingId = @BookingId";

        using (SqlConnection con = new SqlConnection(cs))
        {
            SqlCommand cmd = new SqlCommand(query, con);
            cmd.Parameters.AddWithValue("@BookingId", id);

            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            da.Fill(dt);

            dvBooking.DataSource = dt;
            dvBooking.DataBind();
        }
    }

    protected void btnBack_Click(object sender, EventArgs e)
    {
        Response.Redirect("AllBookings.aspx");
    }
}