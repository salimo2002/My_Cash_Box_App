import 'package:cash_box/style/app_color.dart';
import 'package:cash_box/style/app_font.dart';
import 'package:cash_box/utils/main_app_bar.dart';
import 'package:cash_box/widgets/custom_button.dart';
import 'package:flutter/material.dart';

class BackUpView extends StatelessWidget {
  const BackUpView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: mainAppBar(context, 'نسخة احتياطية'),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '${DateTime.now().year}-${DateTime.now().month}-${DateTime.now().day}:تاريخ النسخة',
              style: AppFont.boldTextStyle(context, AppFont.h3, Colors.black),
            ),
            const SizedBox(height: 10),
            SizedBox(
              width: 200,
              child: CustomButton(
                color: AppColor.primaryColor,
                textColor: AppColor.backGroundColor,
                title: 'حفظ',
                onTap: () {},
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'استيراد نسخة احتياطية',
              style: AppFont.boldTextStyle(context, AppFont.h3, Colors.black),
            ),
            const SizedBox(height: 10),
            SizedBox(
              width: 200,
              child: CustomButton(
                color: AppColor.primaryColor,
                textColor: AppColor.backGroundColor,
                title: 'استيراد',
                onTap: () {},
              ),
            ),
          ],
        ),
      ),
    );
  }
}
