using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class ResetPassword : System.Web.UI.Page
{
    string cs = System.Configuration.ConfigurationManager.ConnectionStrings["Lodge"].ConnectionString;

    protected void Page_Load(object sender, EventArgs e)
    {

    }

    protected void btnReset_Click(object sender, EventArgs e)
    {
        string token = Request.QueryString["token"];
        string newPass = txtNewPass.Text.Trim();

        if (string.IsNullOrEmpty(token))
        {
            ScriptManager.RegisterStartupScript(this, GetType(), "alert",
                "showAlert('error','Invalid reset link!');", true);
            return;
        }

        using (SqlConnection con = new SqlConnection(cs))
        {
            con.Open();

            SqlCommand cmd = new SqlCommand(
            "SELECT Email FROM PasswordReset WHERE Token=@Token AND Expiry > GETDATE()", con);

            cmd.Parameters.AddWithValue("@Token", token);

            object result = cmd.ExecuteScalar();

            if (result != null)
            {
                string email = result.ToString();
                string hashedPass = HashPassword(newPass);

                // 🔍 Check in Users table
                SqlCommand checkUser = new SqlCommand(
                    "SELECT COUNT(*) FROM Users WHERE Email=@Email", con);
                checkUser.Parameters.AddWithValue("@Email", email);

                int userExists = (int)checkUser.ExecuteScalar();

                if (userExists > 0)
                {
                    // ✅ Update USER password
                    SqlCommand updateUser = new SqlCommand(
                        "UPDATE Users SET Password=@Pass WHERE Email=@Email", con);

                    updateUser.Parameters.AddWithValue("@Pass", hashedPass);
                    updateUser.Parameters.AddWithValue("@Email", email);
                    updateUser.ExecuteNonQuery();
                }
                else
                {
                    // 🔍 Check in Admin table
                    SqlCommand checkAdmin = new SqlCommand(
                        "SELECT COUNT(*) FROM Admin WHERE Email=@Email", con);
                    checkAdmin.Parameters.AddWithValue("@Email", email);

                    int adminExists = (int)checkAdmin.ExecuteScalar();

                    if (adminExists > 0)
                    {
                        // ✅ Update ADMIN password
                        SqlCommand updateAdmin = new SqlCommand(
                            "UPDATE Admin SET Password=@Pass WHERE Email=@Email", con);

                        updateAdmin.Parameters.AddWithValue("@Pass", hashedPass);
                        updateAdmin.Parameters.AddWithValue("@Email", email);
                        updateAdmin.ExecuteNonQuery();
                    }
                    else
                    {
                        ScriptManager.RegisterStartupScript(this, GetType(), "alert",
                            "showAlert('error','User not found!');", true);
                        return;
                    }
                }

                // 🧹 Delete token after success
                SqlCommand del = new SqlCommand(
                    "DELETE FROM PasswordReset WHERE Token=@Token", con);

                del.Parameters.AddWithValue("@Token", token);
                del.ExecuteNonQuery();

                // ✅ Success Alert
                ScriptManager.RegisterStartupScript(this, GetType(), "alert",
                    "Swal.fire({icon:'success',title:'Password Reset Successful!'}).then(()=>{ window.location='Authentication/Login.aspx'; });",
                    true);
            }
            else
            {
                ScriptManager.RegisterStartupScript(this, GetType(), "alert",
                    "showAlert('error','Invalid or Expired Link!');", true);
            }
        }
    }
    private string HashPassword(string password)
    {
        using (var sha = System.Security.Cryptography.SHA256.Create())
        {
            byte[] bytes = System.Text.Encoding.UTF8.GetBytes(password);
            byte[] hash = sha.ComputeHash(bytes);
            return Convert.ToBase64String(hash);
        }
    }
}
