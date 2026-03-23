<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ChangePassword.aspx.cs" Inherits="ChangePassword" %>

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
                color:white;
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

            <h5 class="signup-title">Change Password</h5>
             <asp:Label ID="lblCurrent" CssClass="signup-title" runat="server" Text="Current Password"></asp:Label><br />
            <asp:TextBox ID="txtCurrent" runat="server" TextMode="Password" CssClass="form-control"></asp:TextBox>
            <asp:RequiredFieldValidator ID="rfvCurrent" runat="server" ControlToValidate="txtCurrent"
                ErrorMessage="Current password is required!" ForeColor="Red" Display="Dynamic">*</asp:RequiredFieldValidator>
            <br /><br />

            <asp:Label ID="lblNew" runat="server" CssClass="signup-title" Text="New Password"></asp:Label><br />
            <asp:TextBox ID="txtNew" runat="server" TextMode="Password" CssClass="form-control"></asp:TextBox>
            <asp:RequiredFieldValidator ID="rfvNew" runat="server" ControlToValidate="txtNew"
                ErrorMessage="New password is required!" ForeColor="Red" Display="Dynamic">*</asp:RequiredFieldValidator>
            <asp:RegularExpressionValidator ID="revNew" runat="server" ControlToValidate="txtNew"
                ValidationExpression=".{6,}" 
                ErrorMessage="Password must be at least 6 characters!" ForeColor="Red" Display="Dynamic">*</asp:RegularExpressionValidator>
            <br /><br />

            <asp:Label ID="lblConfirm" runat="server" CssClass="signup-title" Text="Confirm Password"></asp:Label><br />
            <asp:TextBox ID="txtConfirm" runat="server" TextMode="Password" CssClass="form-control"></asp:TextBox>
            <asp:RequiredFieldValidator ID="rfvConfirm" runat="server" ControlToValidate="txtConfirm"
                ErrorMessage="Confirm password is required!" ForeColor="Red" Display="Dynamic">*</asp:RequiredFieldValidator>
            <asp:CompareValidator ID="cvPassword" runat="server" ControlToValidate="txtConfirm" ControlToCompare="txtNew"
                ErrorMessage="Passwords do not match!" ForeColor="Red" Display="Dynamic">*</asp:CompareValidator>
            <br /><br />

            <asp:Button ID="btnSendLink" runat="server" Text="Change Password" OnClick="btnChange_Click" />
        

        </div>
    </form>
</body>
</html>
