
import 'package:cash_box/style/app_color.dart';
import 'package:cash_box/style/app_font.dart';
import 'package:cash_box/utils/show_alert_dialog.dart';
import 'package:cash_box/utils/show_snack_bar.dart';
import 'package:flutter/material.dart';

class AccountWidget extends StatelessWidget {
  const AccountWidget({
    super.key,
    required this.accountName,
    required this.onDelete,
  });
  final String accountName;
  final VoidCallback onDelete;
  @override
  Widget build(BuildContext context) {
    double value = 2727832000;
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Padding(
        padding: const EdgeInsets.only(right: 12, left: 12, top: 8),
        child: ListTile(
          onLongPress: () {
            value = 0;
          },
          onTap: () {
            showSnackBar(
              context: context,
              title: AppFont.formatMoney(value).toString(),
            );
          },
          contentPadding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          tileColor: AppColor.tileColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),
          leading: Icon(
            Icons.account_circle,
            color: AppColor.primaryColor,
            size: 30,
          ),
          title: Text(
            accountName,
            style: AppFont.boldTextStyle(
              context,
              AppFont.h3,
              AppColor.primaryColor,
            ),
          ),
          subtitle: Text(
            'اضغط لرؤية المصاريف',
            style: AppFont.boldTextStyle(
              context,
              AppFont.small,
              AppColor.receiveColor,
            ),
          ),
          trailing: IconButton(
            onPressed: () {
              showAlertDialog(
                context: context,
                title:
                    'عند حذف الحساب سيتم حذف جميع الحركات المرتبطة به , هل انت متأكد؟',
                onDelete: onDelete,
              );
            },
            icon: Icon(Icons.delete_outline, color: AppColor.negativeColor),
          ),
        ),
      ),
    );
  }
}
