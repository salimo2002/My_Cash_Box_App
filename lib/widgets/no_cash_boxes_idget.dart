import 'package:cash_box/style/app_color.dart';
import 'package:cash_box/style/app_font.dart';
import 'package:flutter/material.dart';

class NoCashBoxesWidget extends StatelessWidget {
  const NoCashBoxesWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        spacing: 10,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'لا يوجد صناديق',
            style: AppFont.boldTextStyle(
              context,
              AppFont.h2,
              AppColor.primaryColor,
            ),
          ),
          Icon(Icons.account_balance_wallet, color: AppColor.primaryColor),
        ],
      ),
    );
  }
}
