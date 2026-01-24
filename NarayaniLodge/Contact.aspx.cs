using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Contact : System.Web.UI.Page
{
    //Connection String
    string cs = ConfigurationManager.ConnectionStrings["Lodge"].ConnectionString; 

    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        lblMsg.Text = "";
        if (!Page.IsValid)
        {
            return; // stop execution if validation fails
        }
        using (SqlConnection con = new SqlConnection(cs))
        {
            
            string query = @"INSERT INTO Enquiries
                         (GuestName,GuestPhone, GuestEmail, Message, EnquiryDate, Status)
                         VALUES
                         (@Name,@Phone ,@Email, @Message, GETDATE(), 'New')";

            SqlCommand cmd = new SqlCommand(query, con);
            cmd.Parameters.AddWithValue("@Name", txtName.Text);
            cmd.Parameters.AddWithValue("@Email", txtEmail.Text);
            cmd.Parameters.AddWithValue("@Phone", txtphone.Text);
            cmd.Parameters.AddWithValue("@Message", txtMessage.Text);

            con.Open();
            cmd.ExecuteNonQuery();
        }


        ClientScript.RegisterStartupScript(this.GetType(), "successToast", @"
    Swal.fire({
        toast: true,
        position: 'middle-end',
        icon: 'success',
        title: 'Enquiry submitted',
        showConfirmButton: false,
        timer: 2000,
        timerProgressBar: true
    });
", true);
        txtName.Text = "";
        txtEmail.Text = "";
        txtphone.Text = "";
        txtMessage.Text = ""; 
    }
}