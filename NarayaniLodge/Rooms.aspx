<%@ Page Title="Room" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeFile="Rooms.aspx.cs" Inherits="Rooms" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" Runat="Server">
    
    <!-- Rooms Section Begin -->
    <section class="rooms-section spad">
        <div class="container">
            <div class="row">
    <div class="col-lg-12">
        <div class="section-title">
            <h3>Our Rooms</h3>
            <p>Well-furnished rooms with essential amenities</p>
        </div>
    </div>
</div>
            <div class="row">
                <div class="col-lg-6 col-md-6">
                    <div class="room-item">
                        <img src="img/room/rooms/ACRoom.jpeg" alt="">
                        <div class="ri-text">
                            <h4>AC Room</h4>
                            <h3>2000rs<span>/Pernight</span></h3>
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
                                        <td>Wi-Fi, TV, Attached Bathroom, Hot Water, AC....</td>
                                    </tr>
                                </tbody>
                            </table>
                            <a href="ACRoomdetails.aspx" class="primary-btn">More Details</a>
                        </div>
                    </div>
                </div>
                <div class="col-lg-6 col-md-6">
                    <div class="room-item">
                        <img src="img/room/rooms/Nonacroom.jpg" />
                        <div class="ri-text">
                            <h4>Non AC Room</h4>
                            <h3>1600rs<span>/Pernight</span></h3>
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
                                        <td>Wi-Fi, TV, Attached Bathroom....</td>
                                    </tr>
                                </tbody>
                            </table>
                            <a href="Nonacroomdetails.aspx" class="primary-btn">More Details</a>
                        </div>
                    </div>
                </div>
                </div>
            </div>
        </section>
</asp:Content>

