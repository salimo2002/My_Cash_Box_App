import 'package:cash_box/style/app_color.dart';
import 'package:flutter/material.dart';

class MainFloatingButton extends StatelessWidget {
  const MainFloatingButton({super.key, required this.onTap});
  final void Function() onTap;
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      backgroundColor: AppColor.primaryColor,
      onPressed: onTap,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadiusGeometry.circular(28),
      ),
      child: Icon(Icons.add, color: AppColor.backGroundColor),
    );
  }
}
