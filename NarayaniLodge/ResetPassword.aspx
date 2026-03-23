<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ResetPassword.aspx.cs" Inherits="ResetPassword" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>Forget Password - Narayani Lodge</title>
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <link rel="icon" href="Admin/assets/images/narayanilodgelogo.png" type="image/x-icon" />
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" />

    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

    <style>
        body {
            background: #f5f5f5;
            font-family: Arial;
        }

        .signup-container {
            max-width: 380px;
            margin: 60px auto;
            background: white;
            padding: 25px;
            border-radius: 8px;
            box-shadow: 0 0 12px rgba(0,0,0,0.1);
        }

        .logo {
            text-align: center;
            margin-bottom: 10px;
        }

        .signup-title {
            text-align: center;
            margin-bottom: 15px;
            font-weight: 600;
        }

        .form-control {
            margin-bottom: 3px;
        }

        .validator {
            font-size: 13px;
            color: red;
        }

        #btnSendLink {
            background: #d4a373;
            border: none;
            width: 100%;
        }

            #btnSendLink:hover {
                background: black;
            }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="signup-container">

            <div class="logo">
                <a href="../Default.aspx">
                    <img src="../img/naraynilogo.png" height="70" />
                </a>
            </div>

            <h5 class="signup-title">Reset Password</h5>
            <asp:TextBox ID="txtNewPass" runat="server" CssClass="form-control" TextMode="Password" placeholder="New Password" />
            <asp:RequiredFieldValidator
                ID="rfvPass"
                runat="server"
                ControlToValidate="txtNewPass"
                ErrorMessage="Password is required!"
                CssClass="validator" />

            <asp:RegularExpressionValidator
                ID="revPass"
                runat="server"
                ControlToValidate="txtNewPass"
                ErrorMessage="Min 6 characters required!"
                CssClass="validator"
                ValidationExpression="^.{6,}$" />
            <asp:Button ID="btnReset" runat="server" CssClass="btn btn-primary mt-2" Text="Reset Password" OnClick="btnReset_Click" />
            <asp:Label ID="lblResetMsg" runat="server"></asp:Label>
        </div>
        <script>
            function showAlert(type, message) {
                Swal.fire({
                    icon: type,
                    title: message,
                    confirmButtonColor: '#d4a373'
                });
            }
        </script>
    </form>
</body>
</html>
