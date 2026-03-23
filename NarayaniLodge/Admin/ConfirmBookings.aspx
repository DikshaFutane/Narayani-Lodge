<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/Admin.Master" AutoEventWireup="true" CodeFile="ConfirmBookings.aspx.cs" Inherits="Admin_ConfirmBookings" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <style>
.overlay {
    position: fixed;
    top: 0;
    left: 0;
    right: 0;
    bottom: 0;
    background: rgba(0, 0, 0, 0.6);
    display: flex;
    justify-content: center;
    align-items: center;
    z-index: 9999;
}

.popup-box {
    background: #ffffff;
    padding: 25px;
    width: 350px;
    border-radius: 8px;
    box-shadow: 0 5px 20px rgba(0,0,0,0.3);
}

.amount-text {
    font-weight: bold;
    color: red;
}
</style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <!-- [ Main Content ] start -->
    <div class="pc-container">
        <div class="pc-content">
            <!-- [ breadcrumb ] start -->
            <div class="page-header">
                <div class="page-block">
                    <div class="page-header-title">
                        <h5 class="mb-0 font-medium">Confirmed Bookings</h5>
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
                            <h5>These bookings are approved and reserved</h5>
                        </div>
                        <div class="card-body">
                            <div class="card table-card">

                                <div class="table-responsive">

                                    <asp:GridView
                                        ID="gvConfirmedBookings"
                                        runat="server"
                                        AutoGenerateColumns="False"
                                        CssClass="table table-bordered table-striped"
                                        AllowPaging="True"
                                        PageSize="10"
                                        OnPageIndexChanging="gvConfirmedBookings_PageIndexChanging"
                                        DataKeyNames="BookingId"
                                        OnRowCommand="gvConfirmedBookings_RowCommand"
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

                                            <asp:BoundField DataField="CheckInDate" HeaderText="Check In"
                                                DataFormatString="{0:dd-MM-yyyy}" />
                                            <asp:BoundField DataField="CheckOutDate" HeaderText="Check Out"
                                                DataFormatString="{0:dd-MM-yyyy}" />
                                            <asp:BoundField DataField="PaymentStatus" HeaderText="Payment Status" />

                                            <asp:BoundField DataField="RemainingAmount" HeaderText="Remainign Amount" />

                                            <asp:TemplateField HeaderText="Actions">
                                                <ItemTemplate>

                                                    <asp:Button
                                                        ID="btnCheckIn"
                                                        runat="server"
                                                        Text="Check-In"
                                                        CssClass="btn btn-sm btn-success"
                                                        CommandName="CheckIn"
                                                        CommandArgument='<%# Eval("BookingId") %>' />

                                                    <asp:Button
                                                        ID="btnComplete"
                                                        runat="server"
                                                        Text="Complete"
                                                        CssClass="btn btn-sm btn-primary"
                                                        CommandName="Complete"
                                                        CommandArgument='<%# Eval("BookingId") %>' />

                                                    <asp:Button
                                                        ID="btnCancel"
                                                        runat="server"
                                                        Text="Cancel"
                                                        CssClass="btn btn-sm btn-danger"
                                                        CommandName="CancelBooking"
                                                        CommandArgument='<%# Eval("BookingId") %>' />
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                        </Columns>
                                    </asp:GridView>
                        <asp:Panel ID="pnlPaymentOverlay" runat="server" CssClass="overlay" Visible="false">
    <div class="popup-box">

        <h4>Collect Remaining Payment</h4>

        <asp:HiddenField ID="hfBookingId" runat="server" />

        <div class="mb-3">
            <label>Remaining Amount:</label>
            <asp:Label ID="lblRemaining" runat="server" CssClass="amount-text"></asp:Label>
        </div>

        <div class="mb-3">
            <label>Enter Amount</label>
            <asp:TextBox ID="txtCollectAmount" runat="server" CssClass="form-control"></asp:TextBox>
        </div>

        <div style="margin-top:15px;">
            <asp:Button ID="btnCollectPayment" runat="server"
                Text="Collect Payment"
                CssClass="btn btn-success"
                OnClick="btnCollectPayment_Click" />

            <asp:Button ID="btnClosePopup" runat="server"
                Text="Cancel"
                CssClass="btn btn-secondary"
                OnClick="btnClosePopup_Click" />
        </div>

    </div>
</asp:Panel>
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

