

import 'package:cash_box/style/app_font.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.color,
    required this.onTap,
    required this.title,
    required this.textColor,
  });
  final Color color;
  final Color textColor;
  final void Function() onTap;
  final String title;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      ),
      onPressed: onTap,
      child: Text(
        title,
        style: AppFont.boldTextStyle(context, AppFont.body, textColor),
      ),
    );
  }
}
