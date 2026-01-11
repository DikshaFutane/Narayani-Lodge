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

namespace NarayaniLodge.Admin
{
    public partial class Login : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        string cs = ConfigurationManager.ConnectionStrings["Lodge"].ConnectionString;
        protected void btnLogin_Click1(object sender, EventArgs e)
        {
            //lblmsg.Text = "btn is clickabel";
            string username = unm.Value.Trim();
            string password = pass.Value.Trim();
            string passwordHash = HashPassword(password);

            using (SqlConnection con = new SqlConnection(cs))
            {
                string query = "SELECT COUNT(*) FROM AdminLogin WHERE Username=@u AND PasswordHash=@p";
                SqlCommand cmd = new SqlCommand(query, con);

                cmd.Parameters.AddWithValue("@u", username);
                cmd.Parameters.AddWithValue("@p", passwordHash);

                con.Open();
                int count = Convert.ToInt32(cmd.ExecuteScalar());

                if (count == 1)
                {
                    Session["Admin"] = username;
                    Response.Redirect("Default.aspx");
                }
                else
                {
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "welcomeMsg", @"
            Swal.fire({
                title: 'Invalid Admin!',
                icon: 'error',
                confirmButtonText: 'Try Again'
            });
        ", true);

                }
            }
        }
             private string HashPassword(string password)
        {
            using (SHA256 sha256 = SHA256.Create())
            {
                byte[] bytes = sha256.ComputeHash(Encoding.UTF8.GetBytes(password));
                StringBuilder sb = new StringBuilder();
                foreach (byte b in bytes)
                    sb.Append(b.ToString("x2"));
                return sb.ToString();
            }
        }

    }
}
