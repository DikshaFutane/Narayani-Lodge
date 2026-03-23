using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Users_ViewProfile : System.Web.UI.Page
{
    string cs = ConfigurationManager.ConnectionStrings["Lodge"].ConnectionString;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            LoadUserProfile();
        }
    }

    void LoadUserProfile()
    {
        if (Session["UserEmail"] == null)
        {
            Response.Redirect("Login.aspx"); // Redirect to login if not logged in
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
                pnlProfile.Visible = true;
                lblName.Text = dr["Name"].ToString();
                lblEmail.Text = dr["Email"].ToString();
                lblPhone.Text = dr["Phone"].ToString();
            }
            else
            {
                lblMessage.Text = "User profile not found!";
                pnlProfile.Visible = false;
            }
            con.Close();
        }
    }

    protected void btnEditProfile_Click(object sender, EventArgs e)
    {
        // Redirect to Edit Profile page
        Response.Redirect("EditProfile.aspx");
    }
}