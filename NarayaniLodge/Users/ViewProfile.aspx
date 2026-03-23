<%@ Page Title="Profile" Language="C#" MasterPageFile="~/Users/UserSite.master" AutoEventWireup="true" CodeFile="ViewProfile.aspx.cs" Inherits="Users_ViewProfile" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
        <link rel="icon" href="../img/narayanilodgelogo.png" type="image/x-icon" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <div class="container mt-4">
        <h2 class="text-center m-4">My Profile</h2>
        <asp:Panel ID="pnlProfile" runat="server" CssClass="card p-4 shadow-sm" Visible="false">

            <div class="form-group row">
                <label class="col-md-3 font-weight-bold">Full Name:</label>
                <div class="col-md-9">
                    <asp:Label ID="lblName" runat="server" Text=""></asp:Label>
                </div>
            </div>

            <div class="form-group row">
                <label class="col-md-3 font-weight-bold">Email:</label>
                <div class="col-md-9">
                    <asp:Label ID="lblEmail" runat="server" Text=""></asp:Label>
                </div>
            </div>

            <div class="form-group row">
                <label class="col-md-3 font-weight-bold">Phone:</label>
                <div class="col-md-9">
                    <asp:Label ID="lblPhone" runat="server" Text=""></asp:Label>
                </div>
            </div>

            <div class="text-center mt-3">
                <asp:Button ID="btnEditProfile" runat="server" Text="Edit Profile" CssClass="btn btn-primary" OnClick="btnEditProfile_Click" />
            </div>

        </asp:Panel>
            </div>
        <asp:Label ID="lblMessage" runat="server" ForeColor="Red"></asp:Label>
</asp:Content>

