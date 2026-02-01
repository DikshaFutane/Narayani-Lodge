using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class BookNow : System.Web.UI.Page
{
    string cs = ConfigurationManager.ConnectionStrings["Lodge"].ConnectionString;

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            LoadRooms();

            if (Request.QueryString["msg"] == "success")
            {
                ScriptManager.RegisterStartupScript(
                           this,
                           GetType(),
                           "SweetAlert",
                           "Swal.fire({ icon: 'success', title: 'Success', text: 'Booking request submitted! Our team will contact you soon.' });",
                           true
                       );
            }
        }
    }
    void LoadRooms()
    {
        using (SqlConnection con = new SqlConnection(cs))
        {
            string query = "SELECT RoomID, RoomName FROM Rooms";
            using (SqlCommand cmd = new SqlCommand(query, con))
            {
                SqlDataAdapter da = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                da.Fill(dt);

                ddlRoom.DataSource = dt;
                ddlRoom.DataTextField = "RoomName";  // what the user will see
                ddlRoom.DataValueField = "RoomID";   // actual value
                ddlRoom.DataBind();
            }

            ddlRoom.Items.Insert(0, new ListItem("--Select Room--", "0"));
        }
    }


    protected void btnBookNow_Click(object sender, EventArgs e)
    {
        if (!Page.IsValid)
            return;

        DateTime checkIn, checkOut;

        if (!DateTime.TryParse(txtCheckIn.Value, out checkIn) ||
            !DateTime.TryParse(txtCheckOut.Value, out checkOut))
        {
            ShowMessage("Invalid date format.");
            return;
        }

        if (checkOut <= checkIn)
        {
            ShowMessage("Check-out date must be after check-in date.");
            return;
        }

        
        using (SqlConnection con = new SqlConnection(cs))
        {
            string query = @"
INSERT INTO Bookings
(
    BookingDate,
    GuestName,
    GuestEmail,
    GuestPhone,
    GuestAddress,
  RoomId,
    RoomType,
    NoOfRooms,
    CheckInDate,
    CheckOutDate,
    BookingStatus,
    CreatedAt
)
VALUES
(
    GETDATE(),
    @GuestName,
    @GuestEmail,
    @GuestPhone,
    @GuestAddress,
  @RoomId,
    @RoomType,
    @NoOfRooms,
    @CheckInDate,
    @CheckOutDate,
    'Pending',
    GETDATE()
)";
            


            SqlCommand cmd = new SqlCommand(query, con);

            cmd.Parameters.AddWithValue("@GuestName", name.Value);
            cmd.Parameters.AddWithValue("@GuestEmail", txtEmailAddress.Value);
            cmd.Parameters.AddWithValue("@GuestPhone", phn.Value);
            cmd.Parameters.AddWithValue("@GuestAddress", txtAddress.Value);
            cmd.Parameters.AddWithValue("@RoomType", ddlRoom.SelectedItem.Text);
            cmd.Parameters.AddWithValue("@RoomId", SqlDbType.Int).Value = Convert.ToInt32(ddlRoom.SelectedValue);
            cmd.Parameters.AddWithValue("@NoOfRooms", txtRoomCount.Value);
            cmd.Parameters.AddWithValue("@CheckInDate", checkIn);
            cmd.Parameters.AddWithValue("@CheckOutDate", checkOut);

            con.Open();
            cmd.ExecuteNonQuery();
            con.Close();
        }

        // Redirect to the same page
        Response.Redirect("BookNow.aspx?msg=success");

        ClearForm();
    }
    private void ClearForm()
    {
        name.Value = "";
        txtEmailAddress.Value = "";
        phn.Value = "";
        txtAddress.Value = "";
        ddlRoom.SelectedIndex = 0;
        txtRoomCount.Value = "1";
        txtCheckIn.Value = "";
        txtCheckOut.Value = "";
    }

    private void ShowMessage(string message)
    {
        ScriptManager.RegisterStartupScript(
            this,
            GetType(),
            "SweetAlert",
            $"Swal.fire({{ icon: 'success', title: 'Success', text: '{message}' }});",
            true
        );
    }

    private void ShowWarning(string message)
    {
        ScriptManager.RegisterStartupScript(
            this,
            GetType(),
            "SweetAlertWarning",
            $"Swal.fire({{ icon: 'warning', title: 'Oops!', text: '{message}' }});",
            true
        );
    }

}