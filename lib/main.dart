import 'package:cash_box/style/app_color.dart';
import 'package:cash_box/views/welcom_view.dart';
import 'package:flutter/material.dart';

void main(List<String> args) {
  runApp(CashBox());
}

class CashBox extends StatelessWidget {
  const CashBox({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(scaffoldBackgroundColor: AppColor.backGroundColor),
      debugShowCheckedModeBanner: false,
      home: WelcomView(),
    );
  }
}
