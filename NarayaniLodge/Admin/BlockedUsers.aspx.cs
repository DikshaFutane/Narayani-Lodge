using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Admin_BlockedUsers : System.Web.UI.Page
{
    string cs = ConfigurationManager.ConnectionStrings["Lodge"].ConnectionString;

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            LoadBlockedUsers();
        }
    }

    void LoadBlockedUsers()
    {
        using (SqlConnection con = new SqlConnection(cs))
        {
            string query = "SELECT UserID, Name, Email, Phone, CreatedAt, Status FROM Users WHERE Status='Blocked'";

            SqlDataAdapter da = new SqlDataAdapter(query, con);
            DataTable dt = new DataTable();
            da.Fill(dt);

            gvAllusers.DataSource = dt;
            gvAllusers.DataBind();
        }
    }

    protected void gvAllusers_PageIndexChanging1(object sender, System.Web.UI.WebControls.GridViewPageEventArgs e)
    {
        gvAllusers.PageIndex = e.NewPageIndex;
        LoadBlockedUsers();
    }

    protected void gvAllusers_RowCommand(object sender, System.Web.UI.WebControls.GridViewCommandEventArgs e)
    {
        if (e.CommandName == "UnblockUser")
        {
            int userid = Convert.ToInt32(e.CommandArgument);
            UnblockUser(userid);
        }
    }

    void UnblockUser(int userid)
    {
        using (SqlConnection con = new SqlConnection(cs))
        {
            string query = "UPDATE Users SET Status='Active' WHERE UserID=@uid";

            SqlCommand cmd = new SqlCommand(query, con);
            cmd.Parameters.AddWithValue("@uid", userid);

            con.Open();
            cmd.ExecuteNonQuery();
            con.Close();

            LoadBlockedUsers();
        }
    }
}