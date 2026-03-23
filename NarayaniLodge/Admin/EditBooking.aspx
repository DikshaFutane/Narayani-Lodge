<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/Admin.Master" AutoEventWireup="true" CodeFile="EditBooking.aspx.cs" Inherits="Admin_EditBooking" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <link rel="icon" href="assets/images/narayanilodgelogo.png" type="image/x-icon" />
    <link rel="stylesheet" href="assets/css/style.css" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <!-- [ Main Content ] start -->
    <div class="pc-container">
        <div class="pc-content">

            <div class="page-header">
                <div class="page-block">
                    <div class="page-header-title">
                        <h5>Edit Booking</h5>
                    </div>
                </div>
            </div>

            <div class="card">

                <div class="card-header bg-warning text-dark">
                    <h4>Edit Booking Details</h4>
                </div>

                <div class="card-body">

                    <asp:HiddenField ID="hfBookingId" runat="server" />

                    <div class="grid grid-cols-12 gap-6">

                        <div class="col-span-12 md:col-span-6">
                            <label>Guest Name</label>
                            <asp:TextBox ID="txtGuestName" runat="server" CssClass="form-control"></asp:TextBox>
                        </div>

                        <div class="col-span-12 md:col-span-6">
                            <label>Email</label>
                            <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control"></asp:TextBox>
                        </div>

                        <div class="col-span-12 md:col-span-6">
                            <label>Phone</label>
                            <asp:TextBox ID="txtPhone" runat="server" CssClass="form-control"></asp:TextBox>
                        </div>

                        <div class="col-span-12 md:col-span-6">
                            <label>Room Type</label>
                            <asp:DropDownList ID="ddlRoomType" runat="server" CssClass="form-control">
                                <asp:ListItem>AC Room</asp:ListItem>
                                <asp:ListItem>Non-AC Room</asp:ListItem>
                            </asp:DropDownList>
                        </div>

                        <div class="col-span-12 md:col-span-6">
                            <label>Check In</label>
                            <asp:TextBox ID="txtCheckIn" runat="server" TextMode="Date" CssClass="form-control"></asp:TextBox>
                        </div>

                        <div class="col-span-12 md:col-span-6">
                            <label>Check Out</label>
                            <asp:TextBox ID="txtCheckOut" runat="server" TextMode="Date" CssClass="form-control"></asp:TextBox>
                        </div>

                        <div class="col-span-12 md:col-span-6">
                            <label>No of Rooms</label>
                            <asp:TextBox ID="txtNoOfRooms" runat="server" CssClass="form-control"></asp:TextBox>
                        </div>
                        <div class="col-span-12 md:col-span-6"></div>

                        <div class="col-span-12 md:col-span-6">
                            <label>ID Proof Type</label>
                            <asp:TextBox ID="txtid" runat="server" CssClass="form-control"></asp:TextBox>
                        </div>

                        <div class="col-span-12 md:col-span-6">
                            <label>ID Proof Number</label>
                            <asp:TextBox ID="txtNo" runat="server" CssClass="form-control"></asp:TextBox>
                        </div>



                        <div class="col-span-12 md:col-span-6">
                            <label>Total Amount</label>
                            <asp:TextBox ID="txtTotal" runat="server" CssClass="form-control"></asp:TextBox>
                        </div>

                          <div class="col-span-12 md:col-span-6">
                        <label>Paid Amount</label>
                        <asp:TextBox ID="txtPaid" runat="server" CssClass="form-control w-full border rounded-lg p-2" />
                    </div>
                        <div class="col-span-12 md:col-span-6">
                            <label>Pending Amount</label>
                            <asp:TextBox ID="txtPending" runat="server" CssClass="form-control"></asp:TextBox>
                        </div>

                        <div class="col-span-12 md:col-span-6">
                            <label>Booking Status</label>
                            <asp:DropDownList ID="ddlBookingStatus" runat="server" CssClass="form-control">
                                <asp:ListItem>Pending</asp:ListItem>
                                <asp:ListItem>Confirmed</asp:ListItem>
                                <asp:ListItem>Cancelled</asp:ListItem>
                            </asp:DropDownList>
                        </div>

                        <div class="col-span-12 md:col-span-6">
                            <label>Payment Status</label>
                            <asp:DropDownList ID="ddlPaymentStatus" runat="server" CssClass="form-control">
                                <asp:ListItem>Pending</asp:ListItem>
                                <asp:ListItem>Paid</asp:ListItem>
                                <asp:ListItem>Partial</asp:ListItem>
                            </asp:DropDownList>
                        </div>

                    </div>

                    <div class="mt-4">

                        <asp:Button ID="btnUpdate" runat="server"
                            Text="Update Booking"
                            CssClass="btn btn-success"
                            OnClick="btnUpdate_Click" />

                        <a href="AllBookings.aspx" class="btn btn-danger ms-2">Cancel</a>

                    </div>

                </div>
            </div>

        </div>
    </div>
</asp:Content>

