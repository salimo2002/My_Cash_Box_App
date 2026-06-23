import 'package:cash_box/style/app_color.dart';
import 'package:cash_box/style/app_font.dart';
import 'package:cash_box/widgets/main_text_field.dart';
import 'package:flutter/material.dart';

class AmountWidget extends StatelessWidget {
  const AmountWidget({super.key, required this.amount, required this.amountNode});
  final TextEditingController amount;
  final FocusNode amountNode;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          'المبلغ',
          style: AppFont.normalTextStyle(
            context,
            AppFont.body,
            AppColor.primaryColor,
          ),
        ),
        SizedBox(height: 10),
        MainTextField(
          controller: amount,
          hintText: '0.00',
          focusNode: amountNode,
          keyboardType: TextInputType.number,
          validator: (value) {
            if (value == null || value == '') {
              return 'المبلغ مطلوب';
            }
            return null;
          },
        ),
      ],
    );
  }
}
