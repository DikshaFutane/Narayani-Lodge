using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Users_UserSite : System.Web.UI.MasterPage
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["UserEmail"] == null)
        {
            Response.Redirect("~/Authentication/Login.aspx");
        }

        if (!IsPostBack)
        {
            lblUserName.Text = Session["UserName"].ToString();
        }

    }
}
