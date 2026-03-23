<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/Admin.Master" AutoEventWireup="true" CodeFile="AllRooms.aspx.cs" Inherits="Admin_AllRooms" %>

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
                        <h5 class="mb-0 font-medium">All Rooms</h5>
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
                            <h5>Complete list of all rooms.</h5>
                        </div>
                        <div class="card-body">
                            <div class="card table-card">

                                <div class="table-responsive">

                                    <asp:GridView
                                        ID="gvAllrooms"
                                        runat="server"
                                        AutoGenerateColumns="False"
                                        CssClass="table table-bordered table-striped"
                                        AllowPaging="True"
                                        PageSize="10"
                                        OnPageIndexChanging="gvAllrooms_PageIndexChanging1"
                                        DataKeyNames="RoomID"
                                        OnRowCommand="gvAllrooms_RowCommand"
                                        OnRowDeleting="gvAllrooms_RowDeleting"
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
                                            <asp:BoundField DataField="RoomCode" HeaderText="Room Number" />
                                            <asp:BoundField DataField="RoomName" HeaderText="Room Type" />
                                            <asp:BoundField DataField="PricePerNight" HeaderText="Price Per Night" DataFormatString="₹ {0:N0}" HtmlEncode="false" />
                                            <asp:BoundField DataField="Capacity" HeaderText="Capacity" />
                                            <asp:TemplateField HeaderText="Status">
                                                <ItemTemplate>
                                                    <%# Convert.ToBoolean(Eval("IsAvailable")) 
        ? "<span style='color:green;font-weight:bold;'>Available</span>" 
        : "<span style='color:red;font-weight:bold;'>Not Available</span>" %>
                                                </ItemTemplate>
                                            </asp:TemplateField>

                                            <asp:TemplateField HeaderText="Actions">
                                                <ItemTemplate>
                                                    <asp:Button
                                                        ID="btnEdit"
                                                        runat="server"
                                                        Text="Edit"
                                                        CssClass="btn btn-sm btn-warning"
                                                        CommandName="EditRoom"
                                                        CommandArgument='<%# Eval("RoomID") %>' />

                                                    <asp:Button
                                                        ID="btnCancel"
                                                        runat="server"
                                                        Text="Delete"
                                                        CssClass="btn btn-sm btn-danger"
                                                        CommandName="Delete"
                                                        CommandArgument='<%# Eval("RoomID") %>'
                                                        OnClientClick="return confirm('Are you sure you want to delete room?');" />
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

    <!-- [ Main Content ] end -->
</asp:Content>

