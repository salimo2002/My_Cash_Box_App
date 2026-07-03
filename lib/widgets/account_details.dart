import 'package:cash_box/constant.dart';
import 'package:cash_box/cubits/account_cubit/account_cubit.dart';
import 'package:cash_box/model/account_model.dart';
import 'package:cash_box/style/app_color.dart';
import 'package:cash_box/style/app_font.dart';
import 'package:cash_box/utils/show_snack_bar.dart';
import 'package:cash_box/widgets/custom_button.dart';
import 'package:cash_box/widgets/custom_drop_down.dart';
import 'package:cash_box/widgets/main_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AccountDetails extends StatefulWidget {
  const AccountDetails({super.key});

  @override
  State<AccountDetails> createState() => _AccountDetailsState();
}

class _AccountDetailsState extends State<AccountDetails> {
  late GlobalKey<FormState> formKey = GlobalKey<FormState>();
  late TextEditingController accountName;
  late FocusNode accountNameFocusNode;
  late String currency;
  @override
  void initState() {
    super.initState();
    accountName = TextEditingController();
    accountNameFocusNode = FocusNode();
    currency = 'SYP';
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: AlertDialog(
        backgroundColor: AppColor.backGroundColor,
        title: Center(
          child: Text(
            'اضافة حساب جديد',
            style: AppFont.boldTextStyle(context, AppFont.h2, Colors.black),
          ),
        ),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              MainTextField(
                controller: accountName,
                hintText: 'اسم الحساب',
                focusNode: accountNameFocusNode,
                validator: (value) {
                  if (value == null || value == '') {
                    return 'الاسم مطلوب';
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
                    context.read<AccountCubit>().createAccount(
                      account: AccountModel(
                        name: accountName.text,
                        currency: currency,
                        createdAt: DateTime.now().toString(),
                      ),
                    );
                    Navigator.pop(context);
                    showSnackBar(
                      context: context,
                      title: 'تم انشاء الحساب بنجاح',
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
