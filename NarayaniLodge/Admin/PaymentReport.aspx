<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/Admin.Master" AutoEventWireup="true" CodeFile="PaymentReport.aspx.cs" Inherits="Admin_PaymentReport" %>

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
                        <h5 class="mb-0 font-medium">Payment Report</h5>
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
                            <h5>Payment Report Overview</h5>
                        </div>
                        <div class="card-body">
                            <div class="card table-card">
                                <div class="table-responsive">
                                    <div class="row mb-3">
                <div class="col-md-2">
                    <input type="date" id="txtFromDate" runat="server" class="form-control" placeholder="From Booking Date" />
                </div>
                <div class="col-md-2">
                    <input type="date" id="txtToDate" runat="server" class="form-control" placeholder="To Booking Date" />
                </div>
                <div class="col-md-2">
                    <input type="text" id="txtSearch" runat="server" class="form-control" placeholder="Guest Name, Email or Phone" />
                </div>
                <div class="col-md-2">
                    <asp:DropDownList ID="ddlPaymentStatus" runat="server" CssClass="form-control">
                        <asp:ListItem Text="Payment Status" Value="" />
                        <asp:ListItem Text="Paid" Value="Paid" />
                        <asp:ListItem Text="Pending" Value="Pending" />
                        <asp:ListItem Text="Partial" Value="Partial" />
                    </asp:DropDownList>
                </div>
                
                <div class="col-md-2">
                    <asp:Button ID="btnFilter" runat="server" Text="Filter" CssClass="btn btn-primary" OnClick="btnFilter_Click" />
                    <asp:Button ID="btnExportExcel" runat="server" Text="Export Excel" CssClass="btn btn-success ms-2" OnClick="btnExportExcel_Click" />
                    <asp:Button ID="btnExportPDF" runat="server" Text="Export PDF" CssClass="btn btn-danger ms-2" OnClick="btnExportPDF_Click" />
                </div>
            </div>

            <asp:GridView ID="gvPayments" runat="server" CssClass="table table-bordered table-striped"
                AutoGenerateColumns="false" EmptyDataText="No payments found" AllowPaging="true" PageSize="20"
                OnPageIndexChanging="gvPayments_PageIndexChanging">
                
                <Columns>
                    <asp:BoundField HeaderText="Booking ID" DataField="BookingId" />
                    <asp:BoundField HeaderText="Guest Name" DataField="GuestName" />
                    <asp:BoundField HeaderText="Email" DataField="GuestEmail" />
                    <asp:BoundField HeaderText="Phone" DataField="GuestPhone" />
                    <asp:BoundField HeaderText="Room Type" DataField="RoomType" />
                    <asp:BoundField HeaderText="No of Rooms" DataField="NoOfRooms" />
                    <asp:BoundField HeaderText="Booking Date" DataField="BookingDate" DataFormatString="{0:yyyy-MM-dd}" />
                    <asp:BoundField HeaderText="Check-In" DataField="CheckInDate" DataFormatString="{0:yyyy-MM-dd}" />
                    <asp:BoundField HeaderText="Check-Out" DataField="CheckOutDate" DataFormatString="{0:yyyy-MM-dd}" />
                    <asp:TemplateField HeaderText="Payment Mode">
                        <ItemTemplate>
                            <%# Eval("PaymentMode") %>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Payment Status">
                        <ItemTemplate>
                            <%# Eval("PaymentStatus") %>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Total Amount">
                        <ItemTemplate>
                            ₹ <%# Eval("TotalAmount") %>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Paid Amount">
                        <ItemTemplate>
                            ₹ <%# Eval("PaidAmount") %>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Remaining Amount">
                        <ItemTemplate>
                            ₹ <%# Eval("RemainingAmount") %>
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
        </div>
    </div>
</asp:Content>

