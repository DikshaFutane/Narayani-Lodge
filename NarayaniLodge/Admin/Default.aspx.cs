using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Script.Serialization;

namespace NarayaniLodge.Admin
{
    public partial class Default : System.Web.UI.Page
    {
        //Connection String
        string cs = ConfigurationManager.ConnectionStrings["Lodge"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["Admin"] == null)
            {
                Response.Redirect("Login.aspx");
            }
            if (!IsPostBack)
            {
                SetGreetingMessage();
                LoadBookingsgrid();
                LoadTodaysArrivals();
                LoadTodaysDepartures();
                LoadAvailableRooms();
                LoadNewEnquiries();
                LoadTodaysRevenue();
                LoadPendingPayments();
                LoadTodaysArrivalsGrid();
                LoadTodayDepartures();
                graph();
                LoadBookingStatusChart();
            }
            
        }

        private void SetGreetingMessage()
        {
            int hour = DateTime.Now.Hour; // Get current hour (0-23)
            string greeting = "";

            if (hour >= 5 && hour < 12)
            {
                greeting = "Good Morning Admin! 🌅";
            }
            else if (hour >= 12 && hour < 17)
            {
                greeting = "Good Afternoon Admin! ☀️";
            }
            else if (hour >= 17 && hour < 21)
            {
                greeting = "Good Evening Admin!🌇";
            }
            else
            {
                greeting = "Good Night Admin!🌙";
            }

            lblGreeting.Text = greeting;
        }
        void LoadTodaysArrivals()
        {
            string query = @"SELECT COUNT(*) 
                     FROM Bookings
                     WHERE BookingStatus = 'Confirmed'
                     AND CAST(CheckInDate AS DATE) = CAST(GETDATE() AS DATE)";

            using (SqlConnection con = new SqlConnection(cs))
            {
                SqlCommand cmd = new SqlCommand(query, con);
                con.Open();

                object result = cmd.ExecuteScalar();
                int count = (result != DBNull.Value) ? Convert.ToInt32(result) : 0;

                lblArrivals.Text = count.ToString();
                
            }
        }

        void LoadTodaysDepartures()
        {
            string query = @"SELECT COUNT(*) 
                     FROM Bookings
                     WHERE BookingStatus = 'Confirmed'
                     AND CAST(CheckOutDate AS DATE) = CAST(GETDATE() AS DATE)";

            using (SqlConnection con = new SqlConnection(cs))
            {
                SqlCommand cmd = new SqlCommand(query, con);
                con.Open();

                object result = cmd.ExecuteScalar();
                int count = (result != DBNull.Value) ? Convert.ToInt32(result) : 0;

                lblDepartures.Text = count.ToString();
            }
        }

        void LoadAvailableRooms()
        {
            string query = "SELECT COUNT(*) FROM Rooms WHERE IsAvailable = 1";

            using (SqlConnection con = new SqlConnection(cs))
            {
                SqlCommand cmd = new SqlCommand(query, con);
                con.Open();

                object result = cmd.ExecuteScalar();
                int available = (result != DBNull.Value) ? Convert.ToInt32(result) : 0;

                lblAvailableRooms.Text = available.ToString();
            }
        }

        void LoadNewEnquiries()
        {
            string query = "SELECT COUNT(*) FROM Enquiries WHERE Status = 'New'";

            using (SqlConnection con = new SqlConnection(cs))
            {
                SqlCommand cmd = new SqlCommand(query, con);
                con.Open();

                object result = cmd.ExecuteScalar();
                int count = (result != DBNull.Value) ? Convert.ToInt32(result) : 0;

                lblNewEnquiry.Text = count.ToString();
            }
        }

