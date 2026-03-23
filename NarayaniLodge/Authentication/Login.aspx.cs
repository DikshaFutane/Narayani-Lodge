using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Security.Cryptography;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Authentication_Login : System.Web.UI.Page
{
    string cs = ConfigurationManager.ConnectionStrings["Lodge"].ConnectionString;

    protected void Page_Load(object sender, EventArgs e)
    {

    }

    protected void btnLogin_Click(object sender, EventArgs e)
    {
        SqlConnection con = new SqlConnection(cs);

        string hashedPassword = HashPassword(txtPassword.Text);

        string query = "select * from Users where Email=@Email and Password=@Password and Status='Active'";

        SqlCommand cmd = new SqlCommand(query, con);

        cmd.Parameters.AddWithValue("@Email", txtEmail.Text);
        cmd.Parameters.AddWithValue("@Password", hashedPassword);

        con.Open();

        SqlDataReader dr = cmd.ExecuteReader();

        if (dr.HasRows)
        {
            dr.Read();
            Session["Email"] = dr["Email"].ToString();
            Session["UserID"] = dr["UserID"].ToString();
            Session["UserName"] = dr["Name"].ToString();
            Session["UserEmail"] = dr["Email"].ToString();
            Session["GuestPhone"] = dr["Phone"].ToString();

            Response.Redirect("~/Users/Default.aspx");
        }
        else
        {
            lblmsg.Text = "Invalid Email or Password";
            lblmsg.ForeColor = System.Drawing.Color.Red;
        }

        con.Close();

    }

    string HashPassword(string password)
    {
        using (var sha = System.Security.Cryptography.SHA256.Create())
        {
            byte[] bytes = System.Text.Encoding.UTF8.GetBytes(password);
            byte[] hash = sha.ComputeHash(bytes);
            return Convert.ToBase64String(hash); // SAME AS RESET
        }
    }

}
