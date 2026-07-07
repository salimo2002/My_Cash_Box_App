import 'package:cash_box/model/cash_box_with_balance.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

class PdfService {
  static Future<pw.Document> generateCashBoxPdf({
    required CashBoxWithBalance cashBox,
    required List<dynamic> transactions,
    required double initialBalance,
  }) async {
    final pdf = pw.Document();

    final font =
        await rootBundle.load("assets/fonts/NotoNaskhArabic-Regular.ttf");
    final ttf = pw.Font.ttf(font);

    /// ✅ نعتمد ترتيبك كما هو بدون أي تعديل
final sortedTransactions = List.from(transactions.reversed);
    double runningBalance = initialBalance;
    double totalPayment = 0;
    double totalReceipt = 0;

    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        margin: const pw.EdgeInsets.all(25),
        textDirection: pw.TextDirection.rtl,
        theme: pw.ThemeData.withFont(base: ttf),
        build: (context) => [

          /// ===== العنوان =====
          pw.Center(
            child: pw.Text(
              "كشف حساب صندوق",
              textAlign: pw.TextAlign.center,
              style: pw.TextStyle(
                font: ttf,
                fontSize: 18,
                fontWeight: pw.FontWeight.bold,
              ),
            ),
          ),
          pw.SizedBox(height: 6),
          pw.Center(
            child: pw.Text(
              cashBox.name,
              textAlign: pw.TextAlign.center,
              style: pw.TextStyle(
                font: ttf,
                fontSize: 14,
              ),
            ),
          ),
          pw.SizedBox(height: 25),

          /// ===== الجدول =====
          pw.Table(
            border: pw.TableBorder.all(
              color: PdfColors.grey700,
              width: 1,
            ),
            columnWidths: {
              0: const pw.FlexColumnWidth(2.2), // الرصيد
              1: const pw.FlexColumnWidth(1.6), // له
              2: const pw.FlexColumnWidth(1.6), // عليه
              3: const pw.FlexColumnWidth(2.2), // الحساب
              4: const pw.FlexColumnWidth(3.5), // التفاصيل
              5: const pw.FlexColumnWidth(1.4), // التاريخ
            },
            children: [

              /// ===== الهيدر =====
              pw.TableRow(
                decoration: const pw.BoxDecoration(
                  color: PdfColors.blue800,
                ),
                children: [
                  _header("الرصيد", ttf),
                  _header("له", ttf),
                  _header("عليه", ttf),
                  _header("الحساب", ttf),
                  _header("التفاصيل", ttf),
                  _header("التاريخ", ttf),
                ],
              ),

              /// ===== العمليات =====
              ...List.generate(sortedTransactions.length, (index) {
                final trx = sortedTransactions[index];

                double payment = 0;
                double receipt = 0;

                if (trx.type == 'receipt') {
                  receipt = trx.amount;
                  runningBalance += trx.amount;
                  totalReceipt += trx.amount;
                } else {
                  payment = trx.amount;
                  runningBalance -= trx.amount;
                  totalPayment += trx.amount;
                }

                final rowColor =
                    index.isEven ? PdfColors.white : PdfColors.grey100;

                final balanceBg = runningBalance >= 0
                    ? PdfColors.green100
                    : PdfColors.red100;

                return pw.TableRow(
                  decoration: pw.BoxDecoration(color: rowColor),
                  children: [
                    _balanceCell(
                      formatMoney(runningBalance),
                      ttf,
                      balanceBg,
                    ),
                    _numberCell(
                        receipt == 0 ? "" : formatMoney(receipt), ttf),
                    _numberCell(
                        payment == 0 ? "" : formatMoney(payment), ttf),
                    _textCell(trx.accountName ?? "", ttf),
                    _detailsCell(trx.description ?? "", ttf),
                    _numberCell(_formatDate(trx.date), ttf),
                  ],
                );
              }),

              /// ===== الإجمالي =====
              pw.TableRow(
                decoration: const pw.BoxDecoration(
                  color: PdfColors.grey300,
                ),
                children: [
                  _balanceCell(
                    formatMoney(runningBalance),
                    ttf,
                    runningBalance >= 0
                        ? PdfColors.green200
                        : PdfColors.red200,
                  ),
                  _numberCell(formatMoney(totalReceipt), ttf, bold: true),
                  _numberCell(formatMoney(totalPayment), ttf, bold: true),
                  _textCell("", ttf),
                  _textCell("", ttf),
                  _textCell("إجمالي العمليات", ttf, bold: true),
                ],
              ),
            ],
          ),
        ],
      ),
    );

    return pdf;
  }

  /// ===== عناصر مساعدة =====

  static pw.Widget _header(String text, pw.Font font) {
    return pw.Padding(
      padding: const pw.EdgeInsets.symmetric(vertical: 10),
      child: pw.Center(
        child: pw.Text(
          text,
          textAlign: pw.TextAlign.center, // ✅ توسيط النص
          style: pw.TextStyle(
            font: font,
            fontSize: 11,
            color: PdfColors.white,
            fontWeight: pw.FontWeight.bold,
          ),
        ),
      ),
    );
  }

  static pw.Widget _textCell(String text, pw.Font font,
      {bool bold = false}) {
    return pw.Padding(
      padding: const pw.EdgeInsets.all(6),
      child: pw.Center( // ✅ إضافة Center
        child: pw.Text(
          text,
          textAlign: pw.TextAlign.center, // ✅ توسيط النص
          style: pw.TextStyle(
            font: font,
            fontSize: 9,
            fontWeight:
                bold ? pw.FontWeight.bold : pw.FontWeight.normal,
          ),
        ),
      ),
    );
  }

  static pw.Widget _detailsCell(String text, pw.Font font) {
    return pw.Padding(
      padding: const pw.EdgeInsets.all(6),
      child: pw.Center( // ✅ إضافة Center
        child: pw.Text(
          text,
          textAlign: pw.TextAlign.center, // ✅ توسيط النص
          style: pw.TextStyle(
            font: font,
            fontSize: 9,
          ),
        ),
      ),
    );
  }

  static pw.Widget _numberCell(String text, pw.Font font,
      {bool bold = false}) {
    return pw.Padding(
      padding: const pw.EdgeInsets.all(6),
      child: pw.Center(
        child: pw.Text(
          text,
          textAlign: pw.TextAlign.center, // ✅ توسيط النص
          maxLines: 1,
          overflow: pw.TextOverflow.clip,
          style: pw.TextStyle(
            font: font,
            fontSize: 8.5,
            fontWeight:
                bold ? pw.FontWeight.bold : pw.FontWeight.normal,
          ),
        ),
      ),
    );
  }

  static pw.Widget _balanceCell(
      String text, pw.Font font, PdfColor bgColor) {
    return pw.Container(
      color: bgColor,
      padding: const pw.EdgeInsets.all(6),
      child: pw.Center(
        child: pw.Text(
          text,
          textAlign: pw.TextAlign.center, // ✅ توسيط النص
          maxLines: 1,
          overflow: pw.TextOverflow.clip,
          style: pw.TextStyle(
            font: font,
            fontSize: 9,
            fontWeight: pw.FontWeight.bold,
          ),
        ),
      ),
    );
  }

  static String _formatDate(String date) {
    try {
      final d = DateTime.parse(date);
      return "${d.year}-${d.month.toString().padLeft(2, '0')}-${d.day.toString().padLeft(2, '0')}";
    } catch (_) {
      return date;
    }
  }

  static String formatMoney(num value) {
    return NumberFormat('#,##0').format(value);
  }
}