        void LoadTodaysRevenue()
        {
            string query = @"SELECT ISNULL(SUM(PaidAmount),0)
                     FROM Bookings
                     WHERE BookingStatus = 'Confirmed'
                     AND CAST(BookingDate AS DATE) = CAST(GETDATE() AS DATE)";

            using (SqlConnection con = new SqlConnection(cs))
            {
                SqlCommand cmd = new SqlCommand(query, con);
                con.Open();

                object result = cmd.ExecuteScalar();
                decimal revenue = Convert.ToDecimal(result);

                lblrevenue.Text =  revenue.ToString("N0");
            }
        }
        void LoadPendingPayments()
        {
            string query = @"SELECT ISNULL(SUM(RemainingAmount), 0) 
                     FROM Bookings 
                     WHERE RemainingAmount > 0 AND BookingStatus = 'Confirmed'";

            using (SqlConnection con = new SqlConnection(cs))
            {
                SqlCommand cmd = new SqlCommand(query, con);
                con.Open();

                object result = cmd.ExecuteScalar();
                decimal totalPending = (result != DBNull.Value) ? Convert.ToDecimal(result) : 0;

                lblPendingPayments.Text = totalPending.ToString("N2");
            }
        }
        void graph()
        {
            Dictionary<string, int> revenueData = new Dictionary<string, int>();

            // Get today's date
            DateTime today = DateTime.Today;

            // Calculate Monday of current week
            int diff = (7 + (today.DayOfWeek - DayOfWeek.Monday)) % 7;
            DateTime startOfWeek = today.AddDays(-1 * diff);

            // Initialize Monday to Sunday with 0 revenue
            for (int i = 0; i < 7; i++)
            {
                DateTime date = startOfWeek.AddDays(i);
                revenueData[date.ToString("ddd")] = 0;
            }

            using (SqlConnection con = new SqlConnection(cs))
            {
                con.Open();

                string query = @"
        SELECT CAST(CheckInDate AS DATE) AS RevenueDate,
               SUM(PaidAmount) AS Amount
        FROM Bookings
        WHERE BookingStatus = 'Confirmed'
        AND CAST(CheckInDate AS DATE) >= @StartOfWeek
        AND CAST(CheckInDate AS DATE) <= @EndOfWeek
        GROUP BY CAST(CheckInDate AS DATE)";

                SqlCommand cmd = new SqlCommand(query, con);
                cmd.Parameters.AddWithValue("@StartOfWeek", startOfWeek);
                cmd.Parameters.AddWithValue("@EndOfWeek", startOfWeek.AddDays(6));

                SqlDataReader reader = cmd.ExecuteReader();

                while (reader.Read())
                {
                    DateTime date = Convert.ToDateTime(reader["RevenueDate"]);
                    int amount = Convert.ToInt32(reader["Amount"]);

                    string dayName = date.ToString("ddd");

                    if (revenueData.ContainsKey(dayName))
                    {
                        revenueData[dayName] = amount;
                    }
                }
            }

            var days = revenueData.Keys.ToList();
            var values = revenueData.Values.ToList();

            JavaScriptSerializer js = new JavaScriptSerializer();

            string script = $@"
var ctx = document.getElementById('revenueChart').getContext('2d');
new Chart(ctx, {{
    type: 'line',
    data: {{
        labels: {js.Serialize(days)},
        datasets: [{{
            label: 'Revenue (₹)',
            data: {js.Serialize(values)},
            backgroundColor: 'rgba(54, 162, 235, 0.2)',
            borderColor: 'rgba(54, 162, 235, 1)',
            borderWidth: 2,
            fill: true,
            tension: 0.3
        }}]
    }},
    options: {{
        responsive: true,
        scales: {{
            y: {{ beginAtZero: true }}
        }}
    }}
}});";

            ClientScript.RegisterStartupScript(this.GetType(), "RevenueChartScript", script, true);
        }

        public void LoadBookingStatusChart()
        {
            int confirmed = 0;
            int cancelled = 0;
            int pending = 0;

            using (SqlConnection con = new SqlConnection(cs))
            {
                con.Open();

                SqlCommand cmd = new SqlCommand(
                    "SELECT BookingStatus, COUNT(*) as Total FROM Bookings GROUP BY BookingStatus",
                    con);

                SqlDataReader dr = cmd.ExecuteReader();

                while (dr.Read())
                {
                    string status = dr["BookingStatus"].ToString().Trim().ToLower();

                    if (status == "confirmed")
                        confirmed = Convert.ToInt32(dr["Total"]);
                    else if (status == "cancelled")
                        cancelled = Convert.ToInt32(dr["Total"]);
                    else if (status == "Pending")
                        pending = Convert.ToInt32(dr["Total"]);
                }
            }
            string script = $@"
    var ctx = document.getElementById('bookingStatusChart');
    new Chart(ctx, {{
        type: 'pie',
        data: {{
            labels: ['Confirmed', 'Cancelled', 'Pending'],
            datasets: [{{
                data: [{confirmed}, {cancelled}, {pending}],
                backgroundColor: ['green', 'red', 'orange']
            }}]
        }},
        options: {{
            responsive: true
        }}
    }});";

            ScriptManager.RegisterStartupScript(this, this.GetType(), "BookingChartScript", script, true);
        }
        //Booking Table

