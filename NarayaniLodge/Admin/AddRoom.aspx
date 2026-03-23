<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/Admin.Master" AutoEventWireup="true" CodeFile="AddRoom.aspx.cs" Inherits="Admin_AddRoom" %>

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
                        <h5 class="mb-0 font-medium">Add Room</h5>
                    </div>
                </div>
            </div>
            <!-- [ breadcrumb ] end -->

            <div class="grid grid-cols-12 gap-x-6">
                <!-- [ sample-page ] start -->
                <div class="col-span-12">
                    <div class="card">
                        <div class="card-header">
                            <h5>Enter Room Details.</h5>
                        </div>
                        <div class="card-body">
                            <%--<h6>Guest Detail</h6>--%>
                            <div class="grid grid-cols-12 gap-6">

                                <div class="col-span-12 md:col-span-6">
                                    <label class="form-label">Room Number<span class="text-red-500">*</span></label>
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="Required" ControlToValidate="txtroomno" ForeColor="red"></asp:RequiredFieldValidator>
                                    <input type="number" class="form-control" id="txtroomno" runat="server"
                                        placeholder="Enter Room Name" />
                                </div>

                                <div class="col-span-12 md:col-span-6">
                                    <label class="form-label">Room Type<span class="text-red-500">*</span></label>
                                    <asp:RequiredFieldValidator ID="rfvRoomType" runat="server" ControlToValidate="ddlroom" InitialValue="" ErrorMessage="Select Room Type" ForeColor="Red" Display="Dynamic" />
                                    <asp:DropDownList ID="ddlroom" runat="server" CssClass="form-control">
                                        <asp:ListItem Text="-- Select Room Type --" Value="" />
                                        <asp:ListItem Text="AC Room" Value="AC" />
                                        <asp:ListItem Text="Non-AC Room" Value="NonAC" />
                                    </asp:DropDownList>
                                </div>

                                <div class="col-span-12 md:col-span-6">
                                    <label class="form-label">Price Per Night<span class="text-red-500">*</span></label>
                                    <asp:RequiredFieldValidator ID="rfvPrice" runat="server" ControlToValidate="price" ErrorMessage="Price Required" ForeColor="Red" Display="Dynamic" />
                                    <input type="number" class="form-control" id="price" runat="server" placeholder="Enter price" />
                                </div>

                                <div class="col-span-12 md:col-span-6">
                                    <label class="form-label">Capacity<span class="text-red-500">*</span></label>
                                    <asp:RequiredFieldValidator  ID="rfvCapacity"  runat="server" ControlToValidate="DropDownList1"  InitialValue="" ErrorMessage="Select Capacity" ForeColor="Red" Display="Dynamic" />
                                    <asp:DropDownList ID="DropDownList1" runat="server" CssClass="form-control">
                                        <asp:ListItem Text="-- Select Capacity --" Value="" />
                                        <asp:ListItem Text="1 Person" Value="1" />
                                        <asp:ListItem Text="2 Persons" Value="2" />
                                        <asp:ListItem Text="3 Persons" Value="3" />
                                    </asp:DropDownList>
                                </div>
                                <div class="col-span-12 md:col-span-12">
                                    <label class="form-label">Room Description<span class="text-red-500">*</span></label>
                                    <asp:RequiredFieldValidator  ID="rfvDesc" runat="server"  ControlToValidate="desc" ErrorMessage="Description Required" ForeColor="Red" Display="Dynamic" />                                    <input type="text" class="form-control" id="desc" runat="server"
                                        placeholder="Enter Description" />
                                </div>
                            </div>
                            <div class="flex justify-center mt-6">
                                <asp:Button
                                    ID="btnSaveBooking"
                                    runat="server"
                                    Text="💾 Save"
                                    CssClass="bg-blue-500 text-white px-6 py-2 text-base font-semibold rounded" 
                                    OnClick="btnSaveBooking_Click"/>

                                <asp:Button
                                    ID="cancel"
                                    runat="server"
                                    Text="Cancel"
                                    CssClass="bg-red-500 text-white px-6 py-2  text-base font-semibold rounded"
                                    Style="margin-left: 5px;" />
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

</asp:Content>

