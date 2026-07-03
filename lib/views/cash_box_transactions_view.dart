import 'package:cash_box/cubits/cash_box/cash_box_cubit.dart';
import 'package:cash_box/cubits/money_transaction/money_transaction_cubit.dart';
import 'package:cash_box/cubits/money_transaction/money_transaction_state.dart';
import 'package:cash_box/model/cash_box_with_balance.dart';
import 'package:cash_box/style/app_color.dart';
import 'package:cash_box/utils/ios_liked_route.dart';
import 'package:cash_box/utils/main_app_bar.dart';
import 'package:cash_box/utils/main_floating_button.dart';
import 'package:cash_box/views/add_transaction_view.dart';
import 'package:cash_box/widgets/cash_box_balance_status.dart';
import 'package:cash_box/widgets/money_transaction_list.dart';
import 'package:cash_box/widgets/no_data_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CashBoxTransactionsView extends StatefulWidget {
  const CashBoxTransactionsView({super.key, required this.cashBox});
  final CashBoxWithBalance cashBox;

  @override
  State<CashBoxTransactionsView> createState() =>
      _CashBoxTransactionsViewState();
}

class _CashBoxTransactionsViewState extends State<CashBoxTransactionsView> {
  @override
  void initState() {
    super.initState();
    context.read<MoneyTransactionCubit>().getCashBoxTransactions(
      widget.cashBox.id,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: mainAppBar(context, widget.cashBox.name),
      floatingActionButton: MainFloatingButton(
        onTap: () {
          Navigator.push(
            context,
            iosLikeRoute(AddTransactionView(cashBox: widget.cashBox)),
          );
        },
      ),
      body: Column(
        children: [
          BlocBuilder<CashBoxCubit, CashBoxState>(
            builder: (context, state) {
              if (state is CashBoxSuccess) {
                final myCashBox = state.cashBoxes.firstWhere(
                  (element) => element.id == widget.cashBox.id,
                );
                return CashBoxBalanceStatus(
                  balance: myCashBox.balance,
                  initialBalance: myCashBox.initialBalance,
                  transLen: myCashBox.transactionsCount,
                  onPressed: () {},
                  search: TextEditingController(),
                  searchFocus: FocusNode(),
                );
              } else {
                return CashBoxBalanceStatus(
                  balance: widget.cashBox.balance,
                  initialBalance: widget.cashBox.initialBalance,
                  transLen: widget.cashBox.transactionsCount,
                  onPressed: () {},
                  search: TextEditingController(),
                  searchFocus: FocusNode(),
                );
              }
            },
          ),
          SizedBox(height: 5),
          BlocBuilder<MoneyTransactionCubit, MoneyTransactionState>(
            builder: (context, state) {
              if (state is MoneyTransactionSuccess) {
                if (state.moneyTransactions.isEmpty) {
                  return Column(
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.2,
                      ),
                      NoDataWidget(
                        title: 'لا يوجد حركات مالية',
                        icon: Icons.money_off,
                      ),
                    ],
                  );
                } else {
                  return MoneyTransactionList(
                    moneyTransaction: state.moneyTransactions,
                  );
                }
              } else if (state is MoneyTransactionFailure) {
                return Center(child: Text(state.message));
              } else if (state is MoneyTransactionLoading) {
                return const Center(
                  child: CircularProgressIndicator(
                    color: AppColor.primaryColor,
                  ),
                );
              } else {
                return const SizedBox.shrink();
              }
            },
          ),
        ],
      ),
    );
  }
}
