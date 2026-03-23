using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Users_EditProfile : System.Web.UI.Page
{
    string cs = ConfigurationManager.ConnectionStrings["Lodge"].ConnectionString;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            LoadUserData();
        }
    }

    void LoadUserData()
    {
        if (Session["UserEmail"] == null)
        {
            Response.Redirect("Login.aspx");
            return;
        }

        string email = Session["UserEmail"].ToString();

        using (SqlConnection con = new SqlConnection(cs))
        {
            string query = "SELECT Name, Email, Phone FROM Users WHERE Email=@Email";
            SqlCommand cmd = new SqlCommand(query, con);
            cmd.Parameters.AddWithValue("@Email", email);

            con.Open();
            SqlDataReader dr = cmd.ExecuteReader();
            if (dr.Read())
            {
                pnlEdit.Visible = true;
                txtFullName.Text = dr["Name"].ToString();
                txtEmail.Text = dr["Email"].ToString();
                txtPhone.Text = dr["Phone"].ToString();
                //txtAddress.Text = dr["Address"].ToString();
            }
            else
            {
                lblMessage.Text = "User profile not found!";
                pnlEdit.Visible = false;
            }
            con.Close();
        }
    }

    protected void btnUpdate_Click(object sender, EventArgs e)
    {
        if (Session["UserEmail"] == null)
        {
            Response.Redirect("Login.aspx");
            return;
        }

        string email = Session["UserEmail"].ToString();
        string fullName = txtFullName.Text.Trim();
        string phone = txtPhone.Text.Trim();
        //string address = txtAddress.Text.Trim(); // if you want to include Address

        using (SqlConnection con = new SqlConnection(cs))
        {
            // ✅ Removed trailing comma and included Address
            string updateQuery = "UPDATE Users SET Name=@Name, Phone=@Phone WHERE Email=@Email";

            SqlCommand cmd = new SqlCommand(updateQuery, con);
            cmd.Parameters.AddWithValue("@Name", fullName);
            cmd.Parameters.AddWithValue("@Phone", phone);
            //cmd.Parameters.AddWithValue("@Address", address);
            cmd.Parameters.AddWithValue("@Email", email);

            con.Open();
            int rows = cmd.ExecuteNonQuery();
            con.Close();

            if (rows > 0)
            {
                // SweetAlert success
                ScriptManager.RegisterStartupScript(this, this.GetType(), "alert",
                    "Swal.fire({icon:'success',title:'Updated!',text:'Profile updated successfully!'});", true);
            }
            else
            {
                // SweetAlert error
                ScriptManager.RegisterStartupScript(this, this.GetType(), "alert",
                    "Swal.fire({icon:'error',title:'Failed!',text:'Profile update failed. Try again.'});", true);
            }
        }
    }

    protected void btnCancel_Click(object sender, EventArgs e)
    {
        Response.Redirect("Default.aspx"); // Go back to profile page
    }
}