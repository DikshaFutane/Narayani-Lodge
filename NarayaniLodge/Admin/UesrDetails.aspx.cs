using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Admin_UesrDetails : System.Web.UI.Page
{
    string cs = ConfigurationManager.ConnectionStrings["Lodge"].ConnectionString;
    int userid;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Request.QueryString["UserID"] != null)
        {
            userid = Convert.ToInt32(Request.QueryString["UserID"]);

            if (!IsPostBack)
            {
                LoadUserDetails();
                LoadUserBookings();
            }
        }
    }

    void LoadUserDetails()
    {
        using (SqlConnection con = new SqlConnection(cs))
        {
            string query = "SELECT * FROM Users WHERE UserID=@uid";

            SqlCommand cmd = new SqlCommand(query, con);
            cmd.Parameters.AddWithValue("@uid", userid);

            con.Open();
            SqlDataReader dr = cmd.ExecuteReader();

            if (dr.Read())
            {
                lblUserID.Text = dr["UserID"].ToString();
                lblName.Text = dr["Name"].ToString();
                lblEmail.Text = dr["Email"].ToString();
                lblPhone.Text = dr["Phone"].ToString();
                lblDate.Text = Convert.ToDateTime(dr["CreatedAt"]).ToString("dd-MM-yyyy");
                lblStatus.Text = dr["Status"].ToString();
                if (dr["Status"].ToString() == "Blocked")
                {
                    btnBlock.Visible = false;
                    btnUnblock.Visible = true;
                }
                else
                {
                    btnBlock.Visible = true;
                    btnUnblock.Visible = false;
                }
            }

            con.Close();
        }
    }


    protected void btnBlock_Click(object sender, EventArgs e)
    {
        using (SqlConnection con = new SqlConnection(cs))
        {
            string query = "UPDATE Users SET Status='Blocked' WHERE UserID=@uid";

            SqlCommand cmd = new SqlCommand(query, con);
            cmd.Parameters.AddWithValue("@uid", userid);

            con.Open();
            cmd.ExecuteNonQuery();
            con.Close();
        }

        LoadUserDetails();
    }


    protected void btnUnblock_Click(object sender, EventArgs e)
    {
        using (SqlConnection con = new SqlConnection(cs))
        {
            string query = "UPDATE Users SET Status='Active' WHERE UserID=@uid";

            SqlCommand cmd = new SqlCommand(query, con);
            cmd.Parameters.AddWithValue("@uid", userid);

            con.Open();
            cmd.ExecuteNonQuery();
            con.Close();
        }

        LoadUserDetails();
    }
    void LoadUserBookings()
    {
        using (SqlConnection con = new SqlConnection(cs))
        {
            string email = lblEmail.Text;

            string query = @"SELECT BookingId, RoomType, CheckInDate, CheckOutDate, BookingStatus
                         FROM Bookings
                         WHERE GuestEmail=@Email";

            SqlCommand cmd = new SqlCommand(query, con);
            cmd.Parameters.AddWithValue("@Email", email);

            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            da.Fill(dt);

            gvUserBookings.DataSource = dt;
            gvUserBookings.DataBind();
        }
    }
}