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

public partial class Admin_EnquiryReport : System.Web.UI.Page
{
    string cs = ConfigurationManager.ConnectionStrings["Lodge"].ConnectionString;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            LoadEnquiries();
        }
    }

    private void LoadEnquiries(string search = "", string fromDate = "", string toDate = "", string status = "")
    {
        using (SqlConnection con = new SqlConnection(cs))
        {
            string query = @"SELECT EnquiryId, GuestName, GuestEmail, GuestPhone, Message, EnquiryDate, Status
                             FROM Enquiries
                             WHERE 1=1";

            if (!string.IsNullOrEmpty(search))
                query += " AND (GuestName LIKE @search OR GuestEmail LIKE @search OR GuestPhone LIKE @search)";

            if (!string.IsNullOrEmpty(fromDate))
                query += " AND EnquiryDate >= @fromDate";

            if (!string.IsNullOrEmpty(toDate))
                query += " AND EnquiryDate <= @toDate";

            if (!string.IsNullOrEmpty(status))
                query += " AND Status = @status";

            query += " ORDER BY EnquiryDate DESC";

            using (SqlCommand cmd = new SqlCommand(query, con))
            {
                if (!string.IsNullOrEmpty(search))
                    cmd.Parameters.AddWithValue("@search", "%" + search + "%");

                if (!string.IsNullOrEmpty(fromDate))
                    cmd.Parameters.AddWithValue("@fromDate", fromDate);

                if (!string.IsNullOrEmpty(toDate))
                    cmd.Parameters.AddWithValue("@toDate", toDate);

                if (!string.IsNullOrEmpty(status))
                    cmd.Parameters.AddWithValue("@status", status);

                using (SqlDataAdapter da = new SqlDataAdapter(cmd))
                {
                    DataTable dt = new DataTable();
                    da.Fill(dt);
                    gvEnquiries.DataSource = dt;
                    gvEnquiries.DataBind();
                }
            }
        }
    }

    protected void btnFilter_Click(object sender, EventArgs e)
    {
        string search = txtSearch.Value.Trim();
        string fromDate = txtFromDate.Value;
        string toDate = txtToDate.Value;
        //string status = ddlStatus.SelectedValue;

        LoadEnquiries(search, fromDate, toDate);
    }

    protected void btnExportPDF_Click(object sender, EventArgs e)
    {
        DataTable dt = new DataTable();
        using (SqlConnection con = new SqlConnection(cs))
        {
            string query = @"SELECT GuestName, GuestEmail, GuestPhone, Message, EnquiryDate, Status
                             FROM Enquiries
                             WHERE 1=1";

            if (!string.IsNullOrEmpty(txtSearch.Value.Trim()))
                query += " AND (GuestName LIKE @search OR GuestEmail LIKE @search OR GuestPhone LIKE @search)";

            query += " ORDER BY EnquiryDate DESC";

            using (SqlCommand cmd = new SqlCommand(query, con))
            {
                if (!string.IsNullOrEmpty(txtSearch.Value.Trim()))
                    cmd.Parameters.AddWithValue("@search", "%" + txtSearch.Value.Trim() + "%");

                using (SqlDataAdapter da = new SqlDataAdapter(cmd))
                {
                    da.Fill(dt);
                }
            }
        }

        // Create PDF
        Document pdfDoc = new Document(PageSize.A4, 15f, 15f, 40f, 20f);
        PdfWriter writer = PdfWriter.GetInstance(pdfDoc, Response.OutputStream);
        writer.PageEvent = new PDFThemeHelperEnquiry();
        pdfDoc.Open();

        BaseColor themeColor = new BaseColor(212, 163, 115); // #d4a373

        // Logo
        string logoPath = Server.MapPath("~/assets/images/narayanilodgelogo.png");
        if (System.IO.File.Exists(logoPath))
        {
            iTextSharp.text.Image logo = iTextSharp.text.Image.GetInstance(logoPath);
            logo.Alignment = Element.ALIGN_CENTER;
            logo.ScaleToFit(80f, 80f);
            logo.SpacingAfter = 5f;
            pdfDoc.Add(logo);
        }

        // Hotel Name
        Paragraph hotelName = new Paragraph("Narayani Lodge", new Font(Font.FontFamily.HELVETICA, 18, Font.BOLD, themeColor));
        hotelName.Alignment = Element.ALIGN_CENTER;
        hotelName.SpacingAfter = 3f;
        pdfDoc.Add(hotelName);

        // Contact Info
        Paragraph contact = new Paragraph("Tarabai Road, Tatakadil Talim Chowk, Kolhapur | Phone: (+91) 7218423323 | Email: narayanilodge7@gmail.com",
                                          new Font(Font.FontFamily.HELVETICA, 9, Font.NORMAL, BaseColor.DARK_GRAY));
        contact.Alignment = Element.ALIGN_CENTER;
        contact.SpacingAfter = 5f;
        pdfDoc.Add(contact);

        // Report Title
        string searchFilter = string.IsNullOrEmpty(txtSearch.Value.Trim()) ? "" : txtSearch.Value.Trim();
        Paragraph reportTitle = new Paragraph($"Enquiry Report {(searchFilter != "" ? "Filtered by: " + searchFilter : "")}",
                                             new Font(Font.FontFamily.HELVETICA, 13, Font.BOLD, themeColor));
        reportTitle.Alignment = Element.ALIGN_CENTER;
        reportTitle.SpacingAfter = 10f;
        pdfDoc.Add(reportTitle);

        // Table
        PdfPTable pdfTable = new PdfPTable(6); // Index + 6 columns
        pdfTable.WidthPercentage = 95;
        pdfTable.HorizontalAlignment = Element.ALIGN_CENTER;
        pdfTable.SpacingBefore = 5f;
        pdfTable.SpacingAfter = 5f;
        pdfTable.SetWidths(new float[] { 8f, 20f, 20f, 15f, 25f, 12f }); // Adjust widths

        string[] headers = { "S.No", "Guest Name", "Email", "Phone", "Message", "Status" };
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

        int index = 1;
        foreach (DataRow row in dt.Rows)
        {
            BaseColor rowColor = alternate ? rowColor1 : rowColor2;
            alternate = !alternate;

            pdfTable.AddCell(CreateCell(index.ToString(), rowColor));
            pdfTable.AddCell(CreateCell(row["GuestName"].ToString(), rowColor));
            pdfTable.AddCell(CreateCell(row["GuestEmail"].ToString(), rowColor));
            pdfTable.AddCell(CreateCell(row["GuestPhone"].ToString(), rowColor));
            pdfTable.AddCell(CreateCell(row["Message"].ToString(), rowColor));

            // Status color (optional: Pending=Red, Resolved=Green)
            BaseColor statusColor = row["Status"].ToString() == "Pending" ? BaseColor.RED : themeColor;
            pdfTable.AddCell(CreateCell(row["Status"].ToString(), rowColor, statusColor));

            index++;
        }

        pdfDoc.Add(pdfTable);
        pdfDoc.Close();

        Response.ContentType = "application/pdf";
        Response.AddHeader("content-disposition", "attachment;filename=EnquiryReport.pdf");
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

    public class PDFThemeHelperEnquiry : PdfPageEventHelper
    {
        public override void OnEndPage(PdfWriter writer, Document document)
        {
            PdfContentByte cb = writer.DirectContent;

            // Black Page Border
            BaseColor borderColor = BaseColor.BLACK;
            cb.SetLineWidth(2f);
            cb.SetColorStroke(borderColor);
            cb.Rectangle(10, 10, document.PageSize.Width - 20, document.PageSize.Height - 20);
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
        Response.AddHeader("content-disposition", "attachment;filename=EnquiryReport.xls");
        Response.Charset = "";
        Response.ContentType = "application/vnd.ms-excel";
        using (StringWriter sw = new StringWriter())
        {
            HtmlTextWriter hw = new HtmlTextWriter(sw);
            gvEnquiries.RenderControl(hw);
            Response.Output.Write(sw.ToString());
            Response.Flush();
            Response.End();
        }
    }

    public override void VerifyRenderingInServerForm(Control control) { }

    protected void gvEnquiries_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        gvEnquiries.PageIndex = e.NewPageIndex;
        btnFilter_Click(sender, e); // reload filtered data
    }
}