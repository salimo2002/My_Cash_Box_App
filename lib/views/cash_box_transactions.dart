import 'package:cash_box/utils/main_app_bar.dart';
import 'package:cash_box/utils/main_floatinf_button.dart';
import 'package:cash_box/widgets/cash_box_balance_status.dart';
import 'package:cash_box/widgets/cash_transaction_widget.dart';
import 'package:flutter/material.dart';

class CashBoxTransactions extends StatelessWidget {
  const CashBoxTransactions({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: mainAppBar(context, 'سوري'),
      floatingActionButton: MainFloatingButton(onTap: () {}),
      body: Column(
        children: [
          CashBoxBalanceStatus(
            balance: 2570000,
            initialBalance: 2000000,
            transLen: 5,
            onPressed: () {},
            search: TextEditingController(),
            searchFocus: FocusNode(),
          ),
          SizedBox(height: 5),
          Expanded(
            child: ListView.builder(
              itemCount: 3,
              itemBuilder: (context, index) {
                return CashTransactionWidget(
                  onDelete: () {},
                  title: 'شراء مواد',
                  dateTime: '2023-06-01',
                  amount: 500000,
                  isPayment: true,
                  cur: 'SYP',
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
