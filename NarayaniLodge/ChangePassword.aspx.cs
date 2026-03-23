using System;
using System.Configuration;
using System.Data.SqlClient;
using System.Security.Cryptography;
using System.Text;
using System.Web.UI;

public partial class ChangePassword : System.Web.UI.Page
{
    string cs = ConfigurationManager.ConnectionStrings["Lodge"].ConnectionString;

    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["Email"] == null)
        {
            Response.Redirect("Authentication/Login.aspx");
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

            // ✅ Check current password
            string checkQuery = "SELECT COUNT(*) FROM Users WHERE Email=@Email AND Password=@Password";

            SqlCommand cmdCheck = new SqlCommand(checkQuery, con);
            cmdCheck.Parameters.AddWithValue("@Email", email);
            cmdCheck.Parameters.AddWithValue("@Password", hashedCurrent);

            int count = Convert.ToInt32(cmdCheck.ExecuteScalar());

            if (count == 0)
            {
                ShowAlert("error", "Current password is incorrect!");
                return;
            }

            // ✅ Update password
            string updateQuery = "UPDATE Users SET Password=@Password WHERE Email=@Email";

            SqlCommand cmdUpdate = new SqlCommand(updateQuery, con);
            cmdUpdate.Parameters.AddWithValue("@Password", hashedNew);
            cmdUpdate.Parameters.AddWithValue("@Email", email);

            int rows = cmdUpdate.ExecuteNonQuery();

            if (rows > 0)
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "alert",
    "Swal.fire('Success','Password changed successfully!','success').then(()=>{ window.location='Authentication/Login.aspx'; });", true);

                Session.Clear();
                // 🔥 Optional: logout after change
                Session.Clear();
            }
            else
            {
                ShowAlert("error", "Something went wrong!");
            }
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
        ScriptManager.RegisterStartupScript(this, this.GetType(), "alert",
            $"showAlert('{type}','{message}');", true);
    }
}