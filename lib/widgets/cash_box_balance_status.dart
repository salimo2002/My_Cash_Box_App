import 'package:cash_box/style/app_color.dart';
import 'package:cash_box/style/app_font.dart';
import 'package:flutter/material.dart';

class CashBoxBalanceStatus extends StatelessWidget {
  const CashBoxBalanceStatus({
    super.key,
    required this.balance,
    required this.transLen,
    required this.onPressed,
    required this.search,
    required this.searchFocus,
    this.onChanged,
    required this.initialBalance,
  });
  final double balance;
  final double initialBalance;
  final int transLen;
  final void Function() onPressed;
  final TextEditingController search;
  final FocusNode searchFocus;
  final Function(String)? onChanged;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 5),
      width: double.infinity,
      height: MediaQuery.of(context).size.height * 0.24,
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
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                children: [
                  Text(
                    'الحركات',
                    style: AppFont.boldTextStyle(
                      context,
                      AppFont.body,
                      AppColor.secondaryColor,
                    ),
                  ),
                  Text(
                    transLen.toString(),
                    style: AppFont.boldTextStyle(
                      context,
                      AppFont.body,
                      AppColor.backGroundColor,
                    ),
                  ),
                ],
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                width: .5,
                height: 40,
                color: AppColor.secondaryColor,
              ),
              Column(
                children: [
                  Text(
                    'الرصيد البدئي',
                    style: AppFont.boldTextStyle(
                      context,
                      AppFont.body,
                      AppColor.secondaryColor,
                    ),
                  ),
                  Text(
                    AppFont.formatMoney(initialBalance).toString(),
                    style: AppFont.boldTextStyle(
                      context,
                      AppFont.body,
                      AppColor.backGroundColor,
                    ),
                  ),
                ],
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                width: .5,
                height: 40,
                color: AppColor.secondaryColor,
              ),
              TextButton(
                style: ButtonStyle(
                  backgroundColor: WidgetStatePropertyAll(
                    Color.fromARGB(73, 144, 185, 255),
                  ),
                ),
                onPressed: onPressed,
                child: Text(
                  'PDF',
                  style: AppFont.boldTextStyle(
                    context,
                    AppFont.h3,
                    Colors.white,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 20),
          SizedBox(
            width: 275,
            height: 45,
            child: Directionality(
              textDirection: TextDirection.rtl,
              child: TextField(
                controller: search,
                focusNode: searchFocus,
                onChanged: onChanged,
                decoration: InputDecoration(
                  hintText: 'بحث ...',
                  fillColor: AppColor.backGroundColor,
                  filled: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(18),
                    borderSide: BorderSide(
                      color: AppColor.primaryColor,
                      width: 2,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
