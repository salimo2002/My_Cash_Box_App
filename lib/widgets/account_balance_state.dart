

import 'package:cash_box/style/app_color.dart';
import 'package:cash_box/style/app_font.dart';
import 'package:flutter/material.dart';

class AccountBalanceeState extends StatelessWidget {
  const AccountBalanceeState({
    super.key,
    required this.balance,
  });

  final double balance;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 5),
      width: double.infinity,
      height: MediaQuery.of(context).size.height * 0.1,
      decoration: BoxDecoration(
        color: AppColor.primaryColor,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(18),
          bottomRight: Radius.circular(18),
        ),
      ),
      child: Column(
        children: [
          Text(
            'الرصيد الحالي',
            style: AppFont.boldTextStyle(
              context,
              AppFont.body,
              AppColor.secondaryColor,
            ),
          ),
          SizedBox(height: 10),
          Text(
            '${AppFont.formatMoney(balance)} SYP',
            style: AppFont.boldTextStyle(
              context,
              AppFont.h3,
              balance >= 0 ? AppColor.positiveColor : AppColor.negativeColor,
            ),
          ),
        ],
      ),
    );
  }
}
