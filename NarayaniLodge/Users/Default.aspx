<%@ Page Title="Default" Language="C#" MasterPageFile="~/Users/UserSite.master" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="Users_Default" %>

<asp:Content ID="Content2" ContentPlaceHolderID="head" Runat="Server">
    <style>
    .badge{
    font-size: 14px;
    padding:6px 10px;
    color:white;
}
        </style>
    <link rel="icon" href="../img/narayanilodgelogo.png" type="image/x-icon" />
    </asp:Content>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
   <div class="container mt-4">

    <!-- Welcome Section -->
    <div class="mb-4">
        <h3>Welcome, 
            <asp:Label ID="lblUserName" runat="server"></asp:Label> 👋
        </h3>
        <p class="text-muted">Manage your bookings and reserve rooms easily.</p>
    </div>

    <!-- Dashboard Cards -->
    <div class="row">

        <!-- New Booking -->
        <div class="col-lg-4 col-md-6 col-sm-12 mb-3">
            <div class="card shadow-sm h-100 border-0">
                <div class="card-body text-center">
                    <i class="fa fa-bed fa-3x text-primary mb-3"></i>
                    <h5 class="card-title">New Booking</h5>
                    <p class="text-muted">Reserve a room easily.</p>

                    <asp:Button 
                        ID="btnNewBooking" 
                        runat="server" 
                        Text="Book Room" 
                        CssClass="btn btn-primary"
                        PostBackUrl="~/Users/BookRoom.aspx" />
                </div>
            </div>
        </div>

        <!-- Cancel Booking -->
        <div class="col-lg-4 col-md-6 col-sm-12 mb-3">
            <div class="card shadow-sm h-100 border-0">
                <div class="card-body text-center">
                    <i class="fa fa-times-circle fa-3x text-danger mb-3"></i>
                    <h5 class="card-title">Cancel Booking</h5>
                    <p class="text-muted">Cancel your reservation.</p>

                    <asp:Button 
                        ID="btnCancelBooking" 
                        runat="server" 
                        Text="Cancel Booking" 
                        CssClass="btn btn-danger"
                        PostBackUrl="~/Users/Mybookings.aspx" />
                </div>
            </div>
        </div>

        <!-- Profile -->
        <div class="col-lg-4 col-md-6 col-sm-12 mb-3">
            <div class="card shadow-sm h-100 border-0">
                <div class="card-body text-center">
                    <i class="fa fa-user fa-3x text-success mb-3"></i>
                    <h5 class="card-title">My Profile</h5>
                    <p class="text-muted">View or update profile.</p>

                    <asp:Button 
                        ID="btnProfile" 
                        runat="server" 
                        Text="View Profile" 
                        CssClass="btn btn-success"
                        PostBackUrl="~/Users/ViewProfile.aspx" />
                </div>
            </div>
        </div>

    </div>


    <!-- My Bookings Section -->
    <div class="mt-5">

        <h4 class="mb-3">My Bookings</h4>

                           <div class="table-responsive">

        <asp:GridView 
            ID="gvBookings" 
            runat="server"
            CssClass="table table-bordered table-striped table-hover text-center"
            AutoGenerateColumns="false"
            DataKeyNames="BookingId"
OnRowCommand="gvAllBookings_RowCommand"
            EmptyDataText="No bookings found. Start by booking a room!"
            >

            <Columns>
                
                                            <asp:TemplateField HeaderText="Sr. No">
                                                <ItemTemplate>
                                                    <%# Container.DataItemIndex + 1 %>
                                                </ItemTemplate>
                                            </asp:TemplateField>

                <asp:BoundField DataField="RoomType" HeaderText="Room Type" />

                <asp:BoundField DataField="CheckInDate" HeaderText="Check In" DataFormatString="{0:dd-MMM-yyyy}" />

                <asp:BoundField DataField="CheckOutDate" HeaderText="Check Out" DataFormatString="{0:dd-MMM-yyyy}" />

                <asp:TemplateField HeaderText="Status">
<ItemTemplate>

<span class='badge <%# 
Eval("BookingStatus").ToString()=="Confirmed" ? "bg-success" :
Eval("BookingStatus").ToString()=="Cancelled" ? "bg-danger" :
"bg-secondary" %>'>

<%# Eval("BookingStatus") %>

</span>
</ItemTemplate>
</asp:TemplateField>

<%--                 <asp:TemplateField HeaderText="Actions">
     <ItemTemplate>
         <asp:Button
ID="btnCancel"
runat="server"
Text="Cancel"
CssClass="btn btn-sm btn-danger"
CommandName="CancelBooking"
CommandArgument='<%# Eval("BookingId") %>'
Visible='<%# Eval("BookingStatus").ToString() != "Cancelled" %>'
OnClientClick="return confirm('Are you sure you want to cancel this booking?');" />
</ItemTemplate>
                     </asp:TemplateField>--%>

            </Columns>

        </asp:GridView>

    </div>
    </div>

</div>

</asp:Content>

