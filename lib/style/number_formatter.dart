import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class NumberFormatter extends TextInputFormatter {
  final NumberFormat formatter = NumberFormat('#,###');

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    if (newValue.text.isEmpty) {
      return newValue;
    }

    // إزالة الفواصل القديمة
    String newText = newValue.text.replaceAll(',', '');

    // التأكد من أن القيمة رقمية
    final number = int.tryParse(newText);
    if (number == null) {
      return oldValue;
    }

    // إضافة الفواصل
    final formattedText = formatter.format(number);

    return TextEditingValue(
      text: formattedText,
      selection: TextSelection.collapsed(
        offset: formattedText.length,
      ),
    );
  }
}