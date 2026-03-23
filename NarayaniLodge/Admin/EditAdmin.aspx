<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/Admin.Master" AutoEventWireup="true" CodeFile="EditAdmin.aspx.cs" Inherits="Admin_EditAdmin" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <link rel="icon" href="assets/images/narayanilodgelogo.png" type="image/x-icon" />
    <link rel="stylesheet" href="assets/css/style.css" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <div class="pc-container">
        <div class="pc-content">

            <div class="page-header mb-3">
                <h5>Edit Admin Profile</h5>
            </div>

            <div class="card p-4" style="max-width: 600px; margin: auto;">

                <div class="form-group mb-3">
                    <label>Full Name</label>
                    <asp:TextBox ID="txtName" runat="server" CssClass="form-control"></asp:TextBox>
                </div>

                <div class="form-group mb-3">
                    <label>Email</label>
                    <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control"></asp:TextBox>
                </div>

                <div class="form-group mb-3">
                    <label>Mobile Number</label>
                    <asp:TextBox ID="txtMobile" runat="server" CssClass="form-control"></asp:TextBox>
                </div>

                <div class="mt-3">

                    <asp:Button
                        ID="btnUpdate"
                        runat="server"
                        Text="Update Profile"
                        CssClass="btn btn-primary"
                        OnClick="btnUpdate_Click" />

                    &nbsp;


                    <asp:Button
                        ID="btnCancel"
                        runat="server"
                        Text="Cancel"
                        CssClass="btn btn-secondary"
                        PostBackUrl="AdminProfile.aspx" />

                </div>

            </div>

        </div>
    </div>
</asp:Content>

