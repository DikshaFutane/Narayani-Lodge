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

public partial class Admin_changepassword : System.Web.UI.Page
{
    string cs = ConfigurationManager.ConnectionStrings["Lodge"].ConnectionString;

    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["Email"] == null || Session["Role"] == null || Session["Role"].ToString() != "admin")
        {
            ScriptManager.RegisterStartupScript(this, GetType(), "alert",
                "Swal.fire('error','You must login as admin!','error').then(()=>{ window.location='../Admin/AdminLogin.aspx'; });", true);
            return;
        }
    }

    protected void btnChange_Click(object sender, EventArgs e)
    {
        string email = Session["Email"].ToString();
        string currentPassword = txtCurrent.Text.Trim();
        string newPassword = txtNew.Text.Trim();

        string hashedCurrent = HashPassword(currentPassword);
        string hashedNew = HashPassword(newPassword);

        using (SqlConnection con = new SqlConnection(cs))
        {
            con.Open();

            // 1️⃣ Check current password
            string checkQuery = "SELECT COUNT(*) FROM Admin WHERE Email=@Email AND Password=@Password";
            using (SqlCommand cmdCheck = new SqlCommand(checkQuery, con))
            {
                cmdCheck.Parameters.AddWithValue("@Email", email);
                cmdCheck.Parameters.AddWithValue("@Password", hashedCurrent);

                int count = (int)cmdCheck.ExecuteScalar();
                if (count == 0)
                {
                    ShowAlert("error", "Current password is incorrect!");
                    return;
                }
            }

            // 2️⃣ Update password
            string updateQuery = "UPDATE Admin SET Password=@Password WHERE Email=@Email";
            using (SqlCommand cmdUpdate = new SqlCommand(updateQuery, con))
            {
                cmdUpdate.Parameters.AddWithValue("@Password", hashedNew);
                cmdUpdate.Parameters.AddWithValue("@Email", email);
                cmdUpdate.ExecuteNonQuery();
            }

            ShowAlert("success", "Password changed successfully!");
        }
    }

    private string HashPassword(string password)
    {
        using (SHA256 sha = SHA256.Create())
        {
            byte[] bytes = Encoding.UTF8.GetBytes(password);
            byte[] hash = sha.ComputeHash(bytes);
            return Convert.ToBase64String(hash);
        }
    }

    private void ShowAlert(string type, string message)
    {
        ScriptManager.RegisterStartupScript(this, GetType(), "alert",
            $"Swal.fire('{type.ToUpper()}', '{message}', '{type}');", true);
    }
}