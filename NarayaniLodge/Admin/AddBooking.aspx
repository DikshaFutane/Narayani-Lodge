<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/Admin.Master" AutoEventWireup="true" CodeFile="AddBooking.aspx.cs" Inherits="Admin_AddBooking" %>

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
                            <asp:ScriptManager ID="ScriptManager1" runat="server" />
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
                                    <label class="form-label">Email<span class="text-red-500">*</span></label>
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ErrorMessage="Required" ControlToValidate="txtGuestEmail" ForeColor="red"></asp:RequiredFieldValidator>
                                    <input type="email" class="form-control" id="txtGuestEmail" runat="server"
                                        placeholder="Enter email address" />
                                </div>

                                <!-- Address -->
                                <div class="col-span-12 md:col-span-6">
                                    <label class="form-label">Address (Optional)<span class="text-red-500">*</span></label>
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" ErrorMessage="Required" ControlToValidate="txtAddress" ForeColor="red"></asp:RequiredFieldValidator>
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
                                    <asp:DropDownList ID="ddlRoom" runat="server" CssClass="form-control" AutoPostBack="true" OnSelectedIndexChanged="ddlRoom_SelectedIndexChanged1"></asp:DropDownList>

                                </div>

                                <!-- No of Rooms -->
                                <div class="col-span-12 md:col-span-6">
                                    <label class="form-label">No. of Rooms <span class="text-red-500">*</span></label>
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ErrorMessage="Required" ControlToValidate="txtNumRooms" ForeColor="red"></asp:RequiredFieldValidator>
                                    <asp:TextBox ID="txtNumRooms" runat="server" CssClass="form-control" Text="1"
                                        AutoPostBack="true" OnTextChanged="txtNumRooms_TextChanged"></asp:TextBox>
                                </div>

                                <!-- Check-in -->
                                <div class="col-span-12 md:col-span-6">
                                    <label class="form-label">Check-In Date <span class="text-red-500">*</span></label>
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ErrorMessage="Required" ControlToValidate="CheckIn" ForeColor="red"></asp:RequiredFieldValidator>
                                    <asp:TextBox
                                        ID="CheckIn"
                                        runat="server"
                                        TextMode="Date"
                                        CssClass="form-control"
                                        AutoPostBack="true"
                                        OnTextChanged="CheckIn_TextChanged1"></asp:TextBox>
                                </div>

                                <!-- Check-out -->
                                <div class="col-span-12 md:col-span-6">
                                    <label class="form-label">Check-Out Date <span class="text-red-500">*</span></label>
                                    <asp:CompareValidator runat="server" ControlToValidate="Checkout" ControlToCompare="CheckIn" Operator="GreaterThan" Type="Date" ErrorMessage="Check-out date must be after check-in date" ForeColor="Red" />
                                    <asp:TextBox
                                        ID="Checkout"
                                        runat="server"
                                        TextMode="Date"
                                        CssClass="form-control"
                                        AutoPostBack="true"
                                        OnTextChanged="Checkout_TextChanged" />
                                </div>


                                <!-- Identity Details -->
                                <div class="col-span-12 mt-4">
                                    <h6 class="text-gray-700 font-semibold border-b pb-2">Identity Verification
                                    </h6>
                                </div>

                                <!-- ID Proof -->
                                <div class="col-span-12 md:col-span-6">
                                    <label class="form-label">
                                        ID Proof <span class="text-red-500">*</span>
                                    </label>
                                    <asp:RequiredFieldValidator
                                        ID="rfvIDProof"
                                        runat="server"
                                        ControlToValidate="ddlIDProof"
                                        InitialValue=""
                                        ErrorMessage="Please select ID Proof."
                                        ForeColor="Red"
                                        Display="Dynamic" />
                                    <asp:DropDownList
                                        ID="ddlIDProof"
                                        runat="server"
                                        CssClass="form-control">

                                        <asp:ListItem Text="-- Select ID Proof --" Value="" />
                                        <asp:ListItem Text="Aadhar Card" Value="Aadhar Card" />
                                        <asp:ListItem Text="PAN Card" Value="PAN Card" />
                                        <asp:ListItem Text="Driving Licence" Value="Driving Licence" />
                                        <asp:ListItem Text="Passport" Value="Passport" />
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
                                    <label class="form-label">
                                        Payment Mode <span class="text-red-500">*</span>
                                    </label>
                                    <asp:RequiredFieldValidator
                                        ID="rfvPaymentMode"
                                        runat="server"
                                        ControlToValidate="ddlPaymentMode"
                                        InitialValue=""
                                        ErrorMessage="Please select Payment Mode."
                                        ForeColor="Red"
                                        Display="Dynamic" />
                                    <asp:DropDownList
                                        ID="ddlPaymentMode"
                                        runat="server"
                                        CssClass="form-control">

                                        <asp:ListItem Text="-- Select Payment Mode --" Value="" />
                                        <asp:ListItem Text="Cash" Value="Cash" />
                                        <asp:ListItem Text="UPI" Value="UPI" />
                                    </asp:DropDownList>


                                </div>

                                <div class="col-span-12 md:col-span-6">
                                    <label class="form-label">
                                        Payment Status <span class="text-red-500">*</span>
                                    </label>

                                    <asp:DropDownList
                                        ID="ddlPaymentStatus"
                                        runat="server"
                                        CssClass="form-control"
                                        Enabled="false">

                                        <asp:ListItem Text="-- Auto Calculated --" Value="" />
                                        <asp:ListItem Text="Paid" Value="Paid" />
                                        <asp:ListItem Text="Pending" Value="Pending" />
                                        <asp:ListItem Text="Partial" Value="Partial" />
                                    </asp:DropDownList>
                                </div>
                                <!-- Total Amount -->
                                <div class="col-span-12 md:col-span-6">
                                    <label class="form-label">Total Amount</label>
                                    <asp:TextBox
                                        ID="txtTotalAmount"
                                        runat="server"
                                        CssClass="form-control bg-gray-100 cursor-not-allowed"
                                        ReadOnly="true">
                                    </asp:TextBox>

                                </div>
                                <div class="col-span-12 md:col-span-6">
                                    <label class="form-label">Paid Amount</label>
                                    <asp:TextBox
                                        ID="txtpaidAmount"
                                        runat="server"
                                        CssClass="form-control"
                                        TextMode="Number"
                                        AutoPostBack="true"
                                        OnTextChanged="txtpaidAmount_TextChanged1">
                                    </asp:TextBox>
                                </div>
                                <div class="col-span-12 md:col-span-6">
                                    <label class="form-label">Remaining Amount</label>
                                    <asp:TextBox
                                        ID="txtremainingAmount"
                                        runat="server"
                                        CssClass="form-control bg-gray-100 cursor-not-allowed"
                                        ReadOnly="true">
                                    </asp:TextBox>
                                </div>

                            </div>

                            <div class="flex justify-center mt-6">
                                <asp:Button
                                    ID="btnSaveBooking"
                                    runat="server"
                                    Text="💾 Save Booking"
                                    CssClass="bg-blue-500 text-white px-6 py-2 text-base font-semibold rounded"
                                    OnClick="btnSaveBooking_Click1" />

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
                <%--<div id="customToast" style="position: fixed; bottom: 20px; right: 20px; background: #28a745; color: white; padding: 15px 25px; border-radius: 8px; display: none; box-shadow: 0 5px 15px rgba(0,0,0,0.3); z-index: 9999;">
                    ✔ Booking Saved Successfully!
                </div>--%>

                <!-- [ sample-page ] end -->
            </div>
            <!-- [ Main Content ] end -->
        </div>
    </div>
    <!-- [ Main Content ] end -->
</asp:Content>

