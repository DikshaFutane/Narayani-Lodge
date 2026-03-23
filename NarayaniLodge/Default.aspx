<%@ Page Title="Home Page" Language="C#" MasterPageFile="~/Site.Master"
    AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="NarayaniLodge._Default" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

    <%--    <main>--%>
    <section class="hero-section">
        <div class="container m-3">
            <div class="row">
                <div class="col-lg-6">
                    <div class="hero-text">
                        <h1>Narayani Luxury Lodge</h1>
                        <p>A perfect place to relax with well-furnished rooms and warm hospitality.</p>
                        <a href="Rooms.aspx" class="primary-btn">Explore Rooms</a>
                    </div>
                </div>
                <div class="col-xl-4 col-lg-5 offset-xl-2 offset-lg-1">
                    <div class="booking-form">
                        <h3>Booking Your Room</h3>

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

                        <div class="check-date">
                            <label>Room:</label>
                            <input type="text" id="room" runat="server" ReadOnly>

      
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


                        <button type="button" runat="server"
                            onserverclick="btnCheck_Click1">
                            Check Availability
                        </button>

                    </div>
                </div>
            </div>
        </div>
        <div class="hero-slider owl-carousel">
            <div class="hs-item set-bg" data-setbg="img/hero/hero-1.jpeg"></div>
            <div class="hs-item set-bg" data-setbg="img/hero/hero-2.jpg"></div>
            <div class="hs-item set-bg" data-setbg="img/hero/hero-3.jpeg"></div>
        </div>
    </section>
    <!-- Hero Section End -->

    <!-- About Us Section Begin -->
    <section class="aboutus-section spad">
        <div class="container">
            <div class="row">
                <div class="col-lg-6">
                    <div class="about-text">
                        <div class="section-title">
                            <span>About Us</span>
                            <h2>Narayani Luxury Lodge</h2>
                        </div>
                        <p class="f-para">
                            Narayani Luxury Lodge offers a comfortable and peaceful stay for travelers seeking quality service and a relaxing environment. 
                            Located in a convenient area, our lodge is ideal for families, business travelers, and tourists alike.
                        </p>
                        <p class="s-para">
                            We focus on providing clean, well-furnished rooms with essential modern amenities to ensure a pleasant and hassle-free experience for every guest. 
                            Our warm hospitality and attentive service make every stay memorable.
                        </p>
                        <a href="About.aspx" class="primary-btn about-btn">Read More</a>
                    </div>
                </div>
                <div class="col-lg-6">
                    <div class="about-pic">
                        <div class="row">
                            <div class="col-sm-6 place-card">
                                <img src="img/about/about1.jpg" alt="">
                            </div>
                            <div class="col-sm-6 place-card">
                                <img src="img/about/about2.png" alt="">
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <!-- About Us Section End -->

    <!-- Services Section End -->
    <section class="services-section spad">
        <div class="container">
            <div class="row">
                <div class="col-lg-12">
                    <div class="section-title">
                        <span>What We Do</span>
                        <h2>Discover Our Services</h2>
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="col-lg-4 col-sm-6">
                    <div class="service-item">
                        <i class="flaticon-029-wifi"></i>
                        <h4>Free Wi-Fi Access</h4>
                        <p>Stay connected with complimentary high-speed Wi-Fi available for all guests.</p>
                    </div>
                </div>
                <div class="col-lg-4 col-sm-6">
                    <div class="service-item">
                        <i class="flaticon-003-air-conditioner"></i>
                        <h4>Comfortable AC & Non-AC Rooms</h4>
                        <p>Well-furnished rooms designed to provide comfort and relaxation for every stay.</p>
                    </div>
                </div>
                <div class="col-lg-4 col-sm-6">
                    <div class="service-item">
                        <i class="flaticon-024-towel"></i>
                        <h4>24/7 Hot & Cold Water</h4>
                        <p>Continuous hot and cold water supply for your convenience at any time.</p>
                    </div>
                </div>
                <div class="col-lg-4 col-sm-6">
                    <div class="service-item">
                        <i class="flaticon-026-bed"></i>
                        <h4>Extra Bedding on Request</h4>
                        <p>Additional bedding provided upon request for families or group stays</p>
                    </div>
                </div>
                <div class="col-lg-4 col-sm-6">
                    <div class="service-item">
                        <i class="flaticon-036-parking"></i>
                        <h4>Parking Facility</h4>
                        <p>Safe and convenient parking space available for guests.</p>
                    </div>
                </div>
                <div class="col-lg-4 col-sm-6">
                    <div class="service-item">
                        <i class="flaticon-044-clock-1"></i>
                        <h4>24/7 Front Desk Support</h4>
                        <p>Friendly staff available round the clock to assist guests with their needs.</p>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <!-- Services Section End -->

    <!-- Home Room Section Begin -->
    <section class="hp-room-section">
        <div class="container-fluid">
            <div class="row">
                <div class="col-lg-12">
                    <div class="section-title">
                        <span>Where You Stay </span>
                        <h2>Discover Our Rooms</h2>
                    </div>
                </div>
            </div>
            <div class="hp-room-items">
                <div class="row">
                    <div class="col-lg-6 col-md-6">
                        <div class="hp-room-item set-bg" data-setbg="img/room/rooms/ACRoom.jpeg">
                            <div class="hr-text">
                                <h3>AC Room</h3>
                                <h2>2000rs<span>/Pernight</span></h2>
                                <table>
                                    <tbody>
                                        <tr>
                                            <td class="r-o">Services:</td>
                                            <td>Air Conditioner, Wifi, Television, Bathroom,...</td>
                                        </tr>
                                    </tbody>
                                </table>
                                <a href="Rooms.aspx" class="primary-btn">More Details</a>
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-6 col-md-6">
                        <div class="hp-room-item set-bg" data-setbg="img/room/rooms/Nonacroom.jpg">
                            <div class="hr-text">
                                <h3>Non-AC Room</h3>
                                <h2>1600rs<span>/Pernight</span></h2>
                                <table>
                                    <tbody>
                                        <tr>
                                            <td class="r-o">Services:</td>
                                            <td>Wifi, Television, Bathroom,...</td>
                                        </tr>
                                    </tbody>
                                </table>
                                <a href="Rooms.aspx" class="primary-btn">More Details</a>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <!-- Home Room Section End -->

    <!-- Blog Section Begin -->
    <section class="blog-section spad">
        <div class="container">
            <div class="row">
                <div class="col-lg-12">
                    <div class="section-title">
                        <span>Places Nearby</span>
                        <h2>Explore Around Us</h2>
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="col-lg-4">
                    <div class="blog-item set-bg place-card" data-setbg="img/blog/mahalaxmitemple.jpg">
                        <div class="bi-text">
                            <span class="b-tag">Mahalaxmi Temple</span>
                            <h4><a href="#">A Famous Spiritual Landmark In Kolhapur.</a></h4>
                            <div class="b-time"><i class="icon_pin_alt"></i>2 km away</div>
                        </div>
                    </div>
                </div>
                <div class="col-lg-4">
                    <div class="blog-item set-bg place-card" data-setbg="img/blog/rankala2.jpg">
                        <div class="bi-text">
                            <span class="b-tag">Rankala Lake</span>
                            <h4><a href="#">A Popular Lakeside Spot For Relaxation And Sunsets.</a></h4>
                            <div class="b-time"><i class="icon_pin_alt"></i>3 km away</div>
                        </div>
                    </div>
                </div>
                <div class="col-lg-4">
                    <div class="blog-item set-bg place-card" data-setbg="img/blog/panchgangariver.png">
                        <div class="bi-text">
                            <span class="b-tag">Panchganga Ghat</span>
                            <h4><a href="#">A Peaceful Holy Ghat With Spiritual Significance</a></h4>
                            <div class="b-time"><i class="icon_pin_alt"></i>2 km away</div>
                        </div>
                    </div>
                </div>
                <div class="col-lg-8">
                    <div class="blog-item small-size set-bg place-card" data-setbg="img/blog/newpalace.jpg">
                        <div class="bi-text">
                            <span class="b-tag">New Palace</span>
                            <h4><a href="#">A Beautiful Palace Reflecting Kolhapur’s Royal History.</a></h4>
                            <div class="b-time"><i class="icon_pin_alt"></i>3 km away</div>
                        </div>
                    </div>
                </div>
                <div class="col-lg-4">
                    <div class="blog-item small-size set-bg place-card" data-setbg="img/blog/panhala.jpeg">
                        <div class="bi-text">
                            <span class="b-tag">Panhala Fort</span>
                            <h4><a href="#">A Famous Hill Fort Known For History And Nature.</a></h4>
                            <div class="b-time"><i class="icon_pin_alt"></i>20 km away</div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <!-- Blog Section End -->

    <%--   </main>--%>
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
