import 'package:cash_box/constant.dart';
import 'package:cash_box/cubits/cash_box/cash_box_cubit.dart';
import 'package:cash_box/model/cash_box_model.dart';
import 'package:cash_box/style/app_color.dart';
import 'package:cash_box/style/app_font.dart';
import 'package:cash_box/utils/show_snack_bar.dart';
import 'package:cash_box/widgets/custom_button.dart';
import 'package:cash_box/widgets/custom_drop_down.dart';
import 'package:cash_box/widgets/main_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CashBoxDetails extends StatefulWidget {
  const CashBoxDetails({super.key});

  @override
  State<CashBoxDetails> createState() => _CashBoxDetailsState();
}

class _CashBoxDetailsState extends State<CashBoxDetails> {
  late TextEditingController cashBoxName;
  late FocusNode cashBoxNameFocusNode;
  late TextEditingController cashBoxBalance;
  late FocusNode cashBoxBalanceFocusNode;
  late String currency;
  late GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
    cashBoxName = TextEditingController();
    cashBoxNameFocusNode = FocusNode();
    cashBoxBalance = TextEditingController();
    cashBoxBalanceFocusNode = FocusNode();
    currency = 'SYP';
  }

  @override
  void dispose() {
    super.dispose();
    cashBoxName.dispose();
    cashBoxNameFocusNode.dispose();
    cashBoxBalance.dispose();
    cashBoxBalanceFocusNode.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: AlertDialog(
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
                controller: cashBoxName,
                hintText: 'اسم الصندوق',
                focusNode: cashBoxNameFocusNode,
                validator: (value) {
                  if (value == null || value == '') {
                    return 'الاسم مطلوب';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              MainTextField(
                controller: cashBoxBalance,
                hintText: 'الرصيد البدئي',
                focusNode: cashBoxBalanceFocusNode,
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value == '') {
                    return 'الرصيد مطلوب';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              Directionality(
                textDirection: TextDirection.rtl,
                child: CustomDropDown(
                  accounts: Constant.currencies,
                  hintText: 'العملة',
                  onSelected: (value) {
                    if (value != null) {
                      setState(() {
                        currency = value;
                      });
                    }
                    return;
                  },
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
                onTap: () {
                  if (formKey.currentState!.validate()) {
                    context.read<CashBoxCubit>().createCashBox(
                      cashBox: CashBoxModel(
                        name: cashBoxName.text,
                        currency: currency,
                        initialBalance: double.parse(
                          cashBoxBalance.text.trim().replaceAll(',', ''),
                        ),
                        createdAt: DateTime.now().toString(),
                      ),
                    );
                    Navigator.pop(context);
                    showSnackBar(
                      context: context,
                      title: 'تم انشاء الصندوق النقدي بنجاح',
                    );
                  }
                },
                title: 'اضافة',
                textColor: Colors.white,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
