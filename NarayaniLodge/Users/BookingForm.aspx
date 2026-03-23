<%@ Page Language="C#" AutoEventWireup="true" CodeFile="BookingForm.aspx.cs" Inherits="Users_BookingForm" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css" />
    <script src="https://cdn.jsdelivr.net/npm/jquery@3.7.1/dist/jquery.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>
    <link href="../img/narayanilodgelogo.png" rel="shortcut icon" type="image/x-icon" />

    <title>Booking Form - Narayani Lodge</title>
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: #f7f7f7;
        }

        .form-container {
            max-width: 750px;
            margin: 50px auto;
            background: #fff;
            padding: 40px;
            border-radius: 12px;
            box-shadow: 0 8px 25px rgba(0,0,0,0.1);
        }

        h2 {
            text-align: center;
            color: #d4a373;
            margin-bottom: 30px;
            font-size: 28px;
        }

        .section {
            margin-bottom: 30px;
        }

            .section h3 {
                margin-bottom: 20px;
                color: #d4a373;
                border-bottom: 2px solid #d4a373;
                padding-bottom: 5px;
                font-size: 20px;
            }

        input[readonly] {
            background: #e9ecef;
        }

        .validator {
            color: red;
            font-size: 13px;
        }

        .logo {
            text-align: center;
            margin-bottom: 30px;
        }

        .btn {
            background-color: #d4a373;
            color: white;
            border: none;
        }

            .btn:hover {
                background-color: black;
            }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="form-container">

            <div class="logo">
                <a href="Default.aspx">
                    <img src="../img/naraynilogo.png" height="70" width="100" /></a>
            </div>

            <h2>Booking Form</h2>

            <!-- Guest Info Section -->
            <div class="section">
                <h3>Guest Information</h3>
                <div class="form-row">
                    <div class="form-group col-md-6">
                        <label>Guest Name:</label>
                        <asp:TextBox ID="txtGuestName" runat="server" CssClass="form-control" ReadOnly="true"></asp:TextBox>
                    </div>
                    <div class="form-group col-md-6">
                        <label>Email:</label>
                        <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control" ReadOnly="true"></asp:TextBox>
                    </div>
                </div>
                <div class="form-row">
                    <div class="form-group col-md-6">
                        <label>Phone:</label>
                        <asp:TextBox ID="txtPhone" runat="server" CssClass="form-control"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="rfvPhone" runat="server" ControlToValidate="txtPhone"
                            ErrorMessage="Phone number is required" CssClass="validator"></asp:RequiredFieldValidator>

                        <asp:RegularExpressionValidator
                            runat="server"
                            ControlToValidate="txtPhone"
                            ValidationExpression="^[6-9]\d{9}$"
                            ErrorMessage="Enter valid Indian mobile number"
                            CssClass="validator"></asp:RegularExpressionValidator>
                    </div>
                    <div class="form-group col-md-6">
                        <label>Address:</label>
                        <asp:TextBox ID="txtAddress" runat="server" CssClass="form-control"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="rfvAddress" runat="server" ControlToValidate="txtAddress"
                            ErrorMessage="Address is required" CssClass="validator"></asp:RequiredFieldValidator>
                    </div>
                </div>
            </div>

            <!-- Booking Details Section -->
            <div class="section">
                <h3>Booking Details</h3>
                <div class="form-row">
                    <div class="form-group col-md-6">
                        <label>Check In:</label>
                        <asp:TextBox ID="txtCheckIn" runat="server" CssClass="form-control" ReadOnly="true"></asp:TextBox>
                    </div>
                    <div class="form-group col-md-6">
                        <label>Check Out:</label>
                        <asp:TextBox ID="txtCheckOut" runat="server" CssClass="form-control" ReadOnly="true"></asp:TextBox>
                    </div>
                </div>
                <div class="form-row">
                    <div class="form-group col-md-6">
                        <label>Room Type:</label>
                        <asp:TextBox ID="txtRoomType" runat="server" CssClass="form-control" ReadOnly="true"></asp:TextBox>
                    </div>
                    <div class="form-group col-md-6">
                        <label>No. of Rooms:</label>
                        <asp:TextBox ID="txtNoOfRooms" runat="server" CssClass="form-control" ReadOnly="true"></asp:TextBox>
                    </div>
                </div>
                <div class="form-group">
                    <label>No. of Guests:</label>
                    <asp:TextBox ID="txtGuests" runat="server" CssClass="form-control" ReadOnly="true"></asp:TextBox>
                </div>
            </div>

            <!-- Address & ID Section -->
            <div class="section">
                <h3>Identification Details</h3>
                <div class="form-row">
                    <div class="form-group col-md-6">
                        <label>ID Proof Type:</label>
