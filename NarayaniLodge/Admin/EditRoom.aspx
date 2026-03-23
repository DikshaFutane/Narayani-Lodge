<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/Admin.Master" AutoEventWireup="true" CodeFile="EditRoom.aspx.cs" Inherits="Admin_EditRoom" %>

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
                        <h5 class="mb-0 font-medium">Update Room</h5>
                    </div>
                </div>
            </div>
            <!-- [ breadcrumb ] end -->

            <div class="grid grid-cols-12 gap-x-6">
                <!-- [ sample-page ] start -->
                <div class="col-span-12">
                    <div class="card">
                        <div class="card-header">
                            <h5>Update Room Details.</h5>
                        </div>
                        <div class="card-body">
                            <%--<h6>Guest Detail</h6>--%>
                            <div class="grid grid-cols-12 gap-6">
                                <div class="col-span-12 md:col-span-6">
                                    <label class="form-label">Room Number</label>
                                    <input type="number" class="form-control" id="txtroomno" runat="server" readonly/>
                                </div>
                                <div class="col-span-12 md:col-span-6">
                                    <label class="form-label">Room Name</label>
                                    <input type="text" class="form-control" id="txtroomnm" runat="server" readonly/>
                                </div>
                                <div class="col-span-12 md:col-span-6">
                                    <label class="form-label">Price Per Night</label>
                                    <input type="text" class="form-control" id="txtprice" runat="server"  />
                                </div>
                                <div class="col-span-12 md:col-span-6">
                                    <label class="form-label">Capacity</label>
                                    <input type="text" class="form-control" id="txtcapacity" runat="server" />
                                </div>
                                <div class="col-span-12 md:col-span-12">
                                    <label class="form-label">Description</label>
                                    <input type="text" class="form-control" id="txtdesc" runat="server"  />
                                </div>
                                <div class="col-span-12 md:col-span-6">
                                    <label class="form-label">Available : </label>
                                    <asp:CheckBox ID="chkIsAvailable" runat="server" Text="Room is Available" />
                                </div>
                                <div class="flex justify-center mt-6">
                                    <asp:Button
                                        ID="btnSaveBooking"
                                        runat="server"
                                        Text="Update"
                                        CssClass="bg-blue-500 text-white px-6 py-2 text-base font-semibold rounded"
                                         OnClick="btnSaveBooking_Click"/>

                                    <asp:Button
                                        ID="cancel"
                                        runat="server"
                                        Text="Cancel"
                                        CssClass="bg-red-500 text-white px-6 py-2  text-base font-semibold rounded"
                                        Style="margin-left: 5px;"
                                        OnClick="cancel_Click"/>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>

