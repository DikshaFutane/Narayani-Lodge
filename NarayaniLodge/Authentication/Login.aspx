<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Login.aspx.cs" Inherits="Authentication_Login" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>User Login</title>
    <link rel="icon" href="Admin/assets/images/narayanilodgelogo.png" type="image/x-icon" />
    <meta name="viewport" content="width=device-width, initial-scale=1"/>
    <style>
        body{
    margin:0;
    font-family: Arial;
    background:#f5f7fa;
}

.login-wrapper{
    display:flex;
    justify-content:center;
    align-items:center;
    height:100vh;
}

.login-container{
    width:100%;
    max-width:380px;
    background:white;
    padding:30px;
    border-radius:10px;
    box-shadow:0 0 15px rgba(0,0,0,0.15);
}

.logo{
    text-align:center;
    margin-bottom:15px;
}

.logo img{
    height:80px;
}

h3{
    text-align:center;
    margin-bottom:20px;
}

.input-box{
    width:100%;
    padding:10px;
    margin-top:8px;
    border:1px solid #ccc;
    border-radius:5px;
}

.login-btn{
    width:100%;
    padding:12px;
    background:#d4a373;
    color:white;
    border:none;
    border-radius:5px;
    cursor:pointer;
    margin-top:10px;
}

.login-btn:hover{
    background:black;
}

.link{
    text-decoration:none;
    color:#d4a373;
}

.text-center{
    text-align:center;
    margin-top:15px;
}

.msg{
    text-align:center;
    margin-top:10px;
}
    </style>
</head>
<body>
      <main aria-labelledby="title">
    <form id="form1" runat="server">

<div class="login-wrapper">

<div class="login-container">

<div class="logo">
<a href="../Default.aspx">
<img src="../img/naraynilogo.png"/>
</a>
</div>

<h3>User Login</h3>

<asp:TextBox ID="txtEmail" runat="server" CssClass="input-box"
placeholder="Enter Email"></asp:TextBox>

<asp:RequiredFieldValidator
ID="rfvEmail"
runat="server"
ControlToValidate="txtEmail"
ErrorMessage="Email required"
ForeColor="Red"/>

<asp:RegularExpressionValidator
ID="revEmail"
runat="server"
ControlToValidate="txtEmail"
ValidationExpression="\w+([-.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*"
ErrorMessage="Enter valid email"
ForeColor="Red"/>


<asp:TextBox ID="txtPassword" runat="server"
CssClass="input-box"
TextMode="Password"
placeholder="Enter Password"></asp:TextBox>

<asp:RequiredFieldValidator
ID="rfvPassword"
runat="server"
ControlToValidate="txtPassword"
ErrorMessage="Password required"
ForeColor="Red"/>

<asp:Label runat="server" ID="lblmsg" CssClass="msg"></asp:Label>

<asp:Button ID="btnLogin"
runat="server"
Text="Login"
CssClass="login-btn"
OnClick="btnLogin_Click"/>


<div class="text-center">
<a href="../ForgetPassword.aspx?role=user" class="link">Forgot Password?</a>
</div>

<div class="text-center">
Don't have an account?
<a href="Signup.aspx" class="link">Sign Up</a>
</div>

</div>

</div>

</form>
          </main>
</body>
</html>