<asp:DropDownList ID="ddlIDProof" runat="server" CssClass="form-control"
AutoPostBack="true"
OnSelectedIndexChanged="ddlIDProof_SelectedIndexChanged">
                            <asp:ListItem Text="Select" Value=""></asp:ListItem>
                            <asp:ListItem Text="Aadhar" Value="Aadhar"></asp:ListItem>
                            <asp:ListItem Text="PAN" Value="PAN"></asp:ListItem>
                            <asp:ListItem Text="Passport" Value="Passport"></asp:ListItem>
                        </asp:DropDownList>
                    </div>
                    <div class="form-group col-md-6">
                        <label>ID Proof Number:</label>
                        <asp:TextBox ID="txtIDNumber" runat="server" CssClass="form-control" onkeyup="this.value=this.value.toUpperCase();"></asp:TextBox>
<!-- Aadhar Validator -->
<asp:RegularExpressionValidator
ID="revAadhar"
runat="server"
ControlToValidate="txtIDNumber"
ValidationExpression="^\d{12}$"
ErrorMessage="Aadhar must be 12 digits"
CssClass="validator"
Display="Dynamic"
Enabled="false">
</asp:RegularExpressionValidator>

<!-- PAN Validator -->
<asp:RegularExpressionValidator
ID="revPAN"
runat="server"
ControlToValidate="txtIDNumber"
ValidationExpression="^[A-Z]{5}[0-9]{4}[A-Z]{1}$"
ErrorMessage="Enter valid PAN (ABCDE1234F)"
CssClass="validator"
Display="Dynamic"
Enabled="false">
</asp:RegularExpressionValidator>

<!-- Passport Validator -->
<asp:RegularExpressionValidator
ID="revPassport"
runat="server"
ControlToValidate="txtIDNumber"
ValidationExpression="^[A-Z]{1}[0-9]{7}$"
ErrorMessage="Enter valid Passport (A1234567)"
CssClass="validator"
Display="Dynamic"
Enabled="false">
</asp:RegularExpressionValidator>
                    </div>
                </div>
            </div>

            <!-- Payment Section -->
            <div class="section">
                <h3>Payment</h3>
                <div class="form-group row">
                    <div class="form-group col-md-6">
                        <label>Price Per Night (₹):</label>
                        <asp:TextBox ID="txtPrice" runat="server" CssClass="form-control" ReadOnly="true"></asp:TextBox>
                    </div>

                    <div class="form-group col-md-6">
                        <label>Total Amount (₹):</label>
                        <asp:TextBox ID="txtTotalAmount" runat="server" CssClass="form-control" ReadOnly="true"></asp:TextBox>
                    </div>
                    <div class="form-group col-md-6">
                        <label>Payment Mode:</label>
                        <asp:TextBox ID="txtPaymentMode" runat="server" CssClass="form-control" Text="Pay at Hotel" ReadOnly="true"></asp:TextBox>
                    </div>
                </div>
            </div>

            <asp:Button ID="btnBook" runat="server" CssClass="btn btn-primary btn-block" Text="Confirm Booking" OnClick="btnBook_Click1" />

        </div>
    </form>

</body>
</html>
