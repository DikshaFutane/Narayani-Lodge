using iTextSharp.text;
using iTextSharp.text.pdf;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Drawing.Printing;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using QRCoder;

public partial class Users_Mybookings : System.Web.UI.Page
{
    string cs = ConfigurationManager.ConnectionStrings["Lodge"].ConnectionString;

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            LoadBookings();
        }
    }

    protected void gvAllBookings_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        if (e.CommandName == "ViewBooking")
        {
            int bookingId = Convert.ToInt32(e.CommandArgument);
            Response.Redirect("BookingDetails.aspx?id=" + bookingId);
        }

        if (e.CommandName == "DownloadInvoice")
        {
            int bookingId = Convert.ToInt32(e.CommandArgument);

            using (SqlConnection con = new SqlConnection(cs))
            {
                con.Open();

                SqlCommand cmd = new SqlCommand("SELECT * FROM Bookings WHERE BookingId=@id", con);
                cmd.Parameters.AddWithValue("@id", bookingId);
                SqlDataReader dr = cmd.ExecuteReader();

                if (dr.Read())
                {
                    Response.ContentType = "application/pdf";
                    Response.AddHeader("content-disposition", "attachment;filename=Invoice_" + bookingId + ".pdf");
                    Response.Cache.SetCacheability(HttpCacheability.NoCache);

                    Document pdfDoc = new Document(PageSize.A4, 40, 40, 40, 40);
                    PdfWriter writer = PdfWriter.GetInstance(pdfDoc, Response.OutputStream);

                    pdfDoc.Open();

                    // ================= COLORS & FONTS =================
                    BaseColor gold = new BaseColor(212, 175, 55);
                    Font titleFont = FontFactory.GetFont(FontFactory.HELVETICA_BOLD, 22, gold);
                    Font headerFont = FontFactory.GetFont(FontFactory.HELVETICA_BOLD, 12);
                    Font textFont = FontFactory.GetFont(FontFactory.HELVETICA, 11);

                    string invoiceNo = "INV-" + DateTime.Now.Year + "-" + bookingId.ToString().PadLeft(4, '0');

                    // ================= PAGE BORDER =================
                    PdfContentByte canvas = writer.DirectContent;
                    Rectangle rect = new Rectangle(pdfDoc.PageSize);
                    rect.Left += 10;
                    rect.Right -= 10;
                    rect.Top -= 10;
                    rect.Bottom += 10;
                    rect.BorderWidth = 2;
                    rect.BorderColor = BaseColor.BLACK;
                    rect.Border = Rectangle.BOX;
                    canvas.Rectangle(rect);

                    // ================= HOTEL NAME CENTER =================
                    Paragraph hotelName = new Paragraph("NARAYANI LODGE", titleFont);
                    hotelName.Alignment = Element.ALIGN_CENTER;
                    pdfDoc.Add(hotelName);

                    Paragraph hotelInfo = new Paragraph("Tarabai Road, Tatakadil Talim Chowk, Kolhapur\nPhone: +(+91) 7218423323 | Email: naratawadekark@gmail.com", textFont);
                    hotelInfo.Alignment = Element.ALIGN_CENTER;
                    pdfDoc.Add(hotelInfo);

                    pdfDoc.Add(new Paragraph("\n"));

                    // ================= INVOICE TITLE =================
                    // Create a font similar to H3 (bold, slightly larger)
                    Font h3Font = FontFactory.GetFont(FontFactory.HELVETICA_BOLD, 16, BaseColor.BLACK);

                    // Create paragraph with this font
                    Paragraph title = new Paragraph("INVOICE", h3Font);
                    title.Alignment = Element.ALIGN_CENTER;

                    // Add paragraph to PDF
                    pdfDoc.Add(title);
                    pdfDoc.Add(new Paragraph("\n")); // Add some spacing
                    // ================= INVOICE INFO =================
                    PdfPTable invoiceInfo = new PdfPTable(2);
                    invoiceInfo.WidthPercentage = 100;
                    invoiceInfo.AddCell("Invoice Number");
                    invoiceInfo.AddCell(invoiceNo);
                    invoiceInfo.AddCell("Booking ID");
                    invoiceInfo.AddCell(bookingId.ToString());
                    invoiceInfo.AddCell("Invoice Date");
                    invoiceInfo.AddCell(DateTime.Now.ToString("dd MMM yyyy"));
                    pdfDoc.Add(invoiceInfo);
                    pdfDoc.Add(new Paragraph("\n"));

                    // ================= GUEST DETAILS =================
                    Paragraph guestTitle = new Paragraph("Guest Details\n", headerFont);
                    pdfDoc.Add(guestTitle);

                    PdfPTable guest = new PdfPTable(2);
                    guest.WidthPercentage = 100;
                    guest.AddCell("Guest Name");
                    guest.AddCell(dr["GuestName"].ToString());
                    guest.AddCell("Guest Email");
                    guest.AddCell(dr["GuestEmail"].ToString());
                    guest.AddCell("Guest Phone");
                    guest.AddCell(dr["GuestPhone"].ToString());
                    guest.AddCell("Guest Address");
                    guest.AddCell(dr["GuestAddress"].ToString());
                    pdfDoc.Add(guest);
                    pdfDoc.Add(new Paragraph("\n"));

                    // ================= BOOKING DETAILS =================
                    Paragraph bookingTitle = new Paragraph("Booking Details\n", headerFont);
                    pdfDoc.Add(bookingTitle);

                    PdfPTable booking = new PdfPTable(2);
                    booking.WidthPercentage = 100;
                    booking.AddCell("Room Type");
                    booking.AddCell(dr["RoomType"].ToString());

                    DateTime checkin = Convert.ToDateTime(dr["CheckInDate"]);
                    DateTime checkout = Convert.ToDateTime(dr["CheckOutDate"]);
                    booking.AddCell("Check-In Date");
                    booking.AddCell(checkin.ToString("dd MMM yyyy"));
                    booking.AddCell("Check-Out Date");
                    booking.AddCell(checkout.ToString("dd MMM yyyy"));

                    int nights = (checkout - checkin).Days;
                    booking.AddCell("Total Nights");
                    booking.AddCell(nights.ToString());
                    booking.AddCell("Booking Status");
                    booking.AddCell(dr["BookingStatus"].ToString());
                    pdfDoc.Add(booking);
                    pdfDoc.Add(new Paragraph("\n"));

                    // ================= PRICE DETAILS =================
                    int pricePerNight = 2500;
                    int subtotal = nights * pricePerNight;
                    double gst = subtotal * 0.12;
                    double grandTotal = subtotal + gst;

                    PdfPTable charges = new PdfPTable(4);
                    charges.WidthPercentage = 100;

                    PdfPCell c1 = new PdfPCell(new Phrase("Description", headerFont)) { BackgroundColor = gold };
                    PdfPCell c2 = new PdfPCell(new Phrase("Qty", headerFont)) { BackgroundColor = gold };
                    PdfPCell c3 = new PdfPCell(new Phrase("Price", headerFont)) { BackgroundColor = gold };
                    PdfPCell c4 = new PdfPCell(new Phrase("Total", headerFont)) { BackgroundColor = gold };

                    charges.AddCell(c1);
                    charges.AddCell(c2);
                    charges.AddCell(c3);
                    charges.AddCell(c4);

                    charges.AddCell("Room Charge (per night)");
                    charges.AddCell(nights.ToString());
                    charges.AddCell("₹ " + pricePerNight);
                    charges.AddCell("₹ " + subtotal);

                    //charges.AddCell("GST (12%)");
                    //charges.AddCell("-");
                    //charges.AddCell("-");
                    //charges.AddCell("₹ " + gst);

                    //charges.AddCell("");
                    //charges.AddCell("");
                    //charges.AddCell("Grand Total");
                    //charges.AddCell("₹ " + grandTotal);

                    pdfDoc.Add(charges);
                    pdfDoc.Add(new Paragraph("\n"));

                    // ================= QR CODE =================
                    string verifyURL = "https://localhost:44300/VerifyBooking.aspx?id=" + bookingId;
                    QRCoder.QRCodeGenerator qrGenerator = new QRCoder.QRCodeGenerator();
                    QRCoder.QRCodeData qrCodeData = qrGenerator.CreateQrCode(verifyURL, QRCoder.QRCodeGenerator.ECCLevel.Q);
                    QRCoder.QRCode qrCode = new QRCoder.QRCode(qrCodeData);

                    System.Drawing.Bitmap qrCodeImage = qrCode.GetGraphic(20);
                    MemoryStream ms = new MemoryStream();
                    qrCodeImage.Save(ms, System.Drawing.Imaging.ImageFormat.Png);
                    iTextSharp.text.Image qrImage = iTextSharp.text.Image.GetInstance(ms.ToArray());
                    qrImage.ScaleToFit(120f, 120f);
                    qrImage.Alignment = Element.ALIGN_RIGHT;
                    pdfDoc.Add(qrImage);
                    pdfDoc.Add(new Paragraph("\n"));

                    // ================= FOOTER =================
                    Paragraph footer = new Paragraph(
                        "Thank you for choosing Narayani Lodge!\nWe hope you enjoyed your stay.\n\nAuthorized Signature\nNarayani Lodge",
                        textFont);
                    footer.Alignment = Element.ALIGN_CENTER;
                    pdfDoc.Add(footer);

                    pdfDoc.Close();
                    Response.End();
                }
            }
        }

        if (e.CommandName == "CancelBooking")
        {
            int bookingId = Convert.ToInt32(e.CommandArgument);

            using (SqlConnection con = new SqlConnection(cs))
            {
                con.Open();

                // Step 1: Get Check-In Date
                string getDateQuery = "SELECT CheckInDate FROM Bookings WHERE BookingId=@id";
                SqlCommand cmdDate = new SqlCommand(getDateQuery, con);
                cmdDate.Parameters.AddWithValue("@id", bookingId);

                DateTime checkInDate = Convert.ToDateTime(cmdDate.ExecuteScalar());
                DateTime currentTime = DateTime.Now;

                TimeSpan difference = checkInDate - currentTime;

                // Step 2: Check 6 hour condition
                if (difference.TotalHours < 6)
                {
                    ScriptManager.RegisterStartupScript(this, this.GetType(), "alert",
"Swal.fire({icon:'error',title:'Cancellation Failed',text:'Booking cannot be cancelled within 6 hours of check-in time.'});", true);
                    return;
                }

                // Step 3: Allow cancellation
                string cancelQuery = "UPDATE Bookings SET BookingStatus='Cancelled', CancellationDate=@date WHERE BookingId=@id";

                SqlCommand cmd = new SqlCommand(cancelQuery, con);
                cmd.Parameters.AddWithValue("@date", DateTime.Now);
                cmd.Parameters.AddWithValue("@id", bookingId);

                cmd.ExecuteNonQuery();
                con.Close();
            }

            LoadBookings();
            ScriptManager.RegisterStartupScript(this, this.GetType(), "alert",
"Swal.fire({icon:'success',title:'Cancelled!',text:'Booking cancelled successfully!'});", true);
        }
    }

    void LoadBookings()
    {
        if (Session["UserEmail"] == null)
            return;

        string email = Session["UserEmail"].ToString();

        using (SqlConnection con = new SqlConnection(cs))
        {
            string query = @"SELECT BookingId, RoomType, CheckInDate, CheckOutDate, BookingStatus
                         FROM Bookings
                         WHERE GuestEmail = @Email
                         ORDER BY BookingDate DESC";

            SqlCommand cmd = new SqlCommand(query, con);
            cmd.Parameters.AddWithValue("@Email", email);

            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();

            da.Fill(dt);

            gvBookings.DataSource = dt;
            gvBookings.DataBind();
        }
    }
}