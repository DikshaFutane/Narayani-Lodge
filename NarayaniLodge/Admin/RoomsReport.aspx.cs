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

public partial class Admin_RoomsReport : System.Web.UI.Page
{
    string cs = ConfigurationManager.ConnectionStrings["Lodge"].ConnectionString;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            LoadRooms();
        }
    }

    private void LoadRooms(string roomType = "", string fromDate = "", string toDate = "")
    {
        using (SqlConnection con = new SqlConnection(cs))
        {
            string query = @"SELECT RoomID, RoomName, RoomCode, IsAvailable, Capacity, PricePerNight, 
                                    CreatedDate, UpdatedDate, IsDeleted, DeletedDate
                             FROM Rooms
                             WHERE 1=1";

            if (!string.IsNullOrEmpty(roomType))
                query += " AND RoomName LIKE @roomType";

            if (!string.IsNullOrEmpty(fromDate))
                query += " AND CreatedDate >= @fromDate";

            if (!string.IsNullOrEmpty(toDate))
                query += " AND CreatedDate <= @toDate";

            query += " ORDER BY CreatedDate DESC";

            using (SqlCommand cmd = new SqlCommand(query, con))
            {
                if (!string.IsNullOrEmpty(roomType))
                    cmd.Parameters.AddWithValue("@roomType", "%" + roomType + "%");

                if (!string.IsNullOrEmpty(fromDate))
                    cmd.Parameters.AddWithValue("@fromDate", fromDate);

                if (!string.IsNullOrEmpty(toDate))
                    cmd.Parameters.AddWithValue("@toDate", toDate);

                using (SqlDataAdapter da = new SqlDataAdapter(cmd))
                {
                    DataTable dt = new DataTable();
                    da.Fill(dt);
                    gvRooms.DataSource = dt;
                    gvRooms.DataBind();
                }
            }
        }
    }

    protected void btnFilter_Click(object sender, EventArgs e)
    {
        string roomType = ddlRoomType.SelectedValue;

        LoadRooms(roomType);
    }
    protected void btnExportPDF_Click(object sender, EventArgs e)
    {
        DataTable dt = new DataTable();
        using (SqlConnection con = new SqlConnection(cs))
        {
            string query = @"SELECT RoomName, RoomCode, IsAvailable, Capacity, PricePerNight
                             FROM Rooms
                             WHERE 1=1";

            if (!string.IsNullOrEmpty(ddlRoomType.SelectedValue))
                query += " AND RoomName LIKE @roomType";

            query += " ORDER BY RoomName ASC";

            using (SqlCommand cmd = new SqlCommand(query, con))
            {
                if (!string.IsNullOrEmpty(ddlRoomType.SelectedValue))
                    cmd.Parameters.AddWithValue("@roomType", "%" + ddlRoomType.SelectedValue + "%");

                using (SqlDataAdapter da = new SqlDataAdapter(cmd))
                {
                    da.Fill(dt);
                }
            }
        }

        // Create PDF
        Document pdfDoc = new Document(PageSize.A4, 15f, 15f, 40f, 20f);
        PdfWriter writer = PdfWriter.GetInstance(pdfDoc, Response.OutputStream);
        writer.PageEvent = new PDFThemeHelperRooms();
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
        string roomNameFilter = string.IsNullOrEmpty(ddlRoomType.SelectedValue) ? "" : ddlRoomType.SelectedValue;
        Paragraph reportTitle = new Paragraph($"Rooms Report {(roomNameFilter != "" ? "Filtered by Room Name: " + roomNameFilter : "")}",
                                             new Font(Font.FontFamily.HELVETICA, 13, Font.BOLD, themeColor));
        reportTitle.Alignment = Element.ALIGN_CENTER;
        reportTitle.SpacingAfter = 10f;
        pdfDoc.Add(reportTitle);

        // Table
        PdfPTable pdfTable = new PdfPTable(6); // RoomID + 5 columns
        pdfTable.WidthPercentage = 95;
        pdfTable.HorizontalAlignment = Element.ALIGN_CENTER;
        pdfTable.SpacingBefore = 5f;
        pdfTable.SpacingAfter = 5f;
        pdfTable.SetWidths(new float[] { 8f, 25f, 15f, 15f, 10f, 15f });

        string[] headers = { "Room ID", "Room Name", "Room Code", "Available", "Capacity", "Price/Night" };
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

        int roomIndex = 1; // Start Room ID from 1
        foreach (DataRow row in dt.Rows)
        {
            BaseColor rowColor = alternate ? rowColor1 : rowColor2;
            alternate = !alternate;

            pdfTable.AddCell(CreateCell(roomIndex.ToString(), rowColor));
            pdfTable.AddCell(CreateCell(row["RoomName"].ToString(), rowColor));
            pdfTable.AddCell(CreateCell(row["RoomCode"].ToString(), rowColor));

            // Display Available as Yes/No
            string availability = Convert.ToBoolean(row["IsAvailable"]) ? "Yes" : "No";
            pdfTable.AddCell(CreateCell(availability, rowColor));

            pdfTable.AddCell(CreateCell(row["Capacity"].ToString(), rowColor));
            pdfTable.AddCell(CreateCell(row["PricePerNight"].ToString(), rowColor));

            roomIndex++;
        }

        pdfDoc.Add(pdfTable);
        pdfDoc.Close();

        Response.ContentType = "application/pdf";
        Response.AddHeader("content-disposition", "attachment;filename=RoomsReport.pdf");
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

    public class PDFThemeHelperRooms : PdfPageEventHelper
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
        Response.AddHeader("content-disposition", "attachment;filename=RoomsReport.xls");
        Response.Charset = "";
        Response.ContentType = "application/vnd.ms-excel";
        using (StringWriter sw = new StringWriter())
        {
            HtmlTextWriter hw = new HtmlTextWriter(sw);
            gvRooms.RenderControl(hw);
            Response.Output.Write(sw.ToString());
            Response.Flush();
            Response.End();
        }
    }

    public override void VerifyRenderingInServerForm(Control control) { }

    protected void gvRooms_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        gvRooms.PageIndex = e.NewPageIndex;
        btnFilter_Click(sender, e);
    }
}