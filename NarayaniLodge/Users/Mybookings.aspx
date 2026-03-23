<%@ Page Title="MyBookings" Language="C#" MasterPageFile="~/Users/UserSite.master" AutoEventWireup="true" CodeFile="Mybookings.aspx.cs" Inherits="Users_Mybookings" %>

<asp:Content ID="Content2" ContentPlaceHolderID="head" runat="Server">
    <style>
        .badge {
            font-size: 14px;
            padding: 6px 10px;
            color: white;
        }
    </style>
    <link rel="icon" href="../img/narayanilodgelogo.png" type="image/x-icon" />
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
</asp:Content>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="container mt-4 mb-5">
        <div class="mt-5">

            <h4 class="mb-3">My Bookings</h4>
            <div class="table-responsive">

                <asp:GridView
                    ID="gvBookings"
                    runat="server"
                    CssClass="table table-bordered table-striped table-hover text-center"
                    AutoGenerateColumns="false"
                    DataKeyNames="BookingId"
                    OnRowCommand="gvAllBookings_RowCommand"
                    EmptyDataText="No bookings found. Start by booking a room!">

                    <Columns>

                        <asp:TemplateField HeaderText="Sr. No">
                            <ItemTemplate>
                                <%# Container.DataItemIndex + 1 %>
                            </ItemTemplate>
                        </asp:TemplateField>

                        <asp:BoundField DataField="RoomType" HeaderText="Room Type" />

                        <asp:BoundField DataField="CheckInDate" HeaderText="Check In" DataFormatString="{0:dd-MMM-yyyy}" />

                        <asp:BoundField DataField="CheckOutDate" HeaderText="Check Out" DataFormatString="{0:dd-MMM-yyyy}" />

                        <asp:TemplateField HeaderText="Status">
                            <ItemTemplate>

                                <span class='badge <%# 
Eval("BookingStatus").ToString()=="Confirmed" ? "bg-success" :
Eval("BookingStatus").ToString()=="Cancelled" ? "bg-danger" :
"bg-secondary" %>'>

                                    <%# Eval("BookingStatus") %>

                                </span>
                            </ItemTemplate>
                        </asp:TemplateField>

                        <asp:TemplateField HeaderText="Actions">
                            <ItemTemplate>
                                <asp:Button
                                    ID="btnView"
                                    runat="server"
                                    Text="View Details"
                                    CssClass="btn btn-sm btn-primary"
                                    CommandName="ViewBooking"
                                    CommandArgument='<%# Eval("BookingId") %>' />
                                <asp:Button
                                    ID="btnInvoice"
                                    runat="server"
                                    Text="Invoice"
                                    CssClass="btn btn-sm btn-success"
                                    CommandName="DownloadInvoice"
                                    CommandArgument='<%# Eval("BookingId") %>'
                                        Visible='<%# Eval("BookingStatus").ToString() == "Confirmed" %>'
/>
                                <asp:Button
                                    ID="btnCancel"
                                    runat="server"
                                    Text="Cancel"
                                    CssClass="btn btn-sm btn-danger"
                                    CommandName="CancelBooking"
                                    CommandArgument='<%# Eval("BookingId") %>'
                                    Visible='<%# Eval("BookingStatus").ToString() != "Cancelled" %>'
                                    OnClientClick="return confirm('Are you sure you want to cancel this booking?');" />
                            </ItemTemplate>
                        </asp:TemplateField>

                    </Columns>

                </asp:GridView>

            </div>
        </div>
    </div>


</asp:Content>

