import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:share_plus/share_plus.dart';

Future<void> sharePdfToWhatsApp({
  required pw.Document pdf,
  required String cashBoxName,
}) async {
  final dir = await getTemporaryDirectory();
  final sanitizedBoxName = cashBoxName.replaceAll(RegExp(r'[^\w\s\u0600-\u06FF]'), '_'); // حماية اسم الملف من الرموز الغريبة
  
  final file = File(
    '${dir.path}/${sanitizedBoxName}_${DateTime.now().year}_${DateTime.now().month}_${DateTime.now().day}.pdf',
  );

  await file.writeAsBytes(await pdf.save());

  await Share.shareXFiles([
    XFile(file.path),
  ], text: 'تقرير الصندوق: $cashBoxName');
}