<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/Admin.Master" AutoEventWireup="true" CodeFile="PendingBookings.aspx.cs" Inherits="Admin_PendingBookings" %>

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
                        <h5 class="mb-0 font-medium">Pending Bookings</h5>
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
                            <h5>These bookings are awaiting admin approval</h5>
                        </div>
                        <div class="card-body">
                            <div class="card table-card">

                                <div class="table-responsive">

                                    <asp:GridView
                                        ID="gvPendingBookings"
                                        runat="server"
                                        AutoGenerateColumns="False"
                                        CssClass="table table-bordered table-striped"
                                        AllowPaging="True"
                                        PageSize="10"
                                        OnPageIndexChanging="gvPendingBookings_PageIndexChanging"
                                        DataKeyNames="BookingId"
                                        OnRowCommand="gvPendingBookings_RowCommand"
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

                                            <asp:BoundField DataField="BookingStatus" HeaderText="Booking Status" />

                                            <asp:TemplateField HeaderText="Actions">
                                                <ItemTemplate>

                                                    <asp:Button
                                                        ID="btnView"
                                                        runat="server"
                                                        Text="Approve"
                                                        CssClass="btn btn-sm btn-info"
                                                        CommandName="ViewBooking"
                                                        CommandArgument='<%# Eval("BookingId") %>' />

                                                    <asp:Button
                                                        ID="btnEdit"
                                                        runat="server"
                                                        Text="Cancel"
                                                        CssClass="btn btn-sm btn-danger"
                                                        CommandName="EditBooking"
                                                        CommandArgument='<%# Eval("BookingId") %>' />
                                                </ItemTemplate>
                                            </asp:TemplateField>
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

