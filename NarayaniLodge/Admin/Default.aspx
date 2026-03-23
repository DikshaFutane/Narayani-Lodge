<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/Admin.Master" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="NarayaniLodge.Admin.Default" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <link rel="icon" href="assets/images/narayanilodgelogo.png" type="image/x-icon" />
    <style>
.popup-overlay {
    position: fixed;
    inset: 0;
    background: rgba(0, 0, 0, 0.5);
    backdrop-filter: blur(3px);
    z-index: 999;
}

.popup {
    position: fixed;
    top: 50%;
    left: 50%;
    transform: translate(-50%, -50%);
    background: #ffffff;
    width: 400px;
    border-radius: 16px;
    padding: 25px;
    z-index: 1000;
    box-shadow: 0 20px 40px rgba(0, 0, 0, 0.2);
    animation: fadeIn 0.3s ease-in-out;
}

.popup h3 {
    font-size: 20px;
    font-weight: 600;
    margin-bottom: 20px;
}

.popup label {
    font-size: 14px;
    font-weight: 500;
}

.popup input {
    width: 100%;
    padding: 8px;
    margin-top: 5px;
    margin-bottom: 15px;
    border: 1px solid #ddd;
    border-radius: 8px;
}

.popup .btn-primary {
    background: #16a34a;
    color: white;
    padding: 8px 15px;
    border-radius: 8px;
    border: none;
    cursor: pointer;
}

.popup .btn-primary:hover {
    background: #15803d;
}

.popup .btn-secondary {
    background: #e5e7eb;
    padding: 8px 15px;
    border-radius: 8px;
    border: none;
    cursor: pointer;
    margin-left: 10px;
}

