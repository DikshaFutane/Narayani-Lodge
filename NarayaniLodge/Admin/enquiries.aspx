<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/Admin.Master" AutoEventWireup="true" CodeFile="enquiries.aspx.cs" Inherits="Admin_enquiries" %>

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
                        <h5 class="mb-0 font-medium">Enquiries</h5>
                    </div>
                </div>
            </div>
            <!-- [ breadcrumb ] end -->
            <div class="grid grid-cols-12 gap-x-6">
                <!-- [ sample-page ] start -->
                <div class="col-span-12">
                    <div class="card">
                        <div class="card-header">
                            <h5>Manage and respond to customer enquiry requests.</h5>
                        </div>
                        <div class="card-body">
                            <div style="overflow-x: auto; width: 100%;">
                                <asp:GridView ID="gvEnquiries" runat="server"
                                    AutoGenerateColumns="False"
                                    CssClass="table table-bordered table-striped w-100"
                                    GridLines="Both"
                                    DataKeyNames="EnquiryId"
                                    OnRowCommand="gvEnquiries_RowCommand"
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
                                        <asp:BoundField DataField="GuestName" HeaderText="Name" />
                                        <asp:BoundField DataField="GuestEmail" HeaderText="Email" />
                                        <asp:BoundField DataField="GuestPhone" HeaderText="Phone" />
                                        <asp:BoundField DataField="Message" HeaderText="Message" />
                                        <asp:BoundField DataField="EnquiryDate" HeaderText="Date"
                                            DataFormatString="{0:dd-MMM-yyyy}" />
                                        <asp:BoundField DataField="Status" HeaderText="Status" />

                                        <asp:TemplateField HeaderText="Action">
                                            <ItemTemplate>
                                                <asp:Button
                                                    ID="btnReply"
                                                    runat="server"
                                                    Text="Reply"
                                                    CssClass="btn btn-primary btn-sm"
                                                    CommandName="Reply"
                                                    CommandArgument='<%# Eval("EnquiryId") %>' />
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
</asp:Content>

