<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/Admin.Master" AutoEventWireup="true" CodeBehind="AllBookings.aspx.cs" Inherits="NarayaniLodge.Admin.AllBookings" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .page-header {
    margin-bottom: 20px;
}

.page-header h2 {
    font-weight: 600;
}

.table {
    background-color: #fff;
}

.btn {
    margin-right: 5px;
}

    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">  
  <!-- [ Main Content ] start -->
  <div class="pc-container">
    <div class="pc-content">
      <!-- [ breadcrumb ] start -->
      <div class="page-header">
        <div class="page-block">
          <div class="page-header-title">
            <h5 class="mb-0 font-medium">All Bookings</h5>
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
              <h5>Manage and track all hotel reservations</h5>
            </div>
            <div class="card-body">
                <asp:Label runat="server" Text="SERVER CONTROL OK" />
                <asp:GridView runat="server" BorderWidth="1" GridLines="Both" />

                <asp:Repeater runat="server">
    <HeaderTemplate>
        <h3>REPEATER HEADER VISIBLE</h3>
    </HeaderTemplate>
</asp:Repeater>

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
