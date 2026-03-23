using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Xml.Linq;

public partial class Admin_EditRoom : System.Web.UI.Page
{
    string cs = ConfigurationManager.ConnectionStrings["Lodge"].ConnectionString;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            if (Request.QueryString["RoomID"] != null)
            {
                int roomId = Convert.ToInt32(Request.QueryString["RoomID"]);
                LoadRoom(roomId);
            }
        }

    }

    private void LoadRoom(int RoomID)
    {
        using (SqlConnection con = new SqlConnection(cs))
        {
            string query = @"SELECT RoomName, RoomCode, PricePerNight ,Capacity,RoomDescription,IsAvailable
                         FROM Rooms 
                         WHERE RoomID = @RoomID";

            SqlCommand cmd = new SqlCommand(query, con);
            cmd.Parameters.AddWithValue("@RoomID", RoomID);

            con.Open();
            SqlDataReader dr = cmd.ExecuteReader();

            if (dr.Read())
            {
                txtroomno.Value = dr["RoomCode"].ToString();
                txtroomnm.Value = dr["RoomName"].ToString();
                txtprice.Value = dr["PricePerNight"].ToString();
                txtcapacity.Value = dr["Capacity"].ToString();
                txtdesc.Value = dr["RoomDescription"].ToString();
                chkIsAvailable.Checked = Convert.ToBoolean(dr["IsAvailable"]);


            }
        }
    }


    protected void btnSaveBooking_Click(object sender, EventArgs e)
    {
        if (Request.QueryString["RoomID"] != null)
        {
            int roomId = Convert.ToInt32(Request.QueryString["RoomID"]);

            using (SqlConnection con = new SqlConnection(cs))
            {
                string query = @"UPDATE Rooms 
                             SET PricePerNight = @Price,
                                 Capacity = @Capacity,
                                 RoomDescription = @Description,
                                 IsAvailable = @IsAvailable,
                                UpdatedDate = GETDATE()
                             WHERE RoomID = @RoomID";

                SqlCommand cmd = new SqlCommand(query, con);

                cmd.Parameters.AddWithValue("@Price", txtprice.Value);
                cmd.Parameters.AddWithValue("@Capacity", txtcapacity.Value);
                cmd.Parameters.AddWithValue("@Description", txtdesc.Value);
                cmd.Parameters.AddWithValue("@IsAvailable", chkIsAvailable.Checked);
                cmd.Parameters.AddWithValue("@RoomID", roomId);

                con.Open();
                cmd.ExecuteNonQuery();
            }

            // Redirect back to AllRooms page
            Response.Redirect("AllRooms.aspx");
        }
    }

    protected void cancel_Click(object sender, EventArgs e)
    {
        Response.Redirect("AllRooms.aspx");
    }
}