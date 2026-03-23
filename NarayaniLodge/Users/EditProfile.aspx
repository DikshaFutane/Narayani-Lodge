<%@ Page Title="Edit Profile" Language="C#" MasterPageFile="~/Users/UserSite.master" AutoEventWireup="true" CodeFile="EditProfile.aspx.cs" Inherits="Users_EditProfile" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
            <link rel="icon" href="../img/narayanilodgelogo.png" type="image/x-icon" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <div class="container mt-4">
        <h2 class="text-center mb-4">Edit Profile</h2>

        <asp:Panel ID="pnlEdit" runat="server" CssClass="card p-4 shadow-sm" Visible="false">

            <div class="form-group">
                <label>Full Name:</label>
                <asp:TextBox ID="txtFullName" runat="server" CssClass="form-control"></asp:TextBox>
            </div>

            <div class="form-group">
                <label>Email:</label>
                <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control" ReadOnly="true"></asp:TextBox>
            </div>

            <div class="form-group">
                <label>Phone:</label>
                <asp:TextBox ID="txtPhone" runat="server" CssClass="form-control"></asp:TextBox>
            </div>

<%--            <div class="form-group">
                <label>Address:</label>
                <asp:TextBox ID="txtAddress" runat="server" CssClass="form-control" TextMode="MultiLine" Rows="3"></asp:TextBox>
            </div>--%>

            <div class="text-center mt-3">
                <asp:Button ID="btnUpdate" runat="server" Text="Update Profile" CssClass="btn btn-success" OnClick="btnUpdate_Click" />
                <asp:Button ID="btnCancel" runat="server" Text="Cancel" CssClass="btn btn-secondary ml-2" OnClick="btnCancel_Click" />
            </div>

        </asp:Panel>

        <asp:Label ID="lblMessage" runat="server" ForeColor="Red" CssClass="mt-2"></asp:Label>
    </div>
</asp:Content>

