<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/Admin.Master" AutoEventWireup="true" CodeFile="BookingReport.aspx.cs" Inherits="Admin_BookingReport" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <link rel="icon" href="assets/images/narayanilodgelogo.png" type="image/x-icon" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <!-- [ Main Content ] start -->
    <div class="pc-container">
        <div class="pc-content">
            <!-- [ breadcrumb ] start -->
            <div class="page-header">
                <div class="page-block">
                    <div class="page-header-title">
                        <h5 class="mb-0 font-medium">Bookings Report</h5>
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
                            <h5>Booking Report</h5>
                        </div>
                        <div class="card-body">
                             <div class="card table-card">

     <div class="table-responsive">
            <div class="row mb-3">
                <div class="col-md-3">
                    <input type="date" id="txtFromDate" runat="server" class="form-control" placeholder="From Date" />
                </div>
                <div class="col-md-3">
                    <input type="date" id="txtToDate" runat="server" class="form-control" placeholder="To Date" />
                </div>
                <div class="col-md-3">
                    <input type="text" id="txtSearch" runat="server" class="form-control" placeholder="Search by Guest or Room" />
                </div>
                <div class="col-md-3">
                    <asp:Button ID="btnFilter" runat="server" Text="Filter" CssClass="btn btn-primary" OnClick="btnFilter_Click" />
                    <asp:Button ID="btnExportExcel" runat="server" Text="Export Excel" CssClass="btn btn-success ms-2" OnClick="btnExportExcel_Click" />
                    <asp:Button ID="btnExportPDF" runat="server" Text="Export PDF" CssClass="btn btn-danger ms-2" OnClick="btnExportPDF_Click" />
                </div>
            </div>

            <asp:GridView ID="gvBookings" runat="server" CssClass="table table-bordered table-striped"
                AutoGenerateColumns="false" EmptyDataText="No bookings found">
                <Columns>
                    <asp:BoundField HeaderText="Booking ID" DataField="BookingID" />
                    <asp:BoundField HeaderText="Guest Name" DataField="GuestName" />
                    <asp:BoundField HeaderText="Room Name" DataField="RoomType" />
                    <asp:BoundField HeaderText="Check-In Date" DataField="CheckInDate" DataFormatString="{0:yyyy-MM-dd}" />
                    <asp:BoundField HeaderText="Check-Out Date" DataField="CheckOutDate" DataFormatString="{0:yyyy-MM-dd}" />
                    <asp:BoundField HeaderText="Booking Date" DataField="BookingDate" DataFormatString="{0:yyyy-MM-dd}" />
                    <asp:BoundField HeaderText="Payment Status" DataField="PaymentStatus" />
                </Columns>
            </asp:GridView>
        </div></div></div>
                    </div>
                </div>
                </div></div>
            </div>
</asp:Content>

