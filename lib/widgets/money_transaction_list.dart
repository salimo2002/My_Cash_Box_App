import 'package:cash_box/constant.dart';
import 'package:cash_box/cubits/cash_box/cash_box_cubit.dart';
import 'package:cash_box/cubits/money_transaction/money_transaction_cubit.dart';
import 'package:cash_box/model/money_transaction_model.dart';
import 'package:cash_box/model/money_transaction_view_model.dart';
import 'package:cash_box/style/app_font.dart';
import 'package:cash_box/utils/show_alert_dialog.dart';
import 'package:cash_box/widgets/cash_transaction_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MoneyTransactionList extends StatefulWidget {
  const MoneyTransactionList({super.key, required this.moneyTransaction});
  final List<MoneyTransactionViewModel> moneyTransaction;

  @override
  State<MoneyTransactionList> createState() => _MoneyTransactionListState();
}

class _MoneyTransactionListState extends State<MoneyTransactionList> {
  late CashBoxCubit cashBoxCubit;
  late MoneyTransactionCubit moneyTransactionCubit;
  @override
  void initState() {
    super.initState();
    cashBoxCubit = context.read<CashBoxCubit>();
    moneyTransactionCubit = context.read<MoneyTransactionCubit>();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: widget.moneyTransaction.length,
        itemBuilder: (context, index) {
          return CashTransactionWidget(
            account: widget.moneyTransaction[index].accountName,
            onDelete: () {
              showAlertDialog(
                context: context,
                title: 'هل انت متأكد من حذف هذه الحركة',
                onDelete: () async {
                  await moneyTransactionCubit.deleteTransaction(
                    transaction: MoneyTransactionModel(
                      id: widget.moneyTransaction[index].id,
                      cashBoxId: widget.moneyTransaction[index].cashBoxId,
                      accountId: widget.moneyTransaction[index].accountId,
                      type: widget.moneyTransaction[index].type,
                      amount: widget.moneyTransaction[index].amount,
                      description:
                          widget.moneyTransaction[index].description ??
                          'لا يوجد وصف',
                      date: widget.moneyTransaction[index].date,
                      createdAt: widget.moneyTransaction[index].createdAt,
                    ),
                  );
                  await cashBoxCubit.getCashBoxesWithBalance();
                },
              );
            },
            title: widget.moneyTransaction[index].description ?? 'لا يوجد وصف',
            dateTime: AppFont.dateFormatted(
              DateTime.parse(widget.moneyTransaction[index].date),
            ),
            amount: widget.moneyTransaction[index].amount,
            isPayment: widget.moneyTransaction[index].type == Constant.payment
                ? true
                : false,
            cur: widget.moneyTransaction[index].accountCurrency,
          );
        },
      ),
    );
  }
}
