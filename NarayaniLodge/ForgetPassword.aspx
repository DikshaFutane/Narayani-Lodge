<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ForgetPassword.aspx.cs" Inherits="ForgetPassword" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
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

            <h5 class="signup-title">Forget Password</h5>

            <!-- Step 1: Mobile Input -->
            <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control" Placeholder="Enter your email"></asp:TextBox>
            <asp:RegularExpressionValidator
                ID="revEmail"
                runat="server"
                ControlToValidate="txtEmail"
                ErrorMessage="Enter valid email!"
                CssClass="validator"
                ValidationExpression="^[^@\s]+@[^@\s]+\.[^@\s]+$" />

            <asp:RequiredFieldValidator
                ID="rfvEmail"
                runat="server"
                ControlToValidate="txtEmail"
                ErrorMessage="Email is required!"
                CssClass="validator" />
            <asp:Button ID="btnSendLink" runat="server" Text="Send Reset Link" OnClick="btnSendLink_Click" CssClass="btn btn-primary mt-2 " /><br />
            <asp:Label ID="lblMsg" runat="server"></asp:Label>
        </div>

    </form>
    <script>
    function showAlert(type, message) {
        Swal.fire({
            icon: type,
            title: message,
            confirmButtonColor: '#d4a373'
        });
    }
    </script>
</body>
</html>
