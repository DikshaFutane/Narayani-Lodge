<%@ Page Title="Places" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeFile="PlacesNearBy.aspx.cs" Inherits="PlacesNearBy" %>


<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <main aria-labelledby="title">
        <!-- Contact Section Begin -->
        <section class="contact-section spad">
            <div class="container">
                <div class="row">
                    <div class="col-lg-12">
                        <div class="section-title">
                            <h3>Explore Around Us</h3>
                            <p>Populat Attraction and Important locations around Narayani Lodge</p>
                        </div>
                    </div>
                </div>
                <div class="row">
               
                    <div class="col-lg-4">
                        <div class="blog-item set-bg place-card" data-setbg="img/blog/blog-details/mahalaxmitemple.jpg">
                            <div class="bi-text">
                                <span class="b-tag">Mahalaxmi Temple</span>
                                <h4><a href="#">A Famous Spiritual Landmark In Kolhapur.</a></h4>
                                <div class="b-time"><i class="icon_pin_alt"></i>2 km away</div>
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-4">
                        <div class="blog-item set-bg place-card" data-setbg="img/blog/blog-details/rankala2.jpg">
                            <div class="bi-text">
                                <span class="b-tag">Rankala Lake</span>
                                <h4><a href="#">A Popular Lakeside Spot For Relaxation And Sunsets.</a></h4>
                                <div class="b-time"><i class="icon_pin_alt"></i>3 km away</div>
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-4">
                        <div class="blog-item set-bg place-card" data-setbg="img/blog/blog-details/panchgangariver.png">
                            <div class="bi-text">
                                <span class="b-tag">Panchganga Ghat</span>
                                <h4><a href="#">A Peaceful Holy Ghat With Spiritual Significance</a></h4>
                                <div class="b-time"><i class="icon_pin_alt"></i>2 km away</div>
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-4">
                        <div class="blog-item small-size set-bg place-card" data-setbg="img/blog/blog-details/newpalace.jpg">
                            <div class="bi-text">
                                <span class="b-tag">New Palace</span>
                                <h4><a href="#">A Beautiful Palace Reflecting Kolhapur’s Royal History.</a></h4>
                                <div class="b-time"><i class="icon_pin_alt"></i>3 km away</div>
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-4">
                        <div class="blog-item small-size set-bg place-card" data-setbg="img/blog/blog-details/panhala.jpeg">
                            <div class="bi-text">
                                <span class="b-tag">Panhala Fort</span>
                                <h4><a href="#">A Famous Hill Fort Known For History And Nature.</a></h4>
                                <div class="b-time"><i class="icon_pin_alt"></i>20 km away</div>
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-4">
                        <div class="blog-item small-size set-bg place-card" data-setbg="img/blog/blog-details/JyotibaTemple.jpg">
                            <div class="bi-text">
                                <span class="b-tag">Jyotiba Temple</span>
                                <h4><a href="#">A Peaceful Hilltop Destination Of Faith And Spirituality</a></h4>
                                <div class="b-time"><i class="icon_pin_alt"></i>16 km away</div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>
   

    </main>
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
