<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Signup.aspx.cs" Inherits="Authentication_Signup" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Sign Up - Narayani Lodge</title>
   <meta name="viewport" content="width=device-width, initial-scale=1"/>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet"/>
    <link rel="icon" href="../img/narayanilodgelogo.png" type="image/x-icon" />

<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

<style>

body{
background:#f5f5f5;
font-family:Arial;
}

.signup-container{
max-width:380px;
margin:60px auto;
background:white;
padding:25px;
border-radius:8px;
box-shadow:0 0 12px rgba(0,0,0,0.1);
}

.logo{
text-align:center;
margin-bottom:10px;
}

.signup-title{
text-align:center;
margin-bottom:15px;
font-weight:600;
}

.form-control{
margin-bottom:3px;
}

.validator{
font-size:13px;
color:red;
}

#btnSignup{
background:#d4a373;
border:none;
}

#btnSignup:hover{
background:black;
}

</style>

</head>

<body>

<form id="form1" runat="server">

<div class="signup-container">

<div class="logo">
<a href="../Default.aspx">
<img src="../img/naraynilogo.png" height="70"/>
</a>
</div>

<h5 class="signup-title">Create Account</h5>


<!-- NAME -->
<div class="mb-2">
<asp:TextBox ID="txtName" runat="server"
CssClass="form-control"
placeholder="Enter Name"></asp:TextBox>

<asp:RequiredFieldValidator
runat="server"
ControlToValidate="txtName"
ErrorMessage="Name required"
CssClass="validator"/>
</div>


<!-- EMAIL -->
<div class="mb-2">
<asp:TextBox ID="txtEmail" runat="server"
CssClass="form-control"
placeholder="Enter Email"></asp:TextBox>

<asp:RequiredFieldValidator
runat="server"
ControlToValidate="txtEmail"
ErrorMessage="Email required"
CssClass="validator"/>

<asp:RegularExpressionValidator
runat="server"
ControlToValidate="txtEmail"
ValidationExpression="\w+([-.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*"
ErrorMessage="Invalid email"
CssClass="validator"/>
</div>


<!-- PHONE -->
<div class="mb-2">

<asp:TextBox 
ID="txtPhone"
runat="server"
CssClass="form-control"
MaxLength="10"
onkeypress="return isNumberKey(event)"
placeholder="Phone Number">
</asp:TextBox>

<asp:RequiredFieldValidator
runat="server"
ControlToValidate="txtPhone"
ErrorMessage="Phone required"
CssClass="validator"/>

<asp:RegularExpressionValidator
runat="server"
ControlToValidate="txtPhone"
ValidationExpression="^[6-9]\d{9}$"
ErrorMessage="Enter valid Indian mobile number"
CssClass="validator"/>

</div>

<!-- PASSWORD -->
<div class="mb-3">
<asp:TextBox ID="txtPassword"
runat="server"
TextMode="Password"
CssClass="form-control"
placeholder="Password"></asp:TextBox>

<asp:RequiredFieldValidator
runat="server"
ControlToValidate="txtPassword"
ErrorMessage="Password required"
CssClass="validator"/>

<asp:RegularExpressionValidator
runat="server"
ControlToValidate="txtPassword"
ValidationExpression="^.{6,}$"
ErrorMessage="Minimum 6 characters"
CssClass="validator"/>
</div>


<div class="d-grid">
<asp:Button ID="btnSignup"
runat="server"
Text="Sign Up"
CssClass="btn btn-primary"
OnClick="btnSignup_Click"/>
</div>


<div class="text-center mt-3">
Already have an account?
<a href="Login.aspx">Login</a>
</div>

</div>

</form>

</body>
</html>
