import 'package:cash_box/style/app_font.dart';
import 'package:flutter/material.dart';

class TransactionButton extends StatelessWidget {
  const TransactionButton({
    super.key,
    required this.iconCcolor,
    required this.iconData,
    required this.btnColor,
    required this.title,
    required this.titleColor,
    required this.onTap,
  });
  final Color iconCcolor;
  final IconData iconData;
  final Color btnColor;
  final String title;
  final Color titleColor;
  final void Function() onTap;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: btnColor,
        padding: EdgeInsets.symmetric(horizontal: 42, vertical: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadiusGeometry.circular(18),
        ),
      ),
      onPressed: onTap,
      child: Row(
        children: [
          Icon(iconData, color: iconCcolor),
          SizedBox(width: 5),
          Text(
            title,
            style: AppFont.boldTextStyle(context, AppFont.body, titleColor),
          ),
        ],
      ),
    );
  }
}
