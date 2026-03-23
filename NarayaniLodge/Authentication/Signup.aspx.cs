using System;
using System.Configuration;
using System.Data.SqlClient;
using System.Security.Cryptography;
using System.Text;

public partial class Authentication_Signup : System.Web.UI.Page
{
    string cs = ConfigurationManager.ConnectionStrings["Lodge"].ConnectionString;

    protected void Page_Load(object sender, EventArgs e)
    {

    }

    protected void btnSignup_Click(object sender, EventArgs e)
    {
        using (SqlConnection con = new SqlConnection(cs))
        {
            con.Open();

            string check = "SELECT COUNT(*) FROM Users WHERE Email=@Email";

            SqlCommand checkCmd = new SqlCommand(check, con);
            checkCmd.Parameters.AddWithValue("@Email", txtEmail.Text.Trim());

            int count = (int)checkCmd.ExecuteScalar();

            if (count > 0)
            {
                ShowAlert("Email already exists! Please login instead.", "warning");
                return;
            }

            string hashedPassword = HashPassword(txtPassword.Text.Trim());

            string query = @"INSERT INTO Users
                            (Name,Email,Password,Phone,CreatedAt,Status)
                            VALUES
                            (@Name,@Email,@Password,@Phone,GETDATE(),'Active')";

            SqlCommand cmd = new SqlCommand(query, con);

            cmd.Parameters.AddWithValue("@Name", txtName.Text.Trim());
            cmd.Parameters.AddWithValue("@Email", txtEmail.Text.Trim());
            cmd.Parameters.AddWithValue("@Password", hashedPassword);
            cmd.Parameters.AddWithValue("@Phone", txtPhone.Text.Trim());

            cmd.ExecuteNonQuery();

            // ✅ CREATE SESSION HERE
            Session["UserEmail"] = txtEmail.Text.Trim();
            Session["UserName"] = txtName.Text.Trim();

            // ✅ DIRECT REDIRECT TO USER HOME
            Response.Redirect("~/Users/Default.aspx");
        }
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

    void ShowAlert(string message, string type)
    {
        string script = "Swal.fire({icon:'" + type + "',title:'" + message + "'});";
        ClientScript.RegisterStartupScript(this.GetType(), "alert", script, true);
    }
}