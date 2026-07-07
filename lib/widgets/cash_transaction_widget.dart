import 'package:cash_box/style/app_color.dart';
import 'package:cash_box/style/app_font.dart';
import 'package:flutter/material.dart';

class CashTransactionWidget extends StatelessWidget {
  const CashTransactionWidget({
    super.key,
    required this.onDelete,
    required this.title,
    required this.dateTime,
    required this.amount,
    required this.isPayment,
    required this.cur,
    required this.account,
  });
  final void Function() onDelete;
  final String title;
  final String dateTime;
  final double amount;
  final bool isPayment;
  final String cur;
  final String account;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 12, left: 12, top: 8),
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
          decoration: BoxDecoration(
            color: AppColor.tileColor,
            borderRadius: BorderRadius.circular(18),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(
                isPayment ? Icons.arrow_upward : Icons.arrow_downward_sharp,
                color: isPayment
                    ? AppColor.paymentColor
                    : AppColor.receiveColor,
                size: 30,
              ),
              SizedBox(width: 5),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      maxLines: 3,
                      softWrap: true,
                      overflow: TextOverflow.ellipsis,
                      style: AppFont.boldTextStyle(
                        context,
                        AppFont.body,
                        AppColor.primaryColor,
                      ),
                    ),
                    SizedBox(height: 5),
                    Text(
                      dateTime,
                      textDirection: TextDirection.ltr,
                      style: AppFont.boldTextStyle(
                        context,
                        AppFont.balance,
                        AppColor.trColor,
                      ),
                    ),
                    SizedBox(height: 5),
                    Text(
                      account,
                      maxLines: 3,
                      softWrap: true,
                      overflow: TextOverflow.ellipsis,
                      style: AppFont.normalTextStyle(
                        context,
                        AppFont.body,
                        AppColor.primaryColor,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '${AppFont.formatMoney(amount).toString()} $cur',
                      style: AppFont.boldTextStyle(
                        context,
                        AppFont.body,
                        isPayment
                            ? AppColor.paymentColor
                            : AppColor.receiveColor,
                      ),
                    ),
                    IconButton(
                      onPressed: onDelete,
                      icon: Icon(Icons.delete_outline, color: Colors.red),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
