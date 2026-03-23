using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Admin_AdminProfile : System.Web.UI.Page
{
    string cs = ConfigurationManager.ConnectionStrings["Lodge"].ConnectionString;

  
        protected void Page_Load(object sender, EventArgs e)
    {
        // Check if admin is logged in
        //if (Session["AdminId"] == null)
        //{
        //    Response.Redirect("Login.aspx");
        //}

        if (!IsPostBack)
        {
            LoadAdminProfile();
        }
    }

    private void LoadAdminProfile()
    {
        int adminId = Convert.ToInt32(Session["AdminId"]);

        using (SqlConnection con = new SqlConnection(cs))
        {
            string query = "SELECT * FROM AdminLogin WHERE AdminId=3";

            SqlCommand cmd = new SqlCommand(query, con);
            cmd.Parameters.AddWithValue("@AdminId", adminId);

            con.Open();

            SqlDataReader dr = cmd.ExecuteReader();

            if (dr.Read())
            {
                lblName.Text = dr["AdminName"].ToString();
                lblEmail.Text = dr["Email"].ToString();
                lblPhone.Text = dr["Mobile"].ToString();
                lblAdminID.Text = dr["AdminId"].ToString();
                lblUsername.Text = dr["Username"].ToString();
                lblCreated.Text = Convert.ToDateTime(dr["CreatedOn"]).ToString("dd MMM yyyy");

                lblcurrentdevice.Text = Request.Browser.Browser;
            }
        }
    }

    protected void btnUpdate_Click(object sender, EventArgs e)
    {
        Response.Redirect("EditAdmin.aspx");
    }
}
    
