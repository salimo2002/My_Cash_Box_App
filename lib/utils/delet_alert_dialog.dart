import 'package:cash_box/style/app_color.dart';
import 'package:cash_box/style/app_font.dart';
import 'package:cash_box/widgets/custom_button.dart';
import 'package:flutter/material.dart';

class DeleteAlertDialog extends StatelessWidget {
  const DeleteAlertDialog({
    super.key,
    required this.onDelete,
    required this.title,
  });
  final void Function() onDelete;
  final String title;
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: AlertDialog(
        backgroundColor: AppColor.backGroundColor,
        title: Text(
          'تأكيد الحذف',
          style: AppFont.boldTextStyle(context, AppFont.h2, Colors.black),
        ),
        content: Text(
          title,
          style: AppFont.normalTextStyle(context, AppFont.body, Colors.black),
        ),
        actionsAlignment: MainAxisAlignment.spaceBetween,
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomButton(
                color: AppColor.primaryColor,
                onTap: onDelete,
                title: 'حذف',
                textColor: Colors.white,
              ),
              CustomButton(
                color: AppColor.backGroundColor,
                onTap: () {
                  Navigator.pop(context);
                },
                title: 'الغاء',
                textColor: AppColor.primaryColor,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
