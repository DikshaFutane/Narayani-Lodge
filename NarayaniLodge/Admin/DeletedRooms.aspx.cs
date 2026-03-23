using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Admin_DeletedRooms : System.Web.UI.Page
{
    string cs = ConfigurationManager.ConnectionStrings["Lodge"].ConnectionString;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            LoadDeletedRooms();
        }
    }

    private void LoadDeletedRooms()
    {
        using (SqlConnection con = new SqlConnection(cs))
        {
            string query = @"SELECT RoomID, RoomName, RoomCode, 
                             PricePerNight, Capacity, DeletedDate
                             FROM Rooms
                             WHERE IsDeleted = 1
                             ORDER BY DeletedDate DESC";

            using (SqlDataAdapter da = new SqlDataAdapter(query, con))
            {
                DataTable dt = new DataTable();
                da.Fill(dt);

                gvDelrooms.DataSource = dt;
                gvDelrooms.DataBind();
            }
        }
    }

    protected void gvDelrooms_PageIndexChanging1(object sender, GridViewPageEventArgs e)
    {
        gvDelrooms.PageIndex = e.NewPageIndex;
        LoadDeletedRooms();
    }

    protected void gvDelrooms_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        if (e.CommandName == "Restore" || e.CommandName == "Delete")
        {
            int roomId = Convert.ToInt32(e.CommandArgument);

            using (SqlConnection con = new SqlConnection(cs))
            {
                con.Open();

                // ✅ RESTORE ROOM
                if (e.CommandName == "Restore")
                {
                    string query = @"UPDATE Rooms 
                                 SET IsDeleted = 0, 
                                     DeletedDate = NULL 
                                 WHERE RoomID = @RoomID";

                    using (SqlCommand cmd = new SqlCommand(query, con))
                    {
                        cmd.Parameters.AddWithValue("@RoomID", roomId);
                        cmd.ExecuteNonQuery();
                    }
                }

                // ✅ PERMANENT DELETE (Safe Version)
                else if (e.CommandName == "Delete")
                {
                    // Check if room exists in Bookings
                    string checkQuery = "SELECT COUNT(*) FROM Bookings WHERE RoomID = @RoomID";
                    SqlCommand checkCmd = new SqlCommand(checkQuery, con);
                    checkCmd.Parameters.AddWithValue("@RoomID", roomId);

                    int count = (int)checkCmd.ExecuteScalar();

                    if (count == 0)
                    {
                        string deleteQuery = "DELETE FROM Rooms WHERE RoomID = @RoomID";

                        SqlCommand deleteCmd = new SqlCommand(deleteQuery, con);
                        deleteCmd.Parameters.AddWithValue("@RoomID", roomId);
                        deleteCmd.ExecuteNonQuery();
                    }
                    else
                    {
                        ScriptManager.RegisterStartupScript(this, this.GetType(), "alert",
                            "alert('Cannot delete! Room has booking history.');", true);
                    }
                }
            }

            LoadDeletedRooms();
        }
    }

}