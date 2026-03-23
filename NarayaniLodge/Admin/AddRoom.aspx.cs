using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Admin_AddRoom : System.Web.UI.Page
{
    string cs = ConfigurationManager.ConnectionStrings["Lodge"].ConnectionString;

    protected void Page_Load(object sender, EventArgs e)
    {

    }

    protected void btnSaveBooking_Click(object sender, EventArgs e)
    {

        if (Page.IsValid)
        {
            using (SqlConnection con = new SqlConnection(cs))
            {
                con.Open();

                // 🔍 Check Duplicate Room Number
                string checkQuery = "SELECT COUNT(*) FROM Rooms WHERE RoomCode=@RoomCode";
                SqlCommand checkCmd = new SqlCommand(checkQuery, con);
                checkCmd.Parameters.AddWithValue("@RoomCode", txtroomno.Value);

                int count = (int)checkCmd.ExecuteScalar();

                if (count > 0)
                {
                    string errorScript = "Swal.fire({ icon: 'error', title: 'Oops...', text: 'Room Number already exists!' });";
                    ClientScript.RegisterStartupScript(this.GetType(), "alert1", errorScript, true);
                    return;
                }

                // ✅ Insert Room
                string query = @"INSERT INTO Rooms 
                                (RoomName, RoomCode, PricePerNight, Capacity, IsAvailable, CreatedDate, RoomDescription)
                                 VALUES 
                                (@RoomName, @RoomCode, @PricePerNight, @Capacity, 0, GETDATE(), @RoomDescription)";

                SqlCommand cmd = new SqlCommand(query, con);

                cmd.Parameters.AddWithValue("@RoomName", ddlroom.SelectedItem.Text);
                cmd.Parameters.AddWithValue("@RoomCode", txtroomno.Value);
                cmd.Parameters.AddWithValue("@PricePerNight", price.Value);
                cmd.Parameters.AddWithValue("@Capacity", DropDownList1.SelectedValue);
                cmd.Parameters.AddWithValue("@RoomDescription", desc.Value);

                cmd.ExecuteNonQuery();

                con.Close();

                string script = "Swal.fire({ icon: 'success', title: 'Success!', text: 'Room Added Successfully!' });";
                ClientScript.RegisterStartupScript(this.GetType(), "alert", script, true);
                ClearForm();
            }
        }
    }

    private void ClearForm()
    {
        txtroomno.Value = "";
        price.Value = "";
        desc.Value = "";
        ddlroom.SelectedIndex = 0;
        DropDownList1.SelectedIndex = 0;
    }
}