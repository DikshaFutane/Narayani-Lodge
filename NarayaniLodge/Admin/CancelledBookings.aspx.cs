using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Admin_CancelledBookings : System.Web.UI.Page
{
    string cs = ConfigurationManager.ConnectionStrings["Lodge"].ConnectionString;

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            LoadcancelBookings();
        }
    }
    protected void gvAllBookings_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        gvAllBookings.PageIndex = e.NewPageIndex;
        LoadcancelBookings();
    }

    protected void gvAllBookings_RowCommand(object sender, GridViewCommandEventArgs e)
    {
    }

    private void LoadcancelBookings()
    {
        string query = "SELECT * FROM Bookings where BookingStatus='Cancelled'";

        SqlConnection con = new SqlConnection(cs);
        SqlDataAdapter da = new SqlDataAdapter(query, con);
        DataTable dt = new DataTable();
        da.Fill(dt);

        gvAllBookings.DataSource = dt;
        gvAllBookings.DataBind();
    }
}