        protected void gvAllBookings_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            gvAllBookings.PageIndex = e.NewPageIndex;
            LoadBookingsgrid();
        }

        protected void gvAllBookings_RowCommand(object sender, GridViewCommandEventArgs e)
        {
        }

        void LoadBookingsgrid()
        {
            using (SqlConnection con = new SqlConnection(cs))
            {
                string query = @"SELECT TOP 5 *
                                FROM Bookings
                                ORDER BY BookingDate DESC;";

                SqlDataAdapter da = new SqlDataAdapter(query, con);
                DataTable dt = new DataTable();
                da.Fill(dt);

                gvAllBookings.DataSource = dt;   // ✅ ALWAYS bind
                gvAllBookings.DataBind();
            }
        }

        void LoadTodaysArrivalsGrid()
        {
            string query = @"SELECT 
                        BookingId,
                        GuestName,
                          GuestPhone,
                        RoomType,
                        CheckInDate,
                        BookingStatus,
                        TotalAmount,
                        PaymentStatus
                     FROM Bookings
                     WHERE CAST(CheckInDate AS DATE) = CAST(GETDATE() AS DATE)
                     AND BookingStatus = 'Confirmed'
                     ORDER BY CheckInDate ASC";

            using (SqlConnection con = new SqlConnection(cs))
            {
                SqlDataAdapter da = new SqlDataAdapter(query, con);
                DataTable dt = new DataTable();
                da.Fill(dt);

                GridViewArrivals.DataSource = dt;
                GridViewArrivals.DataBind();
            }
        }

        void LoadTodayDepartures()
        {
            string query = @"SELECT 
    BookingId,
    GuestName,
    RoomType,
    CheckInDate,
    CheckOutDate,
    TotalAmount,
    PaidAmount,
    RemainingAmount
FROM Bookings
WHERE CAST(CheckOutDate AS DATE) = CAST(GETDATE() AS DATE)
ORDER BY CheckOutDate ASC";

            using (SqlConnection con = new SqlConnection(cs))
            {
                SqlDataAdapter da = new SqlDataAdapter(query, con);
                DataTable dt = new DataTable();
                da.Fill(dt);

                GridViewDepartures.DataSource = dt;
                GridViewDepartures.DataBind();
            }
        }

        protected void GridView1_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "Collect")
            {
                int id = Convert.ToInt32(e.CommandArgument);
                hfBookingID.Value = id.ToString();

                SqlConnection con = new SqlConnection(cs);
                SqlCommand cmd = new SqlCommand("SELECT TotalAmount, PaidAmount FROM Bookings WHERE BookingID=@id", con);
                cmd.Parameters.AddWithValue("@id", id);

                con.Open();
                SqlDataReader dr = cmd.ExecuteReader();

                if (dr.Read())
                {
                    lblTotal.Text = dr["TotalAmount"].ToString();
                    lblPaid.Text = dr["PaidAmount"].ToString();
                }

                con.Close();

                pnlPayment.Visible = true;
            }
        }

        protected void btnSavePayment_Click(object sender, EventArgs e)
        {
            decimal total = Convert.ToDecimal(lblTotal.Text);
            decimal paid = Convert.ToDecimal(lblPaid.Text);
            decimal newPayment = Convert.ToDecimal(txtPayment.Text);

            decimal updatedPaid = paid + newPayment;

            if (updatedPaid > total)
            {
                updatedPaid = total;
            }

            decimal remaining = total - updatedPaid;

            string status = (remaining == 0) ? "Paid" : "Partial";

            SqlConnection con = new SqlConnection(cs);
            SqlCommand cmd = new SqlCommand(
                "UPDATE Bookings SET PaidAmount=@paid, RemainingAmount=@remain, PaymentStatus=@status WHERE BookingID=@id",
                con);

            cmd.Parameters.AddWithValue("@paid", updatedPaid);
            cmd.Parameters.AddWithValue("@remain", remaining);
            cmd.Parameters.AddWithValue("@status", status);
            cmd.Parameters.AddWithValue("@id", hfBookingID.Value);

            con.Open();
            cmd.ExecuteNonQuery();
            con.Close();

            pnlPayment.Visible = false;

            LoadTodayDepartures();   // correct reload


        }
        protected void GridView1_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                decimal remaining = Convert.ToDecimal(DataBinder.Eval(e.Row.DataItem, "RemainingAmount"));
                //decimal paid = Convert.ToDecimal(DataBinder.Eval(e.Row.DataItem, "PaidAmount"));

                Button btn = (Button)e.Row.FindControl("btnCollect");

                if (remaining == 0)
                {
                    btn.Text = "Paid ✔";
                    btn.Enabled = false;
                }
            }
        }

        protected void btnClose_Click(object sender, EventArgs e)
        {
            pnlPayment.Visible = false;
            pnlOverlay.Visible = false;
        }
    }

}   


