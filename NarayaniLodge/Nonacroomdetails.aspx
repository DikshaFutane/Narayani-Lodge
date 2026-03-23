<%@ Page Title="Room" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeFile="Nonacroomdetails.aspx.cs" Inherits="Nonacroomdetails" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="Server">
    <!-- Room Details Section Begin -->
    <section class="room-details-section spad">
        <div class="container mt-4">
            <div class="row">
                <div class="col-lg-8">
                    <div class="room-details-item">
                        <img src="img/room/rooms/Nonacroom.jpg" alt="">
                        <div class="rd-text">
                            <div class="rd-title">
                                <h3>Non-AC Room</h3>
                                <div class="rdt-right">
                                    <a href="Authentication/Login.aspx">Booking Now</a>
                                </div>
                            </div>
                            <h2>1600rs<span>/Pernight</span></h2>
                            <table>
                                <tbody>
                                    <tr>
                                        <td class="r-o">Capacity:</td>
                                        <td>Max person 3</td>
                                    </tr>
                                    <tr>
                                        <td class="r-o">Bed:</td>
                                        <td>King Beds</td>
                                    </tr>
                                    <tr>
                                        <td class="r-o">Services:</td>
                                        <td>Wifi, Television, Bathroom,...</td>
                                    </tr>
                                </tbody>
                            </table>
                            <p class="f-para">
                                Our Room is designed to provide a comfortable and relaxing stay for guests. The room is equipped with  a cozy double bed with fresh linen, and a clean attached bathroom.
                             It includes essential amenities such as free Wi-Fi, a flat-screen TV, wardrobe space. 
                             Hot and cold water supply, power backup, and daily housekeeping ensure a hassle-free experience. The room is well-lit, ventilated, and ideal for couples, solo travelers, or small families looking for a peaceful stay..
                            </p>
                        </div>
                    </div>
                    <div class="">
                        <h4>Photots</h4>
                        <div class="row">
                            <div class="col-md-4 place-card">
                                <img src="img/room/n1.jpg" alt="room" />
                            </div>
                            <div class="col-md-4 place-card">
                                <img src="img/room/n4.jpg" alt="room" />
                            </div>
                            <div class="col-md-4 place-card">
                                <img src="img/room/n7.jpg" alt="room" />
                            </div>
                        </div>
                    </div>
                    <div class="row">
                    </div>
                </div>
                <div class="col-lg-4">
                    <div class="room-booking">
                        <h3>Your Reservation</h3>

                        <div class="booking-form">
                            <asp:HiddenField ID="hfRoomType" runat="server" Value="Non-AC Room" />

                            <div class="check-date">
                                <label>Check In:</label>
                                <input type="text" class="date-input" id="datein" runat="server">
                                <i class="icon_calendar"></i>

                                <asp:RequiredFieldValidator
                                    ID="rfvCheckIn"
                                    runat="server"
                                    ControlToValidate="datein"
                                    ErrorMessage="Select Check-In Date"
                                    ForeColor="Red"
                                    Display="Dynamic">
                                </asp:RequiredFieldValidator>
                            </div>

                            <div class="check-date">
                                <label>Check Out:</label>
                                <input type="text" class="date-input" id="dateout" runat="server">
                                <i class="icon_calendar"></i>

                                <asp:RequiredFieldValidator
                                    ID="rfvCheckOut"
                                    runat="server"
                                    ControlToValidate="dateout"
                                    ErrorMessage="Select Check-Out Date"
                                    ForeColor="Red"
                                    Display="Dynamic">
                                </asp:RequiredFieldValidator>
                            </div>

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

                            <div class="select-option">
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
                                <button type="submit" runat="server"
                                    onserverclick="Unnamed_ServerClick">
                                    Check Availability
                                </button>

                            </div>
                        </div>
                    </div>
                </div>
            </div>
    </section>
    <!-- Room Details Section End -->

    <script>
        document.addEventListener("DOMContentLoaded", function () {
            const cards = document.querySelectorAll(".place-card");

            const observer = new IntersectionObserver((entries) => {
                entries.forEach((entry, index) => {
                    if (entry.isIntersecting) {
                        setTimeout(() => {
                            entry.target.classList.add("show");
                        }, index * 150); // delay animation
                        observer.unobserve(entry.target);
                    }
                });
            }, { threshold: 0.2 });

            cards.forEach(card => observer.observe(card));
        });
    </script>
</asp:Content>

