using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Admin_enquiries : System.Web.UI.Page
{
    string cs = ConfigurationManager.ConnectionStrings["Lodge"].ConnectionString;

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            LoadEnquiries();
        }
    }

    protected void gvEnquiries_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        if (e.CommandName == "Reply")
        {
            Response.Redirect("ReplyEnquiry.aspx?EnquiryId=" + e.CommandArgument);
        }
    }
    void LoadEnquiries()
    {
        using (SqlConnection con = new SqlConnection(cs))
        {
            SqlDataAdapter da = new SqlDataAdapter(
                "SELECT EnquiryId, GuestName, GuestEmail, GuestPhone, Message, EnquiryDate, Status FROM Enquiries WHERE Status = 'New' ORDER BY EnquiryDate DESC", con);

            DataTable dt = new DataTable();
            da.Fill(dt);

            gvEnquiries.DataSource = dt;
            gvEnquiries.DataBind();
        }
    }
}