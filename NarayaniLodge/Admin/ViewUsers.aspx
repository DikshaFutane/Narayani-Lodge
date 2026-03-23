<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/Admin.Master" AutoEventWireup="true" CodeFile="ViewUsers.aspx.cs" Inherits="Admin_ViewUsers" %>

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
                        <h5 class="mb-0 font-medium">All Users</h5>
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
                            <h5>Complete list of all Users.</h5>
                        </div>
                        <div class="card-body">
                            <div class="card table-card">

                                <div class="table-responsive">

                                    <asp:GridView
                                        ID="gvAllusers"
                                        runat="server"
                                        AutoGenerateColumns="False"
                                        CssClass="table table-bordered table-striped"
                                        AllowPaging="True"
                                        PageSize="10"
                                        OnPageIndexChanging="gvAllusers_PageIndexChanging1"
                                        DataKeyNames="UserID"
                                         OnRowDataBound="gvAllusers_RowDataBound"
                                        OnRowCommand="gvAllusers_RowCommand"
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
                                            <asp:BoundField DataField="Name" HeaderText="User Name" />
                                            <asp:BoundField DataField="Email" HeaderText="Email" />
                                            <asp:BoundField DataField="Phone" HeaderText="Phone No" />
                                            <asp:BoundField DataField="CreatedAt" HeaderText="Registered Date"
                                                DataFormatString="{0:dd-MM-yyyy}" />
                                            <asp:BoundField DataField="Status" HeaderText="Status" />
                                            <asp:TemplateField HeaderText="Actions">
                                                <ItemTemplate>
                                                    <asp:Button
                                                        ID="btnEdit"
                                                        runat="server"
                                                        Text="View"
                                                        CssClass="btn btn-sm btn-success"
                                                        CommandName="Viewuser"
                                                        CommandArgument='<%# Eval("UserID") %>' />
                                                    <asp:Button
                                                        ID="btnBlock"
                                                        runat="server"
                                                        Text="Block"
                                                        CssClass="btn btn-danger btn-sm"
                                                        CommandName="BlockUser"
                                                        CommandArgument='<%# Eval("UserID") %>'
                                                        OnClientClick="return confirm('Are you sure you want to Block the user?');" />
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

