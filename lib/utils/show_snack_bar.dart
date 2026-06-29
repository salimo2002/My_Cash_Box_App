import 'package:cash_box/style/app_color.dart';
import 'package:cash_box/style/app_font.dart';
import 'package:flutter/material.dart';

showSnackBar({required BuildContext context, required String title}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor: AppColor.primaryColor,
      duration: Duration(seconds: 1),
      content: Text(
        title,
        textAlign: TextAlign.center,
        style: AppFont.boldTextStyle(
          context,
          AppFont.balance,
          AppColor.backGroundColor,
        ),
      ),
    ),
  );
}
