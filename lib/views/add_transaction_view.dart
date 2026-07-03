import 'dart:developer';

import 'package:cash_box/constant.dart';
import 'package:cash_box/cubits/account_cubit/account_cubit.dart';
import 'package:cash_box/cubits/cash_box/cash_box_cubit.dart';
import 'package:cash_box/cubits/money_transaction/money_transaction_cubit.dart';
import 'package:cash_box/cubits/money_transaction/money_transaction_state.dart';
import 'package:cash_box/model/cash_box_with_balance.dart';
import 'package:cash_box/model/money_transaction_model.dart';
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
import 'package:flutter_bloc/flutter_bloc.dart';

class AddTransactionView extends StatefulWidget {
  const AddTransactionView({super.key, required this.cashBox});
  final CashBoxWithBalance cashBox;
  @override
  State<AddTransactionView> createState() => _AddTransactionViewState();
}

class _AddTransactionViewState extends State<AddTransactionView> {
  late ValueNotifier<DateTime> selectedDate;
  late ValueNotifier<bool> isPayment;
  late TextEditingController account;
  late FocusNode accountFocus;
  late TextEditingController amount;
  late FocusNode amountFocus;
  late TextEditingController description;
  late FocusNode descriptionFocus;
  late GlobalKey<FormState> formKey;
  late CashBoxCubit cashBoxCubit;
  late MoneyTransactionCubit moneyTransactionCubit;
  int accountId = 0;
  @override
  void initState() {
    selectedDate = ValueNotifier<DateTime>(DateTime.now());
    cashBoxCubit = context.read<CashBoxCubit>();
    moneyTransactionCubit = context.read<MoneyTransactionCubit>();
    isPayment = ValueNotifier<bool>(true);
    account = TextEditingController(text: 'معربا');
    accountFocus = FocusNode();
    amount = TextEditingController();
    amountFocus = FocusNode();
    description = TextEditingController();
    descriptionFocus = FocusNode();
    formKey = GlobalKey<FormState>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: mainAppBar(context, 'إضافة عملية'),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10.0),
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    BlocBuilder<CashBoxCubit, CashBoxState>(
                      builder: (context, state) {
                        if (state is CashBoxSuccess) {
                          final myCashBox = state.cashBoxes.firstWhere(
                            (element) => element.id == widget.cashBox.id,
                          );
                          return Text(
                            AppFont.formatMoney(myCashBox.balance).toString(),
                            style: AppFont.boldTextStyle(
                              context,
                              AppFont.body,
                              Colors.black,
                            ),
                          );
                        } else {
                          return Text(
                            AppFont.formatMoney(
                              widget.cashBox.balance,
                            ).toString(),
                            style: AppFont.boldTextStyle(
                              context,
                              AppFont.body,
                              Colors.black,
                            ),
                          );
                        }
                      },
                    ),
                    Text(
                      widget.cashBox.name,
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
                ValueListenableBuilder(
                  valueListenable: isPayment,
                  builder: (context, value, child) {
                    return IsPaymentOrReceipt(
                      isPayment: value,
                      onTap: () {
                        isPayment.value = !value;
                        log(selectedDate.value.toString());
                      },
                    );
                  },
                ),
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
                        amount: amount,
                        amountNode: amountFocus,
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
                  hintText: 'اختر حساب',
                  onSelected: (value) {
                    if (value != '') {
                      account.text = value!;
                      accountId = context
                          .read<AccountCubit>()
                          .accounts
                          .firstWhere((element) => element.name == value)
                          .id;
                    } else {
                      accountId = 0;
                      account.text = '';
                    }
                  },
                  validator: (value) {
                    if (value == '' || value == null) {
                      return 'قم باختيار حساب';
                    }
                    return null;
                  },
                  accounts: context
                      .read<AccountCubit>()
                      .accounts
                      .map((e) => e.name)
                      .toList(),
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
                  controller: description,
                  hintText: 'مصاريف ......',
                  focusNode: descriptionFocus,
                  validator: (value) {
                    if (value == null || value == '') {
                      return 'الوصف مطلوب';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 15),
                BlocBuilder<MoneyTransactionCubit, MoneyTransactionState>(
                  builder: (context, state) {
                    if (state is MoneyTransactionLoading) {
                      return const Center(
                        child: CircularProgressIndicator(
                          color: AppColor.primaryColor,
                        ),
                      );
                    } else {
                      return SaveButton(
                        title: 'اضافة',
                        onTap: () async {
                          if (formKey.currentState!.validate()) {
                            FocusScope.of(context).unfocus();
                            await moneyTransactionCubit.addTransaction(
                              transaction: MoneyTransactionModel(
                                cashBoxId: widget.cashBox.id,
                                amount: double.parse(
                                  amount.text.trim().replaceAll(',', ''),
                                ),
                                description: description.text,
                                date: selectedDate.value.toString(),
                                type: isPayment.value
                                    ? Constant.payment
                                    : Constant.receipt,
                                createdAt: DateTime.now().toString(),
                                accountId: accountId,
                              ),
                            );
                            if (!mounted) return;
                            await cashBoxCubit.getCashBoxesWithBalance();
                            if (!mounted) return;
                            amount.clear();
                            description.clear();
                          }
                        },
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
