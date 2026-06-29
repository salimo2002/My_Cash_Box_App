import 'package:cash_box/style/app_color.dart';
import 'package:cash_box/style/app_font.dart';
import 'package:flutter/material.dart';

showSnackBar({required BuildContext context, required String title}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor: AppColor.primaryColor,
      duration: Duration(milliseconds: 750),
      content: Text(
        title,
        textAlign: TextAlign.right,
        style: AppFont.boldTextStyle(
          context,
          AppFont.balance,
          AppColor.backGroundColor,
        ),
      ),
    ),
  );
}
