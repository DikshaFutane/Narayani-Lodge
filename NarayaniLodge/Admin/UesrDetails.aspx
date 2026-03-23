<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/Admin.Master" AutoEventWireup="true" CodeFile="UesrDetails.aspx.cs" Inherits="Admin_UesrDetails" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <link rel="icon" href="assets/images/narayanilodgelogo.png" type="image/x-icon" />
    <link rel="stylesheet" href="assets/css/style.css" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="pc-container">
        <div class="pc-content">

            <div class="page-header">
                <div class="page-block">
                    <div class="page-header-title">
                        <h5 class="mb-0 font-medium">User Profile</h5>
                    </div>
                </div>
            </div>


            <div class="grid grid-cols-12 gap-x-6">

                <div class="col-span-12 md:col-span-6">

                    <div class="card">
                        <div class="card-body text-center">
                            <i class="ti ti-user" style="font-size: 80px; color: #6c757d;"></i>

                            <h4>
                                <asp:Label ID="lblName" runat="server"></asp:Label>
                            </h4>

                            <p style="color: gray;">
                                User ID :
                                <asp:Label ID="lblUserID" runat="server"></asp:Label>
                            </p>

                        </div>
                    </div>
                    <div class="card" style="margin-top: 10px;">

                        <div class="card-header">
                            <h5>User Booking History</h5>
                        </div>

                        <div class="card-body">
                            <div class="table-responsive" style="width: 100%; overflow-x: auto;">
                                <asp:GridView
                                    ID="gvUserBookings"
                                    runat="server"
                                    AutoGenerateColumns="False"
                                    CssClass="table table-bordered table-striped"
                                    EmptyDataText="No bookings found for this user."
                                    ShowHeaderWhenEmpty="True">

                                    <Columns>

                                        <asp:TemplateField HeaderText="Sr No">
                                            <ItemTemplate>
                                                <%# Container.DataItemIndex + 1 %>
                                            </ItemTemplate>
                                        </asp:TemplateField>

                                        <asp:BoundField DataField="BookingID" HeaderText="Booking ID" />

                                        <asp:BoundField DataField="RoomType" HeaderText="Room Type" />

                                        <asp:BoundField DataField="CheckInDate" HeaderText="Check In"
                                            DataFormatString="{0:dd-MM-yyyy}" />

                                        <asp:BoundField DataField="CheckOutDate" HeaderText="Check Out"
                                            DataFormatString="{0:dd-MM-yyyy}" />

                                        <asp:BoundField DataField="BookingStatus" HeaderText="Booking Status" />

                                    </Columns>

                                </asp:GridView>

                            </div>
                        </div>
                    </div>
                </div>


                <div class="col-span-12 md:col-span-6">

                    <div class="card">

                        <div class="card-header">
                            <h5>User Information</h5>
                        </div>

                        <div class="card-body">

                            <table class="table table-bordered">

                                <tr>
                                    <td><b>Email</b></td>
                                    <td>
                                        <asp:Label ID="lblEmail" runat="server"></asp:Label>
                                    </td>
                                </tr>

                                <tr>
                                    <td><b>Phone</b></td>
                                    <td>
                                        <asp:Label ID="lblPhone" runat="server"></asp:Label>
                                    </td>
                                </tr>

                                <tr>
                                    <td><b>Registered Date</b></td>
                                    <td>
                                        <asp:Label ID="lblDate" runat="server"></asp:Label>
                                    </td>
                                </tr>

                                <tr>
                                    <td><b>Status</b></td>
                                    <td>
                                        <asp:Label ID="lblStatus" runat="server"></asp:Label>
                                    </td>
                                </tr>

                            </table>

                            <br />

                            <asp:Button ID="btnBlock"
                                runat="server"
                                Text="Block User"
                                CssClass="btn btn-danger"
                                OnClick="btnBlock_Click" />

                            <asp:Button ID="btnUnblock"
                                runat="server"
                                Text="Unblock User"
                                CssClass="btn btn-success"
                                OnClick="btnUnblock_Click" />

                        </div>

                    </div>

                </div>

            </div>

        </div>
    </div>

</asp:Content>

