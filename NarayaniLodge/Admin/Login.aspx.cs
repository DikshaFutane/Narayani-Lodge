using System;
using System.Configuration;
using System.Data.SqlClient;
using System.Security.Cryptography;
using System.Text;
using System.Web.UI;

namespace NarayaniLodge.Admin
{
    public partial class Login : System.Web.UI.Page
    {
        string cs = ConfigurationManager.ConnectionStrings["Lodge"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            // If admin already logged in, redirect to dashboard
            if (Session["AdminId"] != null)
            {
                Response.Redirect("Default.aspx");
            }
        }

        protected void btnLogin_Click1(object sender, EventArgs e)
        {
            string username = unm.Value.Trim();
            string password = pass.Value.Trim();

            // Validation
            if (string.IsNullOrEmpty(username) || string.IsNullOrEmpty(password))
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "msg", @"
                Swal.fire({
                    title: 'Please enter Username and Password!',
                    icon: 'warning'
                });", true);
                return;
            }

            string passwordHash = HashPassword(password);

            try
            {
                using (SqlConnection con = new SqlConnection(cs))
                {
                    string query = "SELECT AdminId, AdminName FROM AdminLogin WHERE Username=@u AND PasswordHash=@p";

                    SqlCommand cmd = new SqlCommand(query, con);

                    cmd.Parameters.AddWithValue("@u", username);
                    cmd.Parameters.AddWithValue("@p", passwordHash);

                    con.Open();

                    using (SqlDataReader dr = cmd.ExecuteReader())
                    {
                        if (dr.Read())
                        {
                            // Store admin details in session
                            Session["AdminId"] = dr["AdminId"].ToString();
                            Session["AdminName"] = dr["AdminName"].ToString();
                            Session["AdminUsername"] = username;

                            Response.Redirect("Default.aspx");
                        }
                        else
                        {
                            ScriptManager.RegisterStartupScript(this, this.GetType(), "msg", @"
                            Swal.fire({
                                title: 'Invalid Username or Password!',
                                icon: 'error',
                                confirmButtonText: 'Try Again'
                            });", true);
                        }
                    }
                }
            }
            catch (Exception)
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "msg", @"
                Swal.fire({
                    title: 'Something went wrong!',
                    text: 'Please try again later.',
                    icon: 'error'
                });", true);
            }
        }

        // Password Hash Function
        private string HashPassword(string password)
        {
            using (SHA256 sha256 = SHA256.Create())
            {
                byte[] bytes = sha256.ComputeHash(Encoding.UTF8.GetBytes(password));
                StringBuilder sb = new StringBuilder();

                foreach (byte b in bytes)
                {
                    sb.Append(b.ToString("x2"));
                }

                return sb.ToString();
            }
        }
    }
}