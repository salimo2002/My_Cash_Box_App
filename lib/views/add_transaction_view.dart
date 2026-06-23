import 'package:cash_box/style/app_color.dart';
import 'package:cash_box/style/app_font.dart';
import 'package:cash_box/utils/main_app_bar.dart';
import 'package:cash_box/widgets/amount_widget.dart';
import 'package:cash_box/widgets/chose_date_widget.dart';
import 'package:cash_box/widgets/custom_drop_down.dart';
import 'package:cash_box/widgets/is_payment_or_receipt.dart';
import 'package:cash_box/widgets/main_text_field.dart';
import 'package:cash_box/widgets/save_button.dart';
import 'package:flutter/material.dart';

class AddTransactionView extends StatefulWidget {
  const AddTransactionView({super.key});

  @override
  State<AddTransactionView> createState() => _AddTransactionViewState();
}

class _AddTransactionViewState extends State<AddTransactionView> {
  ValueNotifier<DateTime> selectedDate = ValueNotifier<DateTime>(
    DateTime.now(),
  );
  TextEditingController initialAccount = TextEditingController(text: 'معربا');
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: mainAppBar(context, 'إضافة عملية'),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10.0),
        child: SingleChildScrollView(
          child: Form(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      AppFont.formatMoney(2570000 as num).toString(),
                      style: AppFont.boldTextStyle(
                        context,
                        AppFont.body,
                        Colors.black,
                      ),
                    ),
                    Text(
                      'سوري',
                      style: AppFont.boldTextStyle(
                        context,
                        AppFont.body,
                        Colors.black,
                      ),
                    ),
                  ],
                ),
                Text(
                  'إضافة عملية جديدة',
                  style: AppFont.boldTextStyle(
                    context,
                    AppFont.h3,
                    Colors.black,
                  ),
                ),
                SizedBox(height: 15),
                IsPaymentOrReceipt(),
                SizedBox(height: 15),
                Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: ChoseDateWidget(selectedDate: selectedDate),
                    ),
                    SizedBox(width: 12),
                    Expanded(
                      flex: 2,
                      child: AmountWidget(
                        amount: TextEditingController(),
                        amountNode: FocusNode(),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 15),
                Text(
                  'الحساب',
                  style: AppFont.normalTextStyle(
                    context,
                    AppFont.body,
                    AppColor.primaryColor,
                  ),
                ),
                SizedBox(height: 10),
                CustomDropDown(
                  initValue: 'معربا',
                  onSelected: (value) {},
                  accounts: [
                    'معربا',
                    'الحرس',
                    'الرابعة',
                    'الاليات',
                    'الغربيات',
                  ],
                ),
                SizedBox(height: 15),
                Text(
                  'الوصف',
                  style: AppFont.normalTextStyle(
                    context,
                    AppFont.body,
                    AppColor.primaryColor,
                  ),
                ),
                SizedBox(height: 10),
                MainTextField(
                  controller: TextEditingController(),
                  hintText: 'مصاريف ......',
                  focusNode: FocusNode(),
                  validator: (value) {
                    if (value == null || value == '') {
                      return 'الوصف مطلوب';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 15),
                SaveButton(title: 'حفظ', onTap: () {}),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
