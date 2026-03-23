using NarayaniLodge.Admin;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Admin_AllRooms : System.Web.UI.Page
{
    string cs = ConfigurationManager.ConnectionStrings["Lodge"].ConnectionString;

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            LoadRooms();
        }
    }


    private void LoadRooms()
    {
        using (SqlConnection con = new SqlConnection(cs))
        {
            string query = "SELECT RoomID, RoomName, RoomCode, IsAvailable, PricePerNight, Capacity FROM Rooms WHERE IsDeleted = 0 ORDER BY RoomCode";
            using (SqlDataAdapter da = new SqlDataAdapter(query, con))
            {
                DataTable dt = new DataTable();
                da.Fill(dt);

                gvAllrooms.DataSource = dt;
                gvAllrooms.DataBind();
            }
        }
    }

    protected void gvAllrooms_PageIndexChanging1(object sender, GridViewPageEventArgs e)
    {
        gvAllrooms.PageIndex = e.NewPageIndex;
        LoadRooms();
    }

    protected void gvAllrooms_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        if (e.CommandName == "EditRoom")
        {
            int roomId = Convert.ToInt32(e.CommandArgument);
            Response.Redirect("EditRoom.aspx?RoomID=" + roomId);
        }
    }

    protected void gvAllrooms_RowDeleting(object sender, GridViewDeleteEventArgs e)
    {
        int roomId = Convert.ToInt32(gvAllrooms.DataKeys[e.RowIndex].Value);

        using (SqlConnection con = new SqlConnection(cs))
        {
            string query = "UPDATE Rooms SET IsDeleted = 1, DeletedDate = GETDATE() WHERE RoomId = @RoomId";

            using (SqlCommand cmd = new SqlCommand(query, con))
            {
                cmd.Parameters.AddWithValue("@RoomId", roomId);
                con.Open();
                cmd.ExecuteNonQuery();
                con.Close();
            }
        }

        LoadRooms();
    }

}