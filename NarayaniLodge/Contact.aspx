<%@ Page Title="ContactUs" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeFile="Contact.aspx.cs" Inherits="Contact" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <main aria-labelledby="title">
        <!-- Contact Section Begin -->
        <section class="contact-section spad">
            <div class="container">
                <div class="row">
                    <div class="col-lg-4">
                        <div class="contact-text">
                            <h2>Contact Info</h2>
                            <p>Feel free to contact us—we’re always happy to assist you.”.</p>
                            <table>
                                <tbody>
                                    <tr>
                                        <td class="c-o">Address:</td>
                                        <td>Tarabai Road,Tatakadil Talim Kolhapur, Maharashtra 416012</td>
                                    </tr>
                                    <tr>
                                        <td class="c-o">Phone:</td>
                                        <td>(+91) 7218423323</td>
                                    </tr>
                                    <tr>
                                        <td class="c-o">Email:</td>
                                        <td>naratawadekark@gmail.com</td>
                                    </tr>
                                </tbody>
                            </table>
                            <div class="nearby-info">
                                <p>
                                    <strong>Railway Station:</strong>
                                    <a href="https://www.google.com/maps/dir/Narayani+Lodge,+Kolhapur/Railway+Station,+Kolhapur" target="_blank">3 km
                                    </a>
                                </p>
                                <p>
                                    <strong>Bus Stand:</strong>
                                    <a href="https://www.google.com/maps/dir/Narayani+Lodge,+Kolhapur/Bus+Stand,+Kolhapur" target="_blank">2.5 km
                                    </a>
                                </p>
                            </div>

                        </div>
                    </div>

                    <div class="col-lg-4 ml-2\.5 mr-0">
                        <asp:Panel runat="server" CssClass="contact-form">
                            <div class="row">

                                <div class="col-lg-12">
                                    <asp:RequiredFieldValidator
                                        ControlToValidate="txtName"
                                        runat="server"
                                        ErrorMessage="Name is required"
                                        ForeColor="Red"
                                        Display="Dynamic" />
                                    <asp:TextBox ID="txtName" runat="server" CssClass="form-control"
                                        placeholder="Your Name"></asp:TextBox>

                                </div>

                                <div class="col-lg-12">
                                    <asp:RequiredFieldValidator
                                        ControlToValidate="txtphone"
                                        runat="server"
                                        ErrorMessage="Phone number is required"
                                        ForeColor="Red"
                                        Display="Dynamic" />
                                    <asp:RegularExpressionValidator
                                        ControlToValidate="txtphone"
                                        runat="server"
                                        ErrorMessage="Enter valid 10-digit phone number"
                                        ValidationExpression="^[6-9]\d{9}$"
                                        ForeColor="Red"
                                        Display="Dynamic" />
                                    <asp:TextBox ID="txtphone" runat="server" CssClass="form-control"
                                        placeholder="Phone Number"></asp:TextBox>



                                </div>
                                <div class="col-lg-12">
                                    <asp:RequiredFieldValidator
                                        ControlToValidate="txtEmail"
                                        runat="server"
                                        ErrorMessage="Email is required"
                                        ForeColor="Red"
                                        Display="Dynamic" />
                                    <asp:RegularExpressionValidator
                                        ControlToValidate="txtEmail"
                                        runat="server"
                                        ErrorMessage="Enter valid email address"
                                        ValidationExpression="^[^@\s]+@[^@\s]+\.[^@\s]+$"
                                        ForeColor="Red"
                                        Display="Dynamic" />
                                    <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control"
                                        placeholder="Your Email"></asp:TextBox>



                                </div>


                                <div class="col-lg-12">
                                    <asp:RequiredFieldValidator
                                        ControlToValidate="txtMessage"
                                        runat="server"
                                        ErrorMessage="Message cannot be empty"
                                        ForeColor="Red"
                                        Display="Dynamic" />
                                    <asp:TextBox ID="txtMessage" runat="server" CssClass="form-control"
                                        TextMode="MultiLine" Rows="5"
                                        placeholder="Your Enquiry Message"></asp:TextBox>

                                </div>

                                <div class="col-lg-12">
                                    <asp:Button ID="btnSubmit" runat="server"
                                        Text="Submit Enquiry"
                                        Style="background: #dfa974; color: white"
                                        CausesValidation="true"
                                        OnClick="btnSubmit_Click" />
                                </div>

                                <div class="col-lg-12">
                                    <asp:Label ID="lblMsg" runat="server"></asp:Label>
                                </div>

                            </div>
                        </asp:Panel>
                    </div>



                    <div class="col-lg-4 ml-0">
                        <iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3821.6462816340745!2d74.21635487377124!3d16.694574784079233!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x3bc1000a7135f51f%3A0x6d656279cf0a9a17!2sNarayani%20Lodge!5e0!3m2!1sen!2sin!4v1769185652393!5m2!1sen!2sin" width="350" height="400" style="border: 0;" allowfullscreen="" loading="lazy" referrerpolicy="no-referrer-when-downgrade"></iframe>
                    </div>
                </div>
            </div>
        </section>
        <!-- Contact Section End -->
        <%--<script>
            function hideMessage() {
                setTimeout(function () {
                    var lbl = document.getElementById('<%= lblMsg.ClientID %>');
                    if (lbl) {
                        lbl.style.display = 'none';
                    }
                }, 3000); // 3 seconds
            }
        </script>--%>
    </main>
</asp:Content>

