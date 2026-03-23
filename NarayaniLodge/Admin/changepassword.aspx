<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/Admin.Master" AutoEventWireup="true" CodeFile="changepassword.aspx.cs" Inherits="Admin_changepassword" %>

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
                        <h5 class="mb-0 font-medium">Change Password</h5>
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
                            <h5>Change Password.</h5>
                        </div>
                        <div class="card-body">
                            <asp:Label ID="lblCurrent" runat="server" Text="Current Password"></asp:Label><br />
                            <asp:TextBox ID="txtCurrent" runat="server" TextMode="Password"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="rfvCurrent" runat="server" ControlToValidate="txtCurrent"
                                ErrorMessage="Current password is required!" ForeColor="Red" Display="Dynamic">*</asp:RequiredFieldValidator>
                            <br />
                            <br />

                            <asp:Label ID="lblNew" runat="server" Text="New Password"></asp:Label><br />
                            <asp:TextBox ID="txtNew" runat="server" TextMode="Password"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="rfvNew" runat="server" ControlToValidate="txtNew"
                                ErrorMessage="New password is required!" ForeColor="Red" Display="Dynamic">*</asp:RequiredFieldValidator>
                            <asp:RegularExpressionValidator ID="revNew" runat="server" ControlToValidate="txtNew"
                                ValidationExpression=".{6,}" ErrorMessage="Password must be at least 6 characters!" ForeColor="Red" Display="Dynamic">*</asp:RegularExpressionValidator>
                            <br />
                            <br />

                            <asp:Label ID="lblConfirm" runat="server" Text="Confirm Password"></asp:Label><br />
                            <asp:TextBox ID="txtConfirm" runat="server" TextMode="Password"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="rfvConfirm" runat="server" ControlToValidate="txtConfirm"
                                ErrorMessage="Confirm password is required!" ForeColor="Red" Display="Dynamic">*</asp:RequiredFieldValidator>
                            <asp:CompareValidator ID="cvPassword" runat="server" ControlToValidate="txtConfirm" ControlToCompare="txtNew"
                                ErrorMessage="Passwords do not match!" ForeColor="Red" Display="Dynamic">*</asp:CompareValidator>
                            <br />
                            <br />

                            <asp:Button ID="btnChange" runat="server" Text="Change Password" OnClick="btnChange_Click" />
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

</asp:Content>

