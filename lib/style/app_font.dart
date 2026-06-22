import 'package:cash_box/style/app_color.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart' show NumberFormat;

class AppFont {
  static double h1 = 24.0;
  static double h2 = 20.0;
  static double h3 = 18.0;
  static double body = 16.0;
  static double balance = 14.0;
  static double small = 12.0;
  static List<String> cur = ['SYP', 'USD', 'AED', 'SAR', 'TRY', 'EGP', 'IQD'];
  static TextStyle appNameStyle() {
    return TextStyle(
      color: AppColor.primaryColor,
      fontSize: 32,
      fontWeight: FontWeight.w800,
      letterSpacing: .5,
    );
  }

  static TextStyle boldTextStyle(
    BuildContext context,
    double size,
    Color color,
  ) {
    return TextStyle(
      fontSize: textResponsive(context, size),
      color: color,
      fontWeight: FontWeight.bold,
    );
  }

  static TextStyle normalTextStyle(
    BuildContext context,
    double size,
    Color color,
  ) {
    return TextStyle(fontSize: textResponsive(context, size), color: color);
  }

  static String formatMoney(num value) {
    return NumberFormat('#,##0').format(value);
  }

  static double textResponsive(BuildContext context, double size) {
    double width = MediaQuery.of(context).size.width;
    return width * (size / 375);
  }
}
