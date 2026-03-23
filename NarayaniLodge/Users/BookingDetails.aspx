<%@ Page Title="Booking Details" Language="C#" MasterPageFile="~/Users/UserSite.master" AutoEventWireup="true" CodeFile="BookingDetails.aspx.cs" Inherits="Users_BookingDetails" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <style>

        .card-header{
            background-color:#dfa974;
            text-align:center;
            font-size:30px;
        }
.details-card{
    max-width:700px;
    margin:auto;
    border-radius:10px;
    box-shadow:0px 3px 10px rgba(0,0,0,0.1);
}

.details-title{
    font-weight:600;
}
.btn{
    background-color:#dfa974;
    color:white;
}
</style>
        <link rel="icon" href="../img/narayanilodgelogo.png" type="image/x-icon" />


</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <div class="container mt-5 mb-5">

<div class="card details-card">

<div class="card-header text-white">
<h4 class="mb-0">Booking Details</h4>
</div>

<div class="card-body">

<div class="row mb-3">

<div class="col-md-6">
<span class="details-title">Booking ID :</span>
<asp:Label ID="lblBookingId" runat="server"></asp:Label>
</div>

<div class="col-md-6">
<span class="details-title">Guest Name :</span>
<asp:Label ID="lblGuestName" runat="server"></asp:Label>
</div>

</div>


<div class="row mb-3">

<div class="col-md-6">
<span class="details-title">Room Type :</span>
<asp:Label ID="lblRoomType" runat="server"></asp:Label>
</div>

<div class="col-md-6">
<span class="details-title">Room Number :</span>
<asp:Label ID="lblRoomNumber" runat="server"></asp:Label>
</div>

</div>


<div class="row mb-3">

<div class="col-md-6">
<span class="details-title">Check In :</span>
<asp:Label ID="lblCheckIn" runat="server"></asp:Label>
</div>

<div class="col-md-6">
<span class="details-title">Check Out :</span>
<asp:Label ID="lblCheckOut" runat="server"></asp:Label>
</div>

</div>


<div class="row mb-3">

<div class="col-md-6">
<span class="details-title">Total Amount :</span>
₹ <asp:Label ID="lblAmount" runat="server"></asp:Label>
</div>

<div class="col-md-6">
<span class="details-title">Booking Status :</span>
<asp:Label ID="lblStatus" runat="server" CssClass="badge bg-success"></asp:Label>
</div>

</div>


<div class="text-center mt-4">

<%--<asp:Button
ID="btnInvoice"
runat="server"
Text="Download Invoice"
CssClass="btn btn-success me-2"
OnClick="btnInvoice_Click" />--%>

<a href="MyBookings.aspx" class="btn">
Back to My Bookings
</a>

</div>


</div>

</div>

</div>
</asp:Content>