@keyframes fadeIn {
    from { opacity: 0; transform: translate(-50%, -55%); }
    to { opacity: 1; transform: translate(-50%, -50%); }
}
</style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <!-- [ Main Content ] start -->
    <div class="pc-container">
        <div class="pc-content">
            <div class="mb-4">
                <asp:Label ID="lblGreeting" runat="server" CssClass="text-xl font-semibold"></asp:Label>
            </div>
            <div class="grid grid-cols-12 gap-x-3">
                <div class="col-span-12 md:col-span-6 lg:col-span-4">
                    <div class="card">
                        <div class="card-header !pb-0 !border-b-0">
                            <h5>Today's Arrival</h5>
                        </div>
                        <div class="card-body">
                            <div class="flex items-center justify-between gap-3 flex-wrap">
                                <h3 class="font-light flex items-center mb-0">
                                    <i class="feather icon-log-in text-success-500 text-[30px] mr-1.5"></i>
                                    <asp:Label ID="lblArrivals" runat="server" Text="0"></asp:Label>
                                </h3>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-span-12 md:col-span-6 lg:col-span-4">
                    <div class="card">
                        <div class="card-header !pb-0 !border-b-0">
                            <h5>Today’s Departures</h5>
                        </div>
                        <div class="card-body">
                            <div class="flex items-center justify-between gap-3 flex-wrap">
                                <h3 class="font-light flex items-center mb-0">
                                    <i class="feather icon-log-out text-danger-500 text-[30px] mr-1.5"></i>
                                    <asp:Label ID="lblDepartures" runat="server" Text="0"></asp:Label>
                                </h3>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-span-12 md:col-span-6 lg:col-span-4">
                    <div class="card">
                        <div class="card-header !pb-0 !border-b-0">
                            <h5>Available Rooms</h5>
                        </div>
                        <div class="card-body">
                            <div class="flex items-center justify-between gap-3 flex-wrap">
                                <h3 class="font-light flex items-center mb-0">
                                    <i class="feather icon-grid text-primary-500 text-[30px] mr-1.5"></i>
                                    <asp:Label ID="lblAvailableRooms" runat="server" Text="0"></asp:Label>
                                </h3>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-span-12 md:col-span-6 lg:col-span-4">
                    <div class="card">
                        <div class="card-header !pb-0 !border-b-0">
                            <h5>New Enquires</h5>
                        </div>
                        <div class="card-body">
                            <div class="flex items-center justify-between gap-3 flex-wrap">
                                <h3 class="font-light flex items-center mb-0">
                                    <i class="feather icon-message-square text-blue-500 text-[30px] mr-1.5"></i>
                                    <asp:Label ID="lblNewEnquiry" runat="server" Text="0"></asp:Label>
                                </h3>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-span-12 md:col-span-6 lg:col-span-4">
                    <div class="card">
                        <div class="card-header !pb-0 !border-b-0">
                            <h5>Today’s Revenue</h5>
                        </div>
                        <div class="card-body">
                            <div class="flex items-center justify-between gap-3 flex-wrap">
                                <h3 class="font-light flex items-center mb-0">
                                    <span class="text-success-500 text-[30px] mr-1.5">₹</span>
                                    <asp:Label ID="lblrevenue" runat="server" Text="0"></asp:Label>
                                </h3>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-span-12 md:col-span-6 lg:col-span-4">
                    <div class="card">
                        <div class="card-header !pb-0 !border-b-0">
                            <h5>Pending Payments</h5>
                        </div>
                        <div class="card-body">
                            <div class="flex items-center justify-between gap-3 flex-wrap">
                                <h3 class="font-light flex items-center mb-0">
                                    <span class="text-success-500 text-[30px] mr-1.5">₹</span>
                                    <asp:Label ID="lblPendingPayments" runat="server" Text="0"></asp:Label>
                                </h3>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <div class="grid grid-cols-12 gap-x-6">
                <div class="col-span-12 md:col-span-6 lg:col-span-6">
                    <div class="card">
                        <div class="card-header !pb-0 !border-b-0">
                            <h5>Weekly Revenue</h5>
                        </div>
                        <div class="card-body">
                            <div style="width: 80%; margin-bottom: 10px">
                                <canvas id="revenueChart" height="250"></canvas>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-span-12 md:col-span-6 lg:col-span-6">
                    <div class="card">
                        <div class="card-header !pb-0 !border-b-0">
                            <h5>Booking Status</h5>
                        </div>
                        <div class="card-body">
                            <div style="width: 66%; margin-bottom: 10px">
                                <canvas id="bookingStatusChart" height="250"></canvas>

                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-span-12 xl:col-span-8 md:col-span-6">
                <div class="card table-card">
                    <div class="card-header">
                        <h5>Recent Bookings</h5>
                    </div>
                    <div class="card-body">
                        <div class="table-responsive p-2">
                            <asp:GridView
                                ID="gvAllBookings"
                                runat="server"
                                AutoGenerateColumns="False"
                                CssClass="table table-bordered table-striped"
                                AllowPaging="True"
                                PageSize="10"
                                DataKeyNames="BookingId"
                                EmptyDataText="No Data Available."
                                ShowHeaderWhenEmpty="True"
                                OnPageIndexChanging="gvAllBookings_PageIndexChanging">
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
                                    <asp:BoundField DataField="RoomType" HeaderText="Room Type" />
                                    <asp:BoundField DataField="CheckInDate" HeaderText="Check In"
                                        DataFormatString="{0:dd-MM-yyyy}" />
                                    <asp:BoundField DataField="BookingStatus" HeaderText="Status" />
                                </Columns>

                            </asp:GridView>

                        </div>
                    </div>
                </div>
            </div>


            <div class="w-full flex flex-col lg:flex-row gap-6 mt-6">

                <!-- Today's Arrival -->
                <div class="flex-1">
                    <div class="card table-card w-full">
                        <div class="card-header">
                            <h5>Today's Arrival</h5>
                        </div>
                        <div class="card-body">
                            <div class="overflow-x-auto p-2">
                                <asp:GridView
                                    ID="GridViewArrivals"
                                    runat="server"
                                    AutoGenerateColumns="False"
                                    CssClass="table table-bordered table-striped"
                                    AllowPaging="True"
                                    PageSize="10"
                                    DataKeyNames="BookingId"
                                    EmptyDataText="No Data Available."
                                    ShowHeaderWhenEmpty="True"
                                    OnPageIndexChanging="gvAllBookings_PageIndexChanging">
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
                                        <asp:BoundField DataField="GuestName" HeaderText="Guest Name" />
                                        <asp:BoundField DataField="RoomType" HeaderText="Room Type" />
                                        <asp:BoundField DataField="GuestPhone" HeaderText="Contact" />
                                        <asp:BoundField DataField="TotalAmount" HeaderText="Total Amount" />
                                        <asp:BoundField DataField="BookingStatus" HeaderText="Payment Status" />
                                    </Columns>
                                </asp:GridView>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Today's Departures -->
                <div class="flex-1">
                    <div class="card table-card w-full">
                        <div class="card-header">
                            <h5>Today's Departures</h5>
                        </div>
                        <div class="card-body">
                            <div class="overflow-x-auto p-2">
                                <asp:GridView
                                    ID="GridViewDepartures"
                                    runat="server"
                                    AutoGenerateColumns="False"
                                    CssClass="table table-bordered table-striped"
                                    AllowPaging="True"
                                    PageSize="10"
                                    DataKeyNames="BookingId"
                                    EmptyDataText="No Data Available."
                                    ShowHeaderWhenEmpty="True"
                                    OnPageIndexChanging="gvAllBookings_PageIndexChanging"
                                    OnRowCommand="GridView1_RowCommand"
                                    OnRowDataBound="GridView1_RowDataBound">
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
                                        <asp:BoundField DataField="GuestName" HeaderText="Guest Name" />
                                        <asp:BoundField DataField="RoomType" HeaderText="Room Type" />
                                        <asp:BoundField DataField="TotalAmount" HeaderText="Total Amount" />
                                        <asp:BoundField DataField="RemainingAmount" HeaderText="Pending Amount" />
                                        <asp:TemplateField HeaderText="Action">
                                            <ItemTemplate>
                                                <asp:Button ID="btnCollect"
                                                    runat="server"
                                                    Text="Collect Payment"
                                                    CommandName="Collect"
                                                    CommandArgument='<%# Eval("BookingID") %>' />
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                    </Columns>
                                </asp:GridView>

                                    <asp:Panel ID="pnlOverlay" runat="server" CssClass="popup-overlay" Visible="false"></asp:Panel>
                                <asp:Panel ID="pnlPayment" runat="server" Visible="false" CssClass="popup">

                                    <asp:HiddenField ID="hfBookingID" runat="server" />

                                    <h3>Collect Payment</h3>

                                    Total Amount:
    <asp:Label ID="lblTotal" runat="server"></asp:Label>
                                    <br />

                                    Paid Amount:
    <asp:Label ID="lblPaid" runat="server"></asp:Label>
                                    <br />

                                    Enter Payment:
    <asp:TextBox ID="txtPayment" runat="server"></asp:TextBox> 
                                    <br />
                                    <br />

                                    <asp:Button ID="btnSavePayment"
                                        runat="server" 
                                        Text="Save"
                                        OnClick="btnSavePayment_Click" />

                                    <asp:Button ID="btnClose"
                                        runat="server"
                                        Text="Close"
                                        onclick="btnClose_Click" />

                                </asp:Panel>
                            </div>
                        </div>
                    </div>
                </div>

            </div>
        </div>
    </div>
    <!-- [ Main Content ] end -->


</asp:Content>
