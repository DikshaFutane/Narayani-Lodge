using iTextSharp.text;
using iTextSharp.text.pdf;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Admin_BookingReport : System.Web.UI.Page
{
    string cs = ConfigurationManager.ConnectionStrings["Lodge"].ConnectionString;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            LoadBookings();
        }
    }

    private void LoadBookings(string search = "", string fromDate = "", string toDate = "")
    {
        using (SqlConnection con = new SqlConnection(cs))
        {
            string query = "SELECT BookingID, GuestName, RoomType, CheckInDate, CheckOutDate, BookingDate, PaymentStatus FROM Bookings WHERE 1=1";

            if (!string.IsNullOrEmpty(search))
            {
                query += " AND (GuestName LIKE @search OR RoomType LIKE @search)";
            }

            if (!string.IsNullOrEmpty(fromDate))
            {
                query += " AND CheckInDate >= @fromDate";
            }

            if (!string.IsNullOrEmpty(toDate))
            {
                query += " AND CheckOutDate <= @toDate";
            }

            query += " ORDER BY BookingDate DESC";

            using (SqlCommand cmd = new SqlCommand(query, con))
            {
                if (!string.IsNullOrEmpty(search))
                    cmd.Parameters.AddWithValue("@search", "%" + search + "%");

                if (!string.IsNullOrEmpty(fromDate))
                    cmd.Parameters.AddWithValue("@fromDate", fromDate);

                if (!string.IsNullOrEmpty(toDate))
                    cmd.Parameters.AddWithValue("@toDate", toDate);

                using (SqlDataAdapter da = new SqlDataAdapter(cmd))
                {
                    DataTable dt = new DataTable();
                    da.Fill(dt);
                    gvBookings.DataSource = dt;
                    gvBookings.DataBind();
                }
            }
        }
    }

    protected void btnFilter_Click(object sender, EventArgs e)
    {
        string search = txtSearch.Value.Trim();
        string fromDate = txtFromDate.Value;
        string toDate = txtToDate.Value;

        LoadBookings(search, fromDate, toDate);
    }

    protected void btnExportPDF_Click(object sender, EventArgs e)
    {
        DataTable dt = new DataTable();
        using (SqlConnection con = new SqlConnection(cs))
        {
            string query = "SELECT BookingID, GuestName, RoomType, CheckInDate, CheckOutDate, BookingDate, PaymentStatus, RemainingAmount FROM Bookings WHERE 1=1";
            if (!string.IsNullOrEmpty(txtSearch.Value.Trim()))
                query += " AND (GuestName LIKE @search OR RoomType LIKE @search)";
            if (!string.IsNullOrEmpty(txtFromDate.Value))
                query += " AND CheckInDate >= @fromDate";
            if (!string.IsNullOrEmpty(txtToDate.Value))
                query += " AND CheckOutDate <= @toDate";
            query += " ORDER BY BookingDate DESC";

            using (SqlCommand cmd = new SqlCommand(query, con))
            {
                if (!string.IsNullOrEmpty(txtSearch.Value.Trim()))
                    cmd.Parameters.AddWithValue("@search", "%" + txtSearch.Value.Trim() + "%");
                if (!string.IsNullOrEmpty(txtFromDate.Value))
                    cmd.Parameters.AddWithValue("@fromDate", txtFromDate.Value);
                if (!string.IsNullOrEmpty(txtToDate.Value))
                    cmd.Parameters.AddWithValue("@toDate", txtToDate.Value);

                using (SqlDataAdapter da = new SqlDataAdapter(cmd))
                {
                    da.Fill(dt);
                }
            }
        }

        // Calculate totals
        int totalBookings = dt.Rows.Count;
        int totalPaid = 0;
        decimal totalPendingAmount = 0;
        foreach (DataRow row in dt.Rows)
        {
            if (row["PaymentStatus"].ToString() == "Paid") totalPaid++;
            if (row["PaymentStatus"].ToString() == "Pending")
                totalPendingAmount += Convert.ToDecimal(row["RemainingAmount"]);
        }

        // Create PDF
        Document pdfDoc = new Document(PageSize.A4, 15f, 15f, 40f, 20f);
        PdfWriter writer = PdfWriter.GetInstance(pdfDoc, Response.OutputStream);
        writer.PageEvent = new PDFThemeHelperD4A373();
        pdfDoc.Open();

        // Logo
        string logoPath = Server.MapPath("~/assets/images/narayanilodgelogo.png");
        if (File.Exists(logoPath))
        {
            iTextSharp.text.Image logo = iTextSharp.text.Image.GetInstance(logoPath);
            logo.Alignment = Element.ALIGN_CENTER;
            logo.ScaleToFit(80f, 80f);
            logo.SpacingAfter = 5f;
            pdfDoc.Add(logo);
        }

        BaseColor themeColor = new BaseColor(212, 163, 115); // #d4a373

        // Hotel Name
        Paragraph hotelName = new Paragraph("Narayani Lodge", new Font(Font.FontFamily.HELVETICA, 18, Font.BOLD, themeColor));
        hotelName.Alignment = Element.ALIGN_CENTER;
        hotelName.SpacingAfter = 3f;
        pdfDoc.Add(hotelName);

        // Contact
        Paragraph contact = new Paragraph("Tarabai Road, Tatakadil Talim Chowk, Kolhapur | Phone: (+91) 7218423323 | Email: narayanilodge7@gmail.com",
                                          new Font(Font.FontFamily.HELVETICA, 9, Font.NORMAL, BaseColor.DARK_GRAY));
        contact.Alignment = Element.ALIGN_CENTER;
        contact.SpacingAfter = 5f;
        pdfDoc.Add(contact);

        // Report Title
        string fromDateText = string.IsNullOrEmpty(txtFromDate.Value) ? "" : txtFromDate.Value;
        string toDateText = string.IsNullOrEmpty(txtToDate.Value) ? "" : txtToDate.Value;
        Paragraph reportTitle = new Paragraph($"Booking Report {(fromDateText != "" ? "From " + fromDateText + " To " + toDateText : "")}",
                                             new Font(Font.FontFamily.HELVETICA, 13, Font.BOLD, BaseColor.BLACK));
        reportTitle.Alignment = Element.ALIGN_CENTER;
        reportTitle.SpacingAfter = 10f;
        pdfDoc.Add(reportTitle);

        // Table
        PdfPTable pdfTable = new PdfPTable(dt.Columns.Count - 1); // remove RemainingAmount column
        pdfTable.WidthPercentage = 95;
        pdfTable.HorizontalAlignment = Element.ALIGN_CENTER;
        pdfTable.SpacingBefore = 5f;
        pdfTable.SpacingAfter = 5f;
        pdfTable.SetWidths(new float[] { 10f, 20f, 15f, 15f, 15f, 15f, 10f });

        string[] headers = { "Booking ID", "Guest Name", "Room Type", "Check-In", "Check-Out", "Booking Date", "Payment" };
        foreach (string header in headers)
        {
            PdfPCell cell = new PdfPCell(new Phrase(header, new Font(Font.FontFamily.HELVETICA, 10, Font.BOLD, BaseColor.WHITE)));
            cell.BackgroundColor = themeColor;
            cell.HorizontalAlignment = Element.ALIGN_CENTER;
            cell.Padding = 5f;
            pdfTable.AddCell(cell);
        }

        bool alternate = false;
        BaseColor rowColor1 = new BaseColor(255, 245, 230);
        BaseColor rowColor2 = BaseColor.WHITE;

        foreach (DataRow row in dt.Rows)
        {
            BaseColor rowColor = alternate ? rowColor1 : rowColor2;
            alternate = !alternate;

            pdfTable.AddCell(CreateCell(row["BookingID"].ToString(), rowColor));
            pdfTable.AddCell(CreateCell(row["GuestName"].ToString(), rowColor));
            pdfTable.AddCell(CreateCell(row["RoomType"].ToString(), rowColor));
            pdfTable.AddCell(CreateCell(Convert.ToDateTime(row["CheckInDate"]).ToString("yyyy-MM-dd"), rowColor));
            pdfTable.AddCell(CreateCell(Convert.ToDateTime(row["CheckOutDate"]).ToString("yyyy-MM-dd"), rowColor));
            pdfTable.AddCell(CreateCell(Convert.ToDateTime(row["BookingDate"]).ToString("yyyy-MM-dd"), rowColor));
            BaseColor paymentColor = row["PaymentStatus"].ToString() == "Pending" ? BaseColor.RED : BaseColor.BLACK;
            pdfTable.AddCell(CreateCell(row["PaymentStatus"].ToString(), rowColor, paymentColor));
        }

        // Summary Row
        PdfPCell summaryCell = new PdfPCell(new Phrase($"Total Bookings: {totalBookings} | Paid: {totalPaid} | Pending Amount: ₹{totalPendingAmount}",
                                        new Font(Font.FontFamily.HELVETICA, 10, Font.BOLD, BaseColor.BLACK)));
        summaryCell.Colspan = dt.Columns.Count - 1;
        summaryCell.HorizontalAlignment = Element.ALIGN_CENTER;
        summaryCell.BackgroundColor = new BaseColor(245, 245, 220); // light beige
        summaryCell.Padding = 6f;
        pdfTable.AddCell(summaryCell);

        pdfDoc.Add(pdfTable);
        pdfDoc.Close();

        Response.ContentType = "application/pdf";
        Response.AddHeader("content-disposition", "attachment;filename=BookingReport.pdf");
        Response.Flush();
        Response.End();
    }

    private PdfPCell CreateCell(string text, BaseColor bgColor, BaseColor textColor = null)
    {
        if (textColor == null) textColor = BaseColor.BLACK;
        PdfPCell cell = new PdfPCell(new Phrase(text, new Font(Font.FontFamily.HELVETICA, 10, Font.NORMAL, textColor)));
        cell.BackgroundColor = bgColor;
        cell.HorizontalAlignment = Element.ALIGN_CENTER;
        cell.Padding = 5f;
        return cell;
    }

    public class PDFThemeHelperD4A373 : PdfPageEventHelper
    {
        public override void OnEndPage(PdfWriter writer, Document document)
        {
            PdfContentByte cb = writer.DirectContent;

            // Border
            BaseColor borderColor = BaseColor.BLACK; // Changed from themeColor to black
            cb.SetLineWidth(2f);
            cb.SetColorStroke(borderColor);
            cb.Rectangle(10, 10,
                         document.PageSize.Width - 20,
                         document.PageSize.Height - 20);
            cb.Stroke();

            // Footer
            string footer = $"Page {writer.PageNumber} | Generated on: {DateTime.Now:yyyy-MM-dd}";
            ColumnText.ShowTextAligned(cb, Element.ALIGN_CENTER,
                                       new Phrase(footer, new Font(Font.FontFamily.HELVETICA, 8, Font.ITALIC, BaseColor.DARK_GRAY)),
                                       document.PageSize.Width / 2, 15, 0);
        }
    }

    protected void btnExportExcel_Click(object sender, EventArgs e)
    {
        Response.Clear();
        Response.Buffer = true;
        Response.AddHeader("content-disposition", "attachment;filename=BookingsReport.xls");
        Response.Charset = "";
        Response.ContentType = "application/vnd.ms-excel";
        using (StringWriter sw = new StringWriter())
        {
            HtmlTextWriter hw = new HtmlTextWriter(sw);
            gvBookings.RenderControl(hw);
            Response.Output.Write(sw.ToString());
            Response.Flush();
            Response.End();
        }
    }

    public override void VerifyRenderingInServerForm(Control control)
    {
        // Required for exporting GridView to Excel
    }
}