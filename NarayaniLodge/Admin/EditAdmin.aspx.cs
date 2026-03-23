using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Xml.Linq;

public partial class Admin_EditAdmin : System.Web.UI.Page
{
    string cs = ConfigurationManager.ConnectionStrings["Lodge"].ConnectionString;

    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["AdminId"] == null)
        {
            Response.Redirect("Login.aspx");
        }

        if (!IsPostBack)
        {
            LoadAdminData();
        }
    }

    void LoadAdminData()
    {
        using (SqlConnection con = new SqlConnection(cs))
{
    string query = "SELECT AdminName, Email, Mobile FROM AdminLogin WHERE AdminId=@id";

    SqlCommand cmd = new SqlCommand(query, con);
    cmd.Parameters.AddWithValue("@id", Session["AdminId"]);

    con.Open();

    SqlDataReader dr = cmd.ExecuteReader();

    if (dr.Read())
    {
        txtName.Text = dr["AdminName"].ToString();
        txtEmail.Text = dr["Email"].ToString();
        txtMobile.Text = dr["Mobile"].ToString();
    }
}
        }

        protected void btnUpdate_Click(object sender, EventArgs e)
{
    using (SqlConnection con = new SqlConnection(cs))
    {
        string query = "UPDATE AdminLogin SET AdminName=@name, Email=@email, Mobile=@mobile WHERE AdminId=@id";

        SqlCommand cmd = new SqlCommand(query, con);

        cmd.Parameters.AddWithValue("@name", txtName.Text);
        cmd.Parameters.AddWithValue("@email", txtEmail.Text);
        cmd.Parameters.AddWithValue("@mobile", txtMobile.Text);
        cmd.Parameters.AddWithValue("@id", Session["AdminId"]);

        con.Open();
        cmd.ExecuteNonQuery();
    }

    Response.Redirect("AdminProfile.aspx");
}
    }
