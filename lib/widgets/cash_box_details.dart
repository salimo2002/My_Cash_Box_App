import 'package:cash_box/style/app_color.dart';
import 'package:cash_box/style/app_font.dart';
import 'package:cash_box/widgets/custom_button.dart';
import 'package:cash_box/widgets/custom_drop_down.dart';
import 'package:cash_box/widgets/main_text_field.dart';
import 'package:flutter/material.dart';

class CashBoxDetails extends StatelessWidget {
  const CashBoxDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: AppColor.backGroundColor,
      title: Center(
        child: Text(
          'اضافة صندوق جديد',
          style: AppFont.boldTextStyle(context, AppFont.h2, Colors.black),
        ),
      ),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            MainTextField(
              controller: TextEditingController(),
              hintText: 'اسم الصندوق',
              focusNode: FocusNode(),
              validator: (value) {
                if (value == null || value == '') {
                  return 'الاسم مطلوب';
                }
                return null;
              },
            ),
            SizedBox(height: 16),
            MainTextField(
              controller: TextEditingController(),
              hintText: 'الرصيد البدئي',
              focusNode: FocusNode(),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 16),
            Directionality(
              textDirection: TextDirection.rtl,
              child: CustomDropDown(
                accounts: ['SYP', 'USD', 'AED', 'SAR', 'TRY', 'EGP', 'IQD'],
                hintText: 'العملة',
                onSelected: (value) {},
              ),
            ),
          ],
        ),
      ),
      actionsAlignment: MainAxisAlignment.spaceBetween,
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CustomButton(
              color: AppColor.backGroundColor,
              onTap: () {
                Navigator.pop(context);
              },
              title: 'رجوع',
              textColor: AppColor.primaryColor,
            ),
            CustomButton(
              color: AppColor.primaryColor,
              onTap: () {},
              title: 'اضافة',
              textColor: Colors.white,
            ),
          ],
        ),
      ],
    );
  }
}
