<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/Admin.Master" AutoEventWireup="true" CodeFile="EnquiryReport.aspx.cs" Inherits="Admin_EnquiryReport" %>

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
                        <h5 class="mb-0 font-medium">Enquiry Report</h5>
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
                            <h5>User Enquiry Overview</h5>
                        </div>
                        <div class="card-body">
                            <div class="card table-card">
                                <div class="table-responsive">
                                    <div class="row mb-3">
                                    <div class="col-md-3">
                                        <input type="date" id="txtFromDate" runat="server" class="form-control" placeholder="From Enquiry Date" />
                                    </div>
                                    <div class="col-md-3">
                                        <input type="date" id="txtToDate" runat="server" class="form-control" placeholder="To Enquiry Date" />
                                    </div>
                                    <div class="col-md-3">
                                        <input type="text" id="txtSearch" runat="server" class="form-control" placeholder="Search Name, Email or Phone" />
                                    </div>
                                        <asp:Button ID="btnFilter" runat="server" Text="Filter" CssClass="btn btn-primary mt-2" OnClick="btnFilter_Click" />
                                        <asp:Button ID="btnExportExcel" runat="server" Text="Export Excel" CssClass="btn btn-success mt-2" OnClick="btnExportExcel_Click" />
                                        <asp:Button ID="btnExportPDF" runat="server" Text="Export PDF" CssClass="btn btn-danger ms-2" OnClick="btnExportPDF_Click" />
                                    </div>
                                
                                <asp:GridView ID="gvEnquiries" runat="server" CssClass="table table-bordered table-striped"
                                    AutoGenerateColumns="false" EmptyDataText="No enquiries found" AllowPaging="true" PageSize="20"
                                    OnPageIndexChanging="gvEnquiries_PageIndexChanging">

                                    <Columns>
                                        <asp:BoundField HeaderText="Enquiry ID" DataField="EnquiryId" />
                                        <asp:BoundField HeaderText="Guest Name" DataField="GuestName" />
                                        <asp:BoundField HeaderText="Email" DataField="GuestEmail" />
                                        <asp:BoundField HeaderText="Phone" DataField="GuestPhone" />
                                        <asp:BoundField HeaderText="Message" DataField="Message" />
                                        <asp:BoundField HeaderText="Enquiry Date" DataField="EnquiryDate" DataFormatString="{0:yyyy-MM-dd}" />
                                        <asp:BoundField HeaderText="Status" DataField="Status" />
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

