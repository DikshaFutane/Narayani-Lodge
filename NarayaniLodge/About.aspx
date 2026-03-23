<%@ Page Title="About" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="About.aspx.cs" Inherits="NarayaniLodge.About" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <main aria-labelledby="title">
        <section class="aboutus-page-section spad">
        <div class="container mt-4">
            <div class="about-page-text">
                <div class="row">
                    <div class="col-lg-6">
                        <div class="ap-title">
                            <h3>Welcome To Narayani Lodge.</h3>
                            <p>Narayani Lodge offers a comfortable and peaceful stay for travelers seeking quality service and a relaxing environment.
                                Located in a convenient area, our lodge is ideal for families, business travelers, and tourists alike.
                                We focus on providing clean, well-furnished rooms with essential modern amenities to ensure a pleasant and hassle-free experience for every guest. 
                                Our warm hospitality and attentive service make every stay memorable.
                                Narayani Lodge is a comfortable and budget-friendly stay located in the heart of Kolhapur. 
                                We aim to provide our guests with a peaceful, safe, and pleasant lodging experience with all essential modern amenities.
                                Our lodge is conveniently situated near popular tourist attractions, temples, and local markets, making it an ideal choice for families, travelers, and business visitors. 
                            </p>
                             </div>
                    </div>
                    <div class="col-lg-5 offset-lg-1">
                        <p>
                        At Narayani Lodge, we focus on cleanliness, hospitality, and customer satisfaction to ensure a relaxing stay for every guest.
                        Whether you are visiting Kolhapur for tourism, business, or a short stay, Narayani Lodge offers a warm welcome and a homely atmosphere.</p>
                       
                        <ul class="ap-services">
                            <li><i class="icon_check"></i> Clean & Well-Maintained Rooms</li>
                            <li><i class="icon_check"></i> Comfortable Stay at Affordable Prices</li>
                            <li><i class="icon_check"></i> Free Wi-Fi</li>
                            <li><i class="icon_check"></i> Daily Housekeeping</li>
                            <li><i class="icon_check"></i>Friendly & Helpful Staff</li>
                        </ul>
                    </div>
                </div>
            </div>
            <div class="about-page-services">
                <div class="row">
                    <div class="col-md-4 place-card">
                        <div class="ap-service-item set-bg" data-setbg="img/about/aboutp3.jpg">
                            <div class="api-text">
                                <h3>AC Room</h3>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-4 place-card">
                        <div class="ap-service-item set-bg" data-setbg="img/about/aboutp4.jpg">
                            <div class="api-text">
                                <h3>Non-AC Room</h3>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-4 place-card">
                        <div class="ap-service-item set-bg" data-setbg="img/about/aboutp2.jpeg">
                            <div class="api-text">
                                <h3>Dormitory Hall</h3>
                            </div>
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
