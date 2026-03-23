<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/Admin.Master" AutoEventWireup="true" CodeFile="CancelledBookings.aspx.cs" Inherits="Admin_CancelledBookings" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
        <link rel="icon" href="assets/images/narayanilodgelogo.png" type="image/x-icon" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
         <!-- [ Main Content ] start -->
 <div class="pc-container">
     <div class="pc-content">
         <!-- [ breadcrumb ] start -->
         <div class="page-header">
             <div class="page-block">
                 <div class="page-header-title">
                     <h5 class="mb-0 font-medium">Cancelled Bookings</h5>
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
                         <h5>These booking is marked as cancelled</h5>
                     </div>
                     <div class="card-body">
                         <div class="card table-card">

                             <div class="table-responsive">

                                 <asp:GridView
                                     ID="gvAllBookings"
                                     runat="server"
                                     AutoGenerateColumns="False"
                                     CssClass="table table-bordered table-striped"
                                     AllowPaging="True"
                                     PageSize="10"
                                     OnPageIndexChanging="gvAllBookings_PageIndexChanging"
                                     DataKeyNames="BookingId"
                                     OnRowCommand="gvAllBookings_RowCommand"  
                                     EmptyDataText="No Data Available."
                                     ShowHeaderWhenEmpty="True">
                                     <HeaderStyle BackColor="#d0d6dd"
                                         ForeColor="#111"
                                         Font-Bold="true"
                                         HorizontalAlign="Center" />
                                     <Columns>

                                         <asp:TemplateField HeaderText="Sr. No">
                                             <ItemTemplate>
                                                 <%# Container.DataItemIndex + 1 %>
                                             </ItemTemplate>
                                         </asp:TemplateField>
                                         <asp:BoundField DataField="BookingDate" HeaderText="Booking Date"
                                             DataFormatString="{0:dd-MM-yyyy}" />

                                         <asp:BoundField DataField="GuestName" HeaderText="Guest Name" />
                                         <asp:BoundField DataField="GuestPhone" HeaderText="Phone" />
                                         <asp:BoundField DataField="RoomType" HeaderText="Room Type" />
                                         <asp:BoundField DataField="NoOfRooms" HeaderText="Rooms" />

                                         <asp:BoundField DataField="CheckInDate" HeaderText="Check In"
                                             DataFormatString="{0:dd-MM-yyyy}" />
                                         <asp:BoundField DataField="CheckOutDate" HeaderText="Check Out"
                                             DataFormatString="{0:dd-MM-yyyy}" />

                                         <asp:BoundField DataField="PaymentStatus" HeaderText="Payment" />
                                         <asp:BoundField DataField="TotalAmount" HeaderText="Total Amount" />

                                         <asp:BoundField DataField="CancellationDate" HeaderText="Cancellation Date and Time" />

                                         
                                     </Columns>
                                 </asp:GridView>

                             </div>
                         </div>
                     </div>

                 </div>
             </div>

         </div>
         <!-- [ sample-page ] end -->
     </div>
     <!-- [ Main Content ] end -->
 </div>
   
</asp:Content>

