<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/Admin.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="NarayaniLodge.Admin.Default" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
     <!-- [ Main Content ] start -->
    <div class="pc-container">
        <div class="pc-content">
            <div class="grid grid-cols-12 gap-x-6">
                <div class="col-span-12 xl:col-span-3 md:col-span-6">
                    <div class="card">
                        <div class="card-header !pb-0 !border-b-0">
                            <h5>Today's Booking's</h5>
                        </div>
                        <div class="card-body">
                            <div class="flex items-center justify-between gap-3 flex-wrap">
                                <h3 class="font-light flex items-center mb-0">
                                    <i class="feather icon-calendar text-success-500 text-[30px] mr-1.5"></i>
                                    <asp:Label ID="bookings" runat="server" Text="0"></asp:Label>
                                </h3>
                                <p class="mb-0">
                                    <asp:Label ID="progressPercent" runat="server" Text="0%"></asp:Label>
                                </p>
                            </div>
                            <div class="w-full bg-theme-bodybg rounded-lg h-1.5 mt-6 dark:bg-themedark-bodybg">
                                <div class="bg-theme-bg-1 h-full rounded-lg shadow-[0_10px_20px_0_rgba(0,0,0,0.3)]"
                                    id="progressBar"
                                    runat="server"
                                    role="progressbar"
                                    style="width: 0%">
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-span-12 xl:col-span-3 md:col-span-6">
                    <div class="card">
                        <div class="card-header !pb-0 !border-b-0">
                            <h5>Total Rooms</h5>
                        </div>
                        <div class="card-body">
                            <div class="flex items-center justify-between gap-3 flex-wrap">
                                <h3 class="font-light flex items-center mb-0">
                                    <i class="feather icon-grid text-danger-500 text-[30px] mr-1.5"></i>
                                    <asp:Label ID="lblRooms" runat="server" Text="0"></asp:Label>
                                </h3>
                                <%--<p class="mb-0">100%</p>--%>
                            </div>
                            <div class="w-full bg-theme-bodybg rounded-lg h-1.5 mt-6 dark:bg-themedark-bodybg">
                                <div class="bg-theme-bg-2 h-full rounded-lg shadow-[0_10px_20px_0_rgba(0,0,0,0.3)]" role="progressbar"
                                    style="width: 100%">
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-span-12 xl:col-span-3 md:col-span-6">
                    <div class="card">
                        <div class="card-header !pb-0 !border-b-0">
                            <h5>New Enquires</h5>
                        </div>
                        <div class="card-body">
                            <div class="flex items-center justify-between gap-3 flex-wrap">
                                <h3 class="font-light flex items-center mb-0">
                                    <i class="feather icon-message-square text-success-500 text-[30px] mr-1.5"></i>
                                    <asp:Label ID="lblenq" runat="server" Text="0"></asp:Label>
                                </h3>
                                <p class="mb-0">
                                    <asp:Label ID="enq" runat="server" Text="0%"></asp:Label>
                                </p>
                            </div>
                            <div class="w-full bg-theme-bodybg rounded-lg h-1.5 mt-6 dark:bg-themedark-bodybg">
                                <div class="bg-theme-bg-1 h-full rounded-lg shadow-[0_10px_20px_0_rgba(0,0,0,0.3)]"
                                    id="enqprogressBar" runat="server"
                                    role="progressbar"
                                    style="width: 0%">
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-span-12 xl:col-span-3 md:col-span-6">
                    <div class="card">
                        <div class="card-header !pb-0 !border-b-0">
                            <h5>Today's Revenue</h5>
                        </div>
                        <div class="card-body">
                            <div class="flex items-center justify-between gap-3 flex-wrap">
                                <h3 class="font-light flex items-center mb-0">
                                    <i class="feather icon-dollar-sign  text-success-500 text-[30px] mr-1.5"></i>
                                    <asp:Label ID="lblrevenue" runat="server" Text="0"></asp:Label>
                                </h3>
                                <p class="mb-0">
                                    <asp:Label ID="lblrev" runat="server" Text="0%"></asp:Label>
                                </p>
                            </div>
                            <div class="w-full bg-theme-bodybg rounded-lg h-1.5 mt-6 dark:bg-themedark-bodybg">
                                <div class="bg-theme-bg-1 h-full rounded-lg shadow-[0_10px_20px_0_rgba(0,0,0,0.3)]" role="progressbar" id="revenueBar" runat="server"
                                    style="width: 0%">
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            





            <div class="col-span-12 xl:col-span-8 md:col-span-6">
                <div class="card table-card">
                    <div class="card-header">
                        <h5>Today's Booking's</h5>
                    </div>
                    <div class="card-body">
                        <div class="table-responsive">
                            <table class="table table-hover">

                                <tbody>
                                    <tr class="unread">
                                        <td>
                                            <img class="rounded-full max-w-10" style="width: 40px" src="../assets/images/user/avatar-1.jpg" alt="activity-user" />
                                        </td>
                                        <td>
                                            <h6 class="mb-1">Isabella Christensen</h6>
                                            <p class="m-0">Lorem Ipsum is simply dummy text of…</p>
                                        </td>
                                        <td>
                                            <h6 class="text-muted">
                                                <i class="fas fa-circle text-success text-[10px] ltr:mr-4 rtl:ml-4"></i>
                                                11 MAY 12:56
                                            </h6>
                                        </td>
                                        <td>
                                            <a href="#!" class="badge bg-theme-bg-2 text-white text-[12px] mx-2">Reject</a>
                                            <a href="#!" class="badge bg-theme-bg-1 text-white text-[12px]">Approve</a>
                                        </td>
                                    </tr>
                                    <tr class="unread">
                                        <td>
                                            <img class="rounded-full max-w-10" style="width: 40px" src="../assets/images/user/avatar-2.jpg" alt="activity-user" />
                                        </td>
                                        <td>
                                            <h6 class="mb-1">Mathilde Andersen</h6>
                                            <p class="m-0">Lorem Ipsum is simply dummy text of…</p>
                                        </td>
                                        <td>
                                            <h6 class="text-muted">
                                                <i class="fas fa-circle text-danger text-[10px] ltr:mr-4 rtl:ml-4"></i>
                                                11 MAY 10:35
                                            </h6>
                                        </td>
                                        <td>
                                            <a href="#!" class="badge bg-theme-bg-2 text-white text-[12px] mx-2">Reject</a>
                                            <a href="#!" class="badge bg-theme-bg-1 text-white text-[12px]">Approve</a>
                                        </td>
                                    </tr>
                                    <tr class="unread">
                                        <td>
                                            <img class="rounded-full max-w-10" style="width: 40px" src="../assets/images/user/avatar-3.jpg" alt="activity-user" />
                                        </td>
                                        <td>
                                            <h6 class="mb-1">Karla Sorensen</h6>
                                            <p class="m-0">Lorem Ipsum is simply dummy text of…</p>
                                        </td>
                                        <td>
                                            <h6 class="text-muted">
                                                <i class="fas fa-circle text-success text-[10px] ltr:mr-4 rtl:ml-4"></i>
                                                9 MAY 17:38
                                            </h6>
                                        </td>
                                        <td>
                                            <a href="#!" class="badge bg-theme-bg-2 text-white text-[12px] mx-2">Reject</a>
                                            <a href="#!" class="badge bg-theme-bg-1 text-white text-[12px]">Approve</a>
                                        </td>
                                    </tr>
                                    <tr class="unread">
                                        <td>
                                            <img class="rounded-full max-w-10" style="width: 40px" src="../assets/images/user/avatar-1.jpg" alt="activity-user" />
                                        </td>
                                        <td>
                                            <h6 class="mb-1">Ida Jorgensen</h6>
                                            <p class="m-0">Lorem Ipsum is simply dummy text of…</p>
                                        </td>
                                        <td>
                                            <h6 class="text-muted f-w-300">
                                                <i class="fas fa-circle text-danger text-[10px] ltr:mr-4 rtl:ml-4"></i>
                                                19 MAY 12:56
                                            </h6>
                                        </td>
                                        <td>
                                            <a href="#!" class="badge bg-theme-bg-2 text-white text-[12px] mx-2">Reject</a>
                                            <a href="#!" class="badge bg-theme-bg-1 text-white text-[12px]">Approve</a>
                                        </td>
                                    </tr>
                                    <tr class="unread">
                                        <td>
                                            <img class="rounded-full max-w-10" style="width: 40px" src="../assets/images/user/avatar-2.jpg" alt="activity-user" />
                                        </td>
                                        <td>
                                            <h6 class="mb-1">Albert Andersen</h6>
                                            <p class="m-0">Lorem Ipsum is simply dummy text of…</p>
                                        </td>
                                        <td>
                                            <h6 class="text-muted">
                                                <i class="fas fa-circle text-success text-[10px] ltr:mr-4 rtl:ml-4"></i>
                                                21 July 12:56
                                            </h6>
                                        </td>
                                        <td>
                                            <a href="#!" class="badge bg-theme-bg-2 text-white text-[12px] mx-2">Reject</a>
                                            <a href="#!" class="badge bg-theme-bg-1 text-white text-[12px]">Approve</a>
                                        </td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
        </div>

    </div>
<!-- [ Main Content ] end -->


</asp:Content>
