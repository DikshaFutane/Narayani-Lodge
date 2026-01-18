<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/Admin.Master" AutoEventWireup="true" CodeBehind="New_Bookings.aspx.cs" Inherits="NarayaniLodge.Admin.New_Bookings" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link rel="icon" href="assets/images/narayanilodgelogo.png" type="image/x-icon" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <!-- [ Main Content ] start -->
    <div class="pc-container">
        <div class="pc-content">
            <!-- [ breadcrumb ] start -->
            <div class="page-header">
                <div class="page-block">
                    <div class="page-header-title">
                        <h5 class="mb-0 font-medium">New Bookings</h5>
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
                            <h5>Enter and manage new booking details.</h5>
                        </div>
                        <div class="card-body">
                            <%--<h6>Guest Detail</h6>--%>
                            <div class="grid grid-cols-12 gap-6">

                                <!-- Guest Details -->
                                <div class="col-span-12">
                                    <h6 class="text-gray-700 font-semibold border-b pb-2">Guest Details
                                    </h6>
                                </div>

                                <!-- Full Name -->
                                <div class="col-span-12 md:col-span-6">
                                    <label class="form-label">Full Name <span class="text-red-500">*</span></label>
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="Required" ControlToValidate="txtGuestName" ForeColor="red"></asp:RequiredFieldValidator>
                                    <input type="text" class="form-control" id="txtGuestName" runat="server"
                                        placeholder="Enter full name" />
                                </div>

                                <!-- Phone -->
                                <div class="col-span-12 md:col-span-6">
                                    <label class="form-label">Phone Number <span class="text-red-500">*</span></label>
                                    <asp:RegularExpressionValidator runat="server" ControlToValidate="txtGuestPhone" ErrorMessage="Enter valid 10-digit phone number" ValidationExpression="^[6-9]\d{9}$" ForeColor="Red" />
                                    <input type="text" class="form-control" id="txtGuestPhone" runat="server"
                                        placeholder="Enter phone number" />

                                </div>

                                <!-- Email -->
                                <div class="col-span-12 md:col-span-6">
                                    <label class="form-label">Email</label>
                                    <input type="email" class="form-control" id="txtGuestEmail" runat="server"
                                        placeholder="Enter email address" />
                                </div>

                                <!-- Address -->
                                <div class="col-span-12 md:col-span-6">
                                    <label class="form-label">Address (Optional)</label>
                                    <input type="text" class="form-control" id="txtAddress" runat="server"
                                        placeholder="City / Address" />
                                </div>

                                <!-- Booking Details -->
                                <div class="col-span-12 mt-4">
                                    <h6 class="text-gray-700 font-semibold border-b pb-2">Booking Details
                                    </h6>
                                </div>

                                <!-- Room Type -->
                                <div class="col-span-12 md:col-span-6">
                                    <label class="form-label">Room Type <span class="text-red-500">*</span></label>
                                    <asp:DropDownList ID="ddlRoom" runat="server" CssClass="form-control" AutoPostBack="true" OnSelectedIndexChanged="ddlRoom_SelectedIndexChanged"></asp:DropDownList>

                                </div>

                                <!-- No of Rooms -->
                                <div class="col-span-12 md:col-span-6">
                                    <label class="form-label">No. of Rooms <span class="text-red-500">*</span></label>
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ErrorMessage="Required" ControlToValidate="rooms" ForeColor="red"></asp:RequiredFieldValidator>
                                    <input type="number" class="form-control" id="rooms" runat="server" min="1" />
                                </div>

                                <!-- Check-in -->
                                <div class="col-span-12 md:col-span-6">
                                    <label class="form-label">Check-In Date <span class="text-red-500">*</span></label>
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ErrorMessage="Required" ControlToValidate="txtCheckIn" ForeColor="red"></asp:RequiredFieldValidator>
                                    <input type="date" class="form-control" id="txtCheckIn" runat="server" />
                                </div>

                                <!-- Check-out -->
                                <div class="col-span-12 md:col-span-6">
                                    <label class="form-label">Check-Out Date <span class="text-red-500">*</span></label>
                                    <asp:CompareValidator runat="server" ControlToValidate="txtCheckOut" ControlToCompare="txtCheckIn" Operator="GreaterThan" Type="Date" ErrorMessage="Check-out date must be after check-in date" ForeColor="Red" />
                                    <input type="date" class="form-control" id="txtCheckOut" runat="server" />
                                </div>


                                <!-- Identity Details -->
                                <div class="col-span-12 mt-4">
                                    <h6 class="text-gray-700 font-semibold border-b pb-2">Identity Verification
                                    </h6>
                                </div>

                                <!-- ID Proof -->
                                <div class="col-span-12 md:col-span-6">
                                    <label class="form-label">ID Proof <span class="text-red-500">*</span></label>
                                    <asp:DropDownList ID="ddlIDProof" runat="server" CssClass="form-control">
                                        <asp:ListItem Text="Adhar" Value="Adhar" />
                                        <asp:ListItem Text="PAN" Value="PAN" />
                                        <asp:ListItem Text="Driving Licence" Value="Driving Licence" />
                                    </asp:DropDownList>
                                </div>

                                <!-- ID Proof Number -->
                                <div class="col-span-12 md:col-span-6">
                                    <label class="form-label">ID Proof Number <span class="text-red-500">*</span></label>
                                    <asp:RequiredFieldValidator runat="server" ControlToValidate="txtIDProofNo" ErrorMessage="Required" ForeColor="Red" />
                                    <input type="text" class="form-control" id="txtIDProofNo" runat="server" />
                                </div>


                                <!-- Payment Details -->
                                <div class="col-span-12 mt-4">
                                    <h6 class="text-gray-700 font-semibold border-b pb-2">Payment Details
                                    </h6>
                                </div>

                                <!-- Payment Mode -->
                                <div class="col-span-12 md:col-span-6">
                                    <label class="form-label">Payment Mode <span class="text-red-500">*</span></label>
                                    <asp:DropDownList ID="ddlPaymentMode" runat="server" CssClass="form-control">
                                        <asp:ListItem Text="Cash" Value="Cash" />
                                        <asp:ListItem Text="UPI" Value="UPI" />
                                        <asp:ListItem Text="Card" Value="Card" />
                                    </asp:DropDownList>
                                </div>

                                <div class="col-span-12 md:col-span-6">
                                    <label class="form-label">Payment Status <span class="text-red-500">*</span></label>
                                    <asp:DropDownList ID="ddlPaymentStatus" runat="server" CssClass="form-control">
                                        <asp:ListItem Text="Paid" Value="Paid" />
                                        <asp:ListItem Text="Pending" Value="Pending" />
                                        <asp:ListItem Text="Partial" Value="Partial" />
                                    </asp:DropDownList>
                                </div>

                                <!-- Total Amount -->
                                <div class="col-span-12 md:col-span-6">
                                    <label class="form-label">Total Amount</label>
                                    <input type="text" id="txtTotalAmount" runat="server" readonly class="bg-gray-100 cursor-not-allowed form-control" />
                                </div>

                            </div>

                            <div class="flex justify-center mt-6">
                                <asp:Button
                                    ID="btnSaveBooking"
                                    runat="server"
                                    Text="💾 Save Booking"
                                    CssClass="bg-blue-500 text-white px-6 py-2 text-base font-semibold rounded"
                                    OnClick="btnSaveBooking_Click" />

                                <asp:Button
                                    ID="cancel"
                                    runat="server"
                                    Text="Cancel"
                                    CssClass="bg-red-500 text-white px-6 py-2  text-base font-semibold rounded" 
                                    style="margin-left:5px;"
                                     />
                            </div>
                        </div>
                    </div>
                </div>


                <!-- [ sample-page ] end -->
            </div>
            <!-- [ Main Content ] end -->
        </div>
    </div>
    <!-- [ Main Content ] end -->
</asp:Content>
