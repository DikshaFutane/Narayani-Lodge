using System;
using System.Data.SqlClient;
using System.Net;
using System.Net.Mail;
using System.Web.UI;

public partial class ForgetPassword : System.Web.UI.Page
{
    string cs = System.Configuration.ConfigurationManager.ConnectionStrings["Lodge"].ConnectionString;

    protected void btnSendLink_Click(object sender, EventArgs e)
    {
        string email = txtEmail.Text.Trim();
        string role = Request.QueryString["role"];

        string table = (role == "admin") ? "AdminLogin" : "Users";

        using (SqlConnection con = new SqlConnection(cs))
        {
            con.Open();

            // Check email exists
            SqlCommand checkCmd = new SqlCommand($"SELECT COUNT(*) FROM {table} WHERE Email=@Email", con);
            checkCmd.Parameters.AddWithValue("@Email", email);

            int count = (int)checkCmd.ExecuteScalar();

            if (count == 0)
            {
                ScriptManager.RegisterStartupScript(this, GetType(), "alert",
                    "showAlert('error','Email not found!');", true);
                return;
            }

            // Generate token
            string token = Guid.NewGuid().ToString();

            // Save token
            SqlCommand cmd = new SqlCommand(
                "INSERT INTO PasswordReset (Email, Token, Expiry, Role) VALUES (@Email,@Token,@Expiry,@Role)", con);

            cmd.Parameters.AddWithValue("@Email", email);
            cmd.Parameters.AddWithValue("@Token", token);
            cmd.Parameters.AddWithValue("@Expiry", DateTime.Now.AddMinutes(15));
            cmd.Parameters.AddWithValue("@Role", role);

            cmd.ExecuteNonQuery();

            // Create reset link
            string url = Request.Url.GetLeftPart(UriPartial.Authority);
            string resetLink = url + "/ResetPassword.aspx?token=" + token + "&role=" + role;

            // Send email
            SendEmail(email, resetLink, role);
            lblMsg.Text = "Reset link sent successfully!";
        }
    }

    private void SendEmail(string toEmail, string link, string role)
    {
        MailMessage mail = new MailMessage();
        mail.From = new MailAddress("narayanilodge7@gmail.com");
        mail.To.Add(toEmail);
        mail.Subject = "Reset Your Password";

        mail.Body = $"Dear {role},\n\n" +
                    "Click the link below to reset your password:\n\n" +
                    link + "\n\n" +
                    "This link will expire in 15 minutes.";

        SmtpClient smtp = new SmtpClient("smtp.gmail.com", 587);
        smtp.Credentials = new NetworkCredential("narayanilodge7@gmail.com", "icwuixyckjijaslf");
        smtp.EnableSsl = true;

        smtp.Send(mail);
    }
}