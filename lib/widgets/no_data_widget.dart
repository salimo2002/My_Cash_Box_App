import 'package:cash_box/style/app_color.dart';
import 'package:cash_box/style/app_font.dart';
import 'package:flutter/material.dart';

class NoDataWidget extends StatelessWidget {
  const NoDataWidget({super.key, required this.title, required this.icon});
  final String title;
  final IconData icon;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        spacing: 10,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title,
            style: AppFont.boldTextStyle(
              context,
              AppFont.h2,
              AppColor.primaryColor,
            ),
          ),
          Icon(icon, color: AppColor.primaryColor),
        ],
      ),
    );
  }
}
