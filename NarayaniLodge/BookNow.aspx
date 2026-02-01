<%@ Page Title="Book Now" Language="C#" MasterPageFile="~/Site.Master"
    AutoEventWireup="true" CodeFile="BookNow.aspx.cs" Inherits="BookNow" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="Server">

<section class="rooms-section spad" style="padding:60px 0; background:#f9f9f9;">
    <div class="container">

        <!-- Section Title -->
        <div class="row">
            <div class="col-lg-12 text-center">
                <div class="section-title">
                    <h3>Book Your Stay</h3>
                    <p>Reserve your room easily and enjoy a comfortable stay.</p>
                </div>
            </div>
        </div>

        <!-- Booking Form -->
        <div class="room-booking">
            <div class="booking-form">
                   <p>The field marked as * is mandatory</p>
                <div class="row">
                    <!-- Full Name -->
                    <div class="col-md-6">
                        <div class="check-date">
                            <label class="form-label">Full Name <span class="text-red-500">*</span></label>
                            <input type="text" runat="server" id="name"
                                   placeholder="Your full name" class="form-control" />
                            <asp:RequiredFieldValidator ControlToValidate="name" ErrorMessage="Full name is required" ForeColor="Red" Display="Dynamic" runat="server" />
                        </div>
                    </div>

                    <!-- Phone -->
                    <div class="col-md-6">
                        <div class="check-date">
                            <label>Phone Number *</label>
                            <input type="text" runat="server" id="phn"
                                   placeholder="Your phone number" class="form-control" />
                            <asp:RequiredFieldValidator  ControlToValidate="phn" ErrorMessage="Phone number is required" ForeColor="Red" Display="Dynamic" runat="server" />
                            <asp:RegularExpressionValidator    ControlToValidate="phn" ValidationExpression="^[6-9]\d{9}$"  ErrorMessage="Enter valid 10-digit mobile number" ForeColor="Red" Display="Dynamic" runat="server" />
                        </div>
                    </div>

                    <!-- Email -->
                    <div class="col-md-6">
                        <div class="check-date">
                            <label>Email</label>
                            <input type="email" runat="server" id="txtEmailAddress"
                                   placeholder="Your email address" class="form-control" />
                     </div>
                    </div>

                    <!-- Address -->
                    <div class="col-md-6">
                        <div class="check-date">
                            <label>Address (Optional)</label>
                            <input type="text" runat="server" id="txtAddress"
                                   placeholder="Your address" class="form-control" />
                        </div>
                    </div>

                    <!-- Room Type -->
                    <div class="col-md-6">
                        <div class="check-date">
                            <label>Room Type *</label>
                            <asp:DropDownList ID="ddlRoom" runat="server" CssClass="form-control date-input"></asp:DropDownList><br />
                            <asp:RequiredFieldValidator ControlToValidate="ddlRoom" InitialValue="0" ErrorMessage="Please select a room type" ForeColor="Red" Display="Dynamic" runat="server" />
                    </div>
                           
                        </div>

                    <!-- No. of Rooms -->
                    <div class="col-md-6">
                        <div class="check-date">
                            <label>No. of Rooms *</label>
                            <input type="number" min="1" value="1" runat="server" id="txtRoomCount" class="form-control" />
                            <asp:RangeValidator ControlToValidate="txtRoomCount" MinimumValue="1" MaximumValue="10" Type="Integer" ErrorMessage="Rooms must be at least 1" ForeColor="Red" Display="Dynamic" runat="server" />
                        </div>
                    </div>

                    <!-- Check In -->
                    <div class="col-md-6">
                        <div class="check-date">
                            <label>Check In *</label>
                            <input type="text" runat="server" id="txtCheckIn"
                                   class="form-control date-input"
                                   placeholder="Select check-in date" />
                            <asp:RequiredFieldValidator ControlToValidate="txtCheckIn" ErrorMessage="Check-in date is required" ForeColor="Red" Display="Dynamic" runat="server" />
                        </div>
                    </div>

                    <!-- Check Out -->
                    <div class="col-md-6">
                        <div class="check-date">
                            <label>Check Out *</label>
                            <input type="text" runat="server" id="txtCheckOut"
                                   class="form-control date-input"
                                   placeholder="Select check-out date" />
                            <asp:RequiredFieldValidator ControlToValidate="txtCheckOut" ErrorMessage="Check-out date is required" ForeColor="Red" Display="Dynamic" runat="server" />
                        </div>
                    </div>

                    <!-- Submit Button -->
                    <div class="col-md-12">
                        <div class="check-date text-center">
                            <asp:Button ID="btnBookNow" runat="server"
                                Text="Book Now" OnClick="btnBookNow_Click"
                                style="font-size: 14px; text-transform: uppercase; border: 1px solid #dfa974; border-radius: 2px; color: #dfa974; font-weight: 500; background: transparent;" />
                        </div>
                    </div>

                </div>
            </div>
        </div>
        </div>
   
</section>

</asp:Content>
