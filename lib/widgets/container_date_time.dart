import 'package:cash_box/style/app_color.dart';
import 'package:cash_box/style/app_font.dart';
import 'package:flutter/material.dart';

class ContainerDateTime extends StatelessWidget {
  const ContainerDateTime({super.key, required this.value});
  final DateTime value;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: Colors.black),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Icon(Icons.calendar_today, color: AppColor.primaryColor),
          Text(
            value.toString().split(' ')[0],
            style: AppFont.normalTextStyle(context, AppFont.body, Colors.black),
          ),
        ],
      ),
    );
  }
}
