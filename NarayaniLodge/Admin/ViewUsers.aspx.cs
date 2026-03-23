using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Admin_ViewUsers : System.Web.UI.Page
{
    string cs = ConfigurationManager.ConnectionStrings["Lodge"].ConnectionString;

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            LoadUsers();
        }
    }

    protected void gvAllusers_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            // Get the Status value for this row
            string status = DataBinder.Eval(e.Row.DataItem, "Status").ToString();

            // Find the buttons
            Button btnView = (Button)e.Row.FindControl("btnEdit");
            Button btnBlock = (Button)e.Row.FindControl("btnBlock");

            if (status == "Blocked")
            {
                btnView.Visible = true;      // Show View button
                btnBlock.Visible = false;    // Hide Block button
            }
            else
            {
                btnView.Visible = true;     // Hide View button
                btnBlock.Visible = true;     // Show Block button
            }
        }
    }
    void LoadUsers()
    {
        using (SqlConnection con = new SqlConnection(cs))
        {
            string query = "SELECT UserID, Name, Email, Phone, CreatedAt, Status FROM Users";

            SqlDataAdapter da = new SqlDataAdapter(query, con);
            DataTable dt = new DataTable();
            da.Fill(dt);

            gvAllusers.DataSource = dt;
            gvAllusers.DataBind();
        }
    }

    // Pagination
    protected void gvAllusers_PageIndexChanging1(object sender, System.Web.UI.WebControls.GridViewPageEventArgs e)
    {
        gvAllusers.PageIndex = e.NewPageIndex;
        LoadUsers();
    }

    // Row Commands (View / Block)
    protected void gvAllusers_RowCommand(object sender, System.Web.UI.WebControls.GridViewCommandEventArgs e)
    {
        int userid = Convert.ToInt32(e.CommandArgument);

        if (e.CommandName == "Viewuser")
        {
            Response.Redirect("UesrDetails.aspx?UserID=" + userid);
        }

        if (e.CommandName == "BlockUser")
        {
            BlockUser(userid);
        }
    }

    void BlockUser(int userid)
    {
        using (SqlConnection con = new SqlConnection(cs))
        {
            string query = "UPDATE Users SET Status='Blocked' WHERE UserID=@uid";

            SqlCommand cmd = new SqlCommand(query, con);
            cmd.Parameters.AddWithValue("@uid", userid);

            con.Open();
            cmd.ExecuteNonQuery();
            con.Close();

            LoadUsers();
        }
    }
}