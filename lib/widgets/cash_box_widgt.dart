import 'package:cash_box/style/app_color.dart';
import 'package:cash_box/style/app_font.dart';
import 'package:flutter/material.dart';

class CashBoxWidgt extends StatelessWidget {
  const CashBoxWidgt({
    super.key,
    this.onTap,
    required this.title,
    required this.balance,
    this.onPressed,
    required this.cur,
  });
  final void Function()? onTap;
  final void Function()? onPressed;
  final String title;
  final String balance;
  final String cur;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 12, left: 12, top: 8),
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: ListTile(
          onTap: onTap,
          contentPadding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          tileColor: const Color.fromARGB(73, 144, 185, 255),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),
          leading: Icon(
            Icons.account_balance_wallet,
            color: AppColor.primaryColor,
            size: 30,
          ),
          title: Text(
            title,
            style: AppFont.boldTextStyle(
              context,
              AppFont.h3,
              AppColor.primaryColor,
            ),
          ),
          subtitle: Row(
            children: [
              Text(
                'الرصيد: ',
                style: AppFont.boldTextStyle(
                  context,
                  AppFont.body,
                  AppColor.primaryColor,
                ),
              ),
              Text(
                '${AppFont.formatMoney(double.parse(balance))} $cur',
                style: AppFont.boldTextStyle(
                  context,
                  AppFont.balance,
                  double.parse(balance) > 0
                      ? AppColor.positiveColor
                      : AppColor.negativeColor,
                ),
              ),
            ],
          ),
          trailing: IconButton(
            onPressed: onPressed,
            icon: Icon(Icons.delete_outline, color: AppColor.negativeColor),
          ),
        ),
      ),
    );
  }
}
