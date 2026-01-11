using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace NarayaniLodge.Admin
{
    public partial class Default : System.Web.UI.Page
    {
        //Connection String
        string cs = ConfigurationManager.ConnectionStrings["Lodge"].ConnectionString;
        
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {

                LoadTodaysBooking();
                LoadRoomOccupy();
                LoadRooms();
                newenquiry();
                Loadenq();
                revenue();
                Loadrevenue();
            }
            if (Session["Admin"] == null)
            {
                Response.Redirect("Login.aspx");
            }
        }

        void LoadTodaysBooking()
        {
            string query = "SELECT COUNT(*) FROM Bookings WHERE CAST(BookingDate AS DATE)= CAST(GETDATE() AS DATE)";
            using (SqlConnection con = new SqlConnection(cs))
            {
                SqlCommand cmd = new SqlCommand(query, con);
                con.Open();
                object result = cmd.ExecuteScalar();
                int count = (result != DBNull.Value) ? Convert.ToInt32(result) : 0;
               lblbookings.Text = count.ToString();
            }
        }

        void LoadRooms()
        {
            string query = "SELECT COUNT(*) FROM Rooms";
            using (SqlConnection con = new SqlConnection(cs))
            {
                SqlCommand cmd = new SqlCommand(query, con);
                con.Open();
                object result = cmd.ExecuteScalar();
                int room = (result != DBNull.Value) ? Convert.ToInt32(result) : 0;
                lblRooms.Text = room.ToString();
            }
        }

        void newenquiry()
        {
            string query = "SELECT COUNT(*) FROM Enquiries WHERE Status='New'";
            using (SqlConnection con = new SqlConnection(cs))
            {
                SqlCommand cmd = new SqlCommand(query, con);
                con.Open();
                object result = cmd.ExecuteScalar();
                int enq = (result != DBNull.Value) ? Convert.ToInt32(result) : 0;
                lblenq.Text = enq.ToString();
            }
        }

        void revenue()
        {
            string query = "SELECT SUM(TotalAmount) FROM Bookings WHERE CAST(BookingDate AS DATE) = CAST(GETDATE() AS DATE)";
            using (SqlConnection con = new SqlConnection(cs))
            {
                SqlCommand cmd = new SqlCommand(query, con);
                con.Open();
                object result = cmd.ExecuteScalar();
                int cost = (result != DBNull.Value) ? Convert.ToInt32(result) : 0;
                lblrevenue.Text = cost.ToString();
            }
        }

        void LoadRoomOccupy()
        {
            int totalroom = 0;
            int totalbooking = 0;

            using (SqlConnection con = new SqlConnection(cs))
            {
                SqlCommand cmd = new SqlCommand("SELECT COUNT(*) FROM Bookings WHERE CAST(BookingDate AS DATE)= CAST(GETDATE() AS DATE)", con);
                con.Open();
                object result = cmd.ExecuteScalar();
                totalbooking = (result != DBNull.Value) ? Convert.ToInt32(result) : 0;
            }

            using (SqlConnection con = new SqlConnection(cs))
            {
                SqlCommand cmd = new SqlCommand("SELECT COUNT(*) FROM Rooms", con);
                con.Open();
                object result = cmd.ExecuteScalar();
                totalroom = (result != DBNull.Value) ? Convert.ToInt32(result) : 0;
            }

            int percentage = (totalroom > 0) ? (totalbooking * 100 / totalroom) : 0;
            progressPercent.Text = percentage + "%";
            progressBar.Style["width"] = percentage + "%";
        }

        void Loadenq()
        {
            int totalenq = 0;
            int newenq = 0;

            using (SqlConnection con = new SqlConnection(cs))
            {
                SqlCommand cmd = new SqlCommand("SELECT COUNT(*) FROM Enquiries", con);
                con.Open();
                object result = cmd.ExecuteScalar();
                totalenq = (result != DBNull.Value) ? Convert.ToInt32(result) : 0;
            }

            using (SqlConnection con = new SqlConnection(cs))
            {
                SqlCommand cmd = new SqlCommand("SELECT COUNT(*) FROM Enquiries WHERE Status ='New'", con);
                con.Open();
                object result = cmd.ExecuteScalar();
                newenq = (result != DBNull.Value) ? Convert.ToInt32(result) : 0;
            }

            int percentage = (totalenq > 0) ? (newenq * 100 / totalenq) : 0; // fixed logic
            enq.Text = percentage + "%";
            enqprogressBar.Style["width"] = percentage + "%";
        }

        void Loadrevenue()
        {
            int totalrev = 0;
            int todayrev = 0;

            using (SqlConnection con = new SqlConnection(cs))
            {
                SqlCommand cmd = new SqlCommand("SELECT SUM(TotalAmount) FROM Bookings", con); // fixed typo
                con.Open();
                object result = cmd.ExecuteScalar();
                totalrev = (result != DBNull.Value) ? Convert.ToInt32(result) : 0;
            }

            using (SqlConnection con = new SqlConnection(cs))
            {
                SqlCommand cmd = new SqlCommand("SELECT SUM(TotalAmount) FROM Bookings WHERE CAST(BookingDate AS DATE) = CAST(GETDATE() AS DATE)", con); // fixed extra quote
                con.Open();
                object result = cmd.ExecuteScalar();
                todayrev = (result != DBNull.Value) ? Convert.ToInt32(result) : 0;
            }

            int percentage = (totalrev > 0) ? (todayrev * 100 / totalrev) : 0; // fixed logic
            lblrev.Text = percentage + "%";
            revenueBar.Style["width"] = percentage + "%";
        }

        //Booking Table
        
    }
}