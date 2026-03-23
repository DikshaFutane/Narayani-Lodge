<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/Admin.Master" AutoEventWireup="true" CodeFile="AdminProfile.aspx.cs" Inherits="Admin_AdminProfile" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link rel="icon" href="assets/images/narayanilodgelogo.png" type="image/x-icon" />
<link rel="stylesheet" href="assets/css/style.css" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

<div class="pc-container">
    <div class="pc-content">

        <div class="page-header mb-3">
            <h5 class="mb-0">Admin Profile</h5>
        </div>
        <div class="grid grid-cols-12 gap-x-6">
    <!-- [ sample-page ] start -->
    <div class="col-span-12">
        <div class="row">
        <!-- Profile Card -->
        <div class="card profile-card p-2">

            <asp:Image ID="imgProfile" runat="server"
                CssClass="profile-img"
                ImageUrl="~/Admin/assets/images/user/avatar-2.jpg" />

            <h4>
               <asp:Label ID="lblName" runat="server"></asp:Label>
            </h4>

            <div class="role">Super Admin</div>

            <div class="info">
                <asp:Label ID="lblEmail" runat="server"></asp:Label>
            </div>

            <div class="info">
               <asp:Label ID="lblPhone" runat="server"></asp:Label>
            </div>

            <div class="info">
                Status:
                <span class="status-active">Active</span>
            </div>

            <asp:Button ID="btnEditadmin"
                runat="server"
                Text="Edit Profile"
                CssClass="btnadmin" OnClick="btnUpdate_Click" />
        </div>

        <div class="card account-card">

            <h4>Account Information</h4>

            <div class="detail-row">
                <span class="label">Admin ID</span>
                <span class="value">
                   <asp:Label ID="lblAdminID" runat="server"></asp:Label>
                </span>
            </div>

            <div class="detail-row">
                <span class="label">Username</span>
                <span class="value">
                    <asp:Label ID="lblUsername" runat="server"></asp:Label>
                </span>
            </div>

            <div class="detail-row">
                <span class="label">Created On</span>
                <span class="value">
                    <asp:Label ID="lblCreated" runat="server"></asp:Label>
                </span>
            </div>

            <%--<div class="detail-row">
                <span class="label">Last Login</span>
                <span class="value">
                    <asp:Label ID="lblLastLogin" runat="server"></asp:Label>
                </span>
            </div>

            <div class="detail-row">
                <span class="label">Last Login IP</span>
                <span class="value">
                    <asp:Label ID="lblLastIP" runat="server"></asp:Label>
                </span>
            </div>--%>
            <div class="detail-row">
                <span class="label">Current Device</span>
                <span class="value">
                    <asp:Label ID="lblcurrentdevice" runat="server"></asp:Label>
                </span>
            </div>

            <div class="detail-row">
                <span class="label">Password Last Changed</span>
                <span class="value">
                    <asp:Label ID="lblPasswordChanged" runat="server"></asp:Label>
                </span>
            </div>

        </div>
    </div>

         

        </div>
            </div>
        </div>
    </div>
        
</asp:Content>