import 'package:cash_box/style/app_color.dart';
import 'package:cash_box/widgets/transaction_button.dart';
import 'package:flutter/material.dart';

class IsPaymentOrReceipt extends StatelessWidget {
  const IsPaymentOrReceipt({
    super.key,
    required this.isPayment,
    required this.onTap,
  });
  final bool isPayment;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        TransactionButton(
          iconCcolor: Colors.red,
          iconData: Icons.arrow_upward,
          btnColor: isPayment ? AppColor.primaryColor : AppColor.secondaryColor,
          title: 'صادر',
          titleColor: isPayment ? AppColor.backGroundColor : Colors.black,
          onTap: onTap,
        ),
        TransactionButton(
          iconCcolor: Colors.green,
          iconData: Icons.arrow_downward_sharp,
          btnColor: isPayment ? AppColor.secondaryColor : AppColor.primaryColor,
          title: 'وارد',
          titleColor: isPayment ? Colors.black : AppColor.backGroundColor,
          onTap: onTap,
        ),
      ],
    );
  }
}
