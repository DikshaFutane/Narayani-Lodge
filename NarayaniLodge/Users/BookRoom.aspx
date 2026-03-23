<%@ Page Title="BookingForm" Language="C#" MasterPageFile="~/Users/UserSite.master" AutoEventWireup="true" CodeFile="BookRoom.aspx.cs" Inherits="Users_BookRoom" %>

<asp:Content ID="Content2" ContentPlaceHolderID="head" runat="Server">
        <link rel="icon" href="../img/narayanilodgelogo.png" type="image/x-icon" />

    <link rel="stylesheet" href="../img/narayanilodgelogo.png" />
    <style>
        .booking-form {
            background: #ffffff;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0px 5px 25px rgba(0,0,0,0.08);
            margin-top: 20px;
        }

            .booking-form label {
                font-weight: 600;
                font-size: 14px;
                color: #333;
                margin-bottom: 5px;
                display: block;
            }

            .booking-form input,
            .booking-form select {
                width: 100%;
                height: 45px;
                border: 1px solid #ddd;
                border-radius: 6px;
                padding: 8px 12px;
                font-size: 14px;
                outline: none;
                transition: 0.3s;
            }

                .booking-form input:focus,
                .booking-form select:focus {
                    border-color: #dfa974;
                    box-shadow: 0 0 5px rgba(223,169,116,0.3);
                }

        .check-date {
            margin-bottom: 18px;
        }

        .select-option {
            margin-bottom: 18px;
        }

        .btn {
            display: block;
            font-size: 20px;
            text-transform: uppercase;
            border: 3px solid #dfa974;
            border-radius: 2px;
            color: white;
            font-weight: 500;
            background: #dfa974;
            width: 100%;
            height: 46px;
            margin-top: 30px;
        }

        .booking-form i {
            position: absolute;
            right: 15px;
            top: 38px;
            color: #999;
        }

        .check-date {
            position: relative;
        }
    </style>
</asp:Content>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="container mt-4 justify-content-center">
        <h3>New Booking</h3>
        <p>Fill in the details below to make a new room reservation.</p>

        <div class="row justify-content-center">
            <div class="col-lg-5">

                <div class="booking-form">
                    <div class="check-date">
                        <label>Check In:</label>
                        <input type="text" class="date-input" id="datein" runat="server">
                        <i class="icon_calendar"></i>
                        <asp:RequiredFieldValidator ID="rfvCheckIn" runat="server" ControlToValidate="datein" ErrorMessage="Select Check-In Date" ForeColor="Red" Display="Dynamic">
                        </asp:RequiredFieldValidator>
                    </div>

                    <div class="check-date">
                        <label>Check Out:</label>
                        <input type="text" class="date-input" id="dateout" runat="server">
                        <i class="icon_calendar"></i>
                        <asp:RequiredFieldValidator ID="rfvCheckOut" runat="server" ControlToValidate="dateout" ErrorMessage="Select Check-Out Date" ForeColor="Red" Display="Dynamic"> </asp:RequiredFieldValidator>

                    </div>

                    <!-- Guests -->
                    <div class="select-option">
                        <label>Guests:</label>
                        <asp:DropDownList ID="guest" runat="server" AutoPostBack="true" OnSelectedIndexChanged="guest_SelectedIndexChanged">
                            <asp:ListItem Text="Select Guests" Value="" />
                            <asp:ListItem Text="1 Adult" Value="1A" />
                            <asp:ListItem Text="2 Adults" Value="2A" />
                            <asp:ListItem Text="2 Adults, 1 Child" Value="2A1C" />
                            <asp:ListItem Text="2 Adults, 2 Children" Value="2A2C" />
                            <asp:ListItem Text="3 Adults" Value="3A" />
                            <asp:ListItem Text="3 Adults, 1 Child" Value="3A1C" />
                        </asp:DropDownList>

                        <asp:RequiredFieldValidator
                            ID="rfvGuest"
                            runat="server"
                            ControlToValidate="guest"
                            InitialValue=""
                            ErrorMessage="Select Guests"
                            ForeColor="Red"
                            Display="Dynamic">
                        </asp:RequiredFieldValidator>
                    </div>

                    <div class="select-option">
                        <label>Room Type:</label>
                        <select id="roomtype" runat="server">
                            <option value="">Select Room Type</option>
                            <option value="AC Room">AC Room</option>
                            <option value="Non-AC Room">Non-AC Room</option>
                        </select>

                        <asp:RequiredFieldValidator
                            ID="rfvRoomType"
                            runat="server"
                            ControlToValidate="roomtype"
                            InitialValue=""
                            ErrorMessage="Select Room Type"
                            ForeColor="Red"
                            Display="Dynamic">
                        </asp:RequiredFieldValidator>
                    </div>

                    <div class="check-date">
                        <label>Room:</label>
                        <input type="text" id="room" runat="server" readonly>


                        <small style="color: gray;">Max 3 guests allowed per room</small>

                        <asp:RequiredFieldValidator
                            ID="rfvRoom"
                            runat="server"
                            ControlToValidate="room"
                            InitialValue=""
                            ErrorMessage="Select Number of Rooms"
                            ForeColor="Red"
                            Display="Dynamic">
                        </asp:RequiredFieldValidator>
                    </div>



                    <!-- Button -->
                    <asp:Button
                        ID="btnCheckAvailability"
                        runat="server"
                        Text="Check Availability"
                        CssClass="btn w-100 mt-3" OnClick="btnCheckAvailability_Click" />

                </div>
            </div>
        </div>
    </div>
</asp:Content>

