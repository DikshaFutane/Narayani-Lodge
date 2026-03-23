<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/Admin.Master" AutoEventWireup="true" CodeFile="ViewBooking.aspx.cs" Inherits="Admin_ViewBooking" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <link rel="icon" href="assets/images/narayanilodgelogo.png" type="image/x-icon" />
    <link rel="stylesheet" href="assets/css/style.css" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <!-- [ Main Content ] start -->
    <div class="pc-container">
        <div class="pc-content">
            <!-- [ breadcrumb ] start -->
            <div class="page-header">
                <div class="page-block">
                    <div class="page-header-title">
                        <h5 class="mb-0 font-medium">All Bookings</h5>
                    </div>
                </div>
            </div>
            <!-- [ breadcrumb ] end -->


            <!-- [ Main Content ] start -->

            <div class="grid grid-cols-12 gap-x-6">
                <!-- [ sample-page ] start -->
                <div class="col-span-12">
                    <div class="card">
                        
                        <div class="card-header">
                            <h5>Booking Details</h5>
                        </div>
                        <div class="card-body">

                            <asp:DetailsView
                                ID="dvBooking"
                                runat="server"
                                CssClass="table table-bordered"
                                AutoGenerateRows="true">
                            </asp:DetailsView>

                            <asp:Button
    ID="btnBack"
    runat="server"
    Text="Back to All Bookings"
    CssClass="btn btn-secondary"
    OnClick="btnBack_Click" />
                        </div>

                    </div>
                </div>
            </div>
        </div>
    </div>

</asp:Content>

