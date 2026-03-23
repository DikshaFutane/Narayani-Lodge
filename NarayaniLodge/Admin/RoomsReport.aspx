<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/Admin.Master" AutoEventWireup="true" CodeFile="RoomsReport.aspx.cs" Inherits="Admin_RoomsReport" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
        <link rel="icon" href="assets/images/narayanilodgelogo.png" type="image/x-icon" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
     <!-- [ Main Content ] start -->
 <div class="pc-container">
     <div class="pc-content">
         <!-- [ breadcrumb ] start -->
         <div class="page-header">
             <div class="page-block">
                 <div class="page-header-title">
                     <h5 class="mb-0 font-medium">Rooms Report</h5>
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
                         <h5>Rooms Overview</h5>
                     </div>
                     <div class="card-body">
                         <div class="card table-card">

                             <div class="table-responsive">
                                  <div class="row mb-3">
                   <div class="col-md-2">
                    <asp:DropDownList ID="ddlRoomType" runat="server" CssClass="form-control">
                        <asp:ListItem Text="All Types" Value="" />
                        <asp:ListItem Text="AC" Value="AC" />
                        <asp:ListItem Text="Non-AC" Value="Non-AC" />
                    </asp:DropDownList>
                </div>
                <div class="col-md-3">
                    <asp:Button ID="btnFilter" runat="server" Text="Filter" CssClass="btn btn-primary" OnClick="btnFilter_Click" />
                    <asp:Button ID="btnExportExcel" runat="server" Text="Export Excel" CssClass="btn btn-success ms-2" OnClick="btnExportExcel_Click" />
                     <asp:Button ID="btnExportPDF" runat="server" Text="Export PDF" CssClass="btn btn-danger ms-2" OnClick="btnExportPDF_Click" />
                </div>
            </div>

           <asp:GridView ID="gvRooms" runat="server" CssClass="table table-bordered table-striped"
                AutoGenerateColumns="false" EmptyDataText="No rooms found" AllowPaging="true" PageSize="20"
                OnPageIndexChanging="gvRooms_PageIndexChanging">
                
                <Columns>
                    <asp:BoundField HeaderText="Room ID" DataField="RoomID" />
                    <asp:BoundField HeaderText="Room Name" DataField="RoomName" />
                    <asp:BoundField HeaderText="Room Code" DataField="RoomCode" />
                    <asp:TemplateField HeaderText="Availability">
                        <ItemTemplate>
                            <%# Convert.ToBoolean(Eval("IsAvailable")) ? "Available" : "Not Available" %>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:BoundField HeaderText="Capacity" DataField="Capacity" />
                    <asp:TemplateField HeaderText="Price / Night">
                        <ItemTemplate>
                            ₹ <%# Eval("PricePerNight") %>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:BoundField HeaderText="Created Date" DataField="CreatedDate" DataFormatString="{0:yyyy-MM-dd}" />
                    <asp:BoundField HeaderText="Updated Date" DataField="UpdatedDate" DataFormatString="{0:yyyy-MM-dd}" />
                    <asp:TemplateField HeaderText="Status">
                        <ItemTemplate>
                            <%# Convert.ToBoolean(Eval("IsDeleted")) ? "Deleted" : "Active" %>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:BoundField HeaderText="Deleted Date" DataField="DeletedDate" DataFormatString="{0:yyyy-MM-dd}" />
                </Columns>
            </asp:GridView>                      </div>
                             </div>
                         </div>
                     </div>
                 </div>
             </div>
         </div>
     </div>
    
</asp:Content>

