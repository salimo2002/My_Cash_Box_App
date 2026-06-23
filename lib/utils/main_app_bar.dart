import 'package:cash_box/style/app_color.dart';
import 'package:cash_box/style/app_font.dart';
import 'package:flutter/material.dart';

AppBar mainAppBar(BuildContext context, String title) {
  return AppBar(
    iconTheme: IconThemeData(color: AppColor.backGroundColor),
    backgroundColor: AppColor.primaryColor,
    centerTitle: true,
    title: Text(
      title,
      style: AppFont.boldTextStyle(context, AppFont.h2, Colors.white),
    ),
  );
}
