<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/Admin.Master" AutoEventWireup="true" CodeFile="ReplyEnquiry.aspx.cs" Inherits="Admin_ReplyEnquiry" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <!-- [ Main Content ] start -->
<div class="pc-container">
    <div class="pc-content">
        <!-- [ breadcrumb ] start -->
        <div class="page-header">
            <div class="page-block">
                <div class="page-header-title">
                    <h5 class="mb-0 font-medium">Reply to Enquiry</h5>
                </div>
            </div>
        </div>
        <!-- [ breadcrumb ] end -->
        <div class="grid grid-cols-12 gap-x-6">
            <!-- [ sample-page ] start -->
            <div class="col-span-12">

    <div class="card">
        <div class="card-body">
<%--    <h3>Reply to Enquiry</h3>--%>

    <label>Name</label>
    <asp:TextBox ID="txtName" runat="server" ReadOnly="true" CssClass="form-control" /><br />

    <label>Email</label>
    <asp:TextBox ID="txtEmail" runat="server" ReadOnly="true" CssClass="form-control" /><br />

    <label>Original Message</label>
    <asp:TextBox ID="txtMessage" runat="server" ReadOnly="true"
        TextMode="MultiLine" Rows="4" CssClass="form-control" /><br />

    <label>Reply Message</label>
    <asp:TextBox ID="txtReply" runat="server"
        TextMode="MultiLine" Rows="5" CssClass="form-control" />

    <br />

    <asp:Button ID="btnSendReply" runat="server"
        Text="Send Reply"
        CssClass="btn btn-primary"
       />

    <br /><br />

    <asp:Label ID="lblMsg" runat="server"></asp:Label>
</div>
        </div>
                </div>
            </div>
        </div>

    </div>
</asp:Content>

