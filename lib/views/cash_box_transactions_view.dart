import 'dart:developer';

import 'package:cash_box/cubits/cash_box/cash_box_cubit.dart';
import 'package:cash_box/cubits/money_transaction/money_transaction_cubit.dart';
import 'package:cash_box/cubits/money_transaction/money_transaction_state.dart';
import 'package:cash_box/model/cash_box_with_balance.dart';
import 'package:cash_box/service/pdf_service.dart';
import 'package:cash_box/service/sharepdf_to_whatsapp.dart';
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
  late TextEditingController search;
  late FocusNode searchFocusNode;

  List<dynamic> currentFilteredTransactions = [];

  @override
  void initState() {
    super.initState();
    search = TextEditingController();
    searchFocusNode = FocusNode();

    context.read<MoneyTransactionCubit>().getCashBoxTransactions(
      widget.cashBox.id,
    );
  }

  @override
  void dispose() {
    search.dispose();
    searchFocusNode.dispose();
    super.dispose();
  }

  Future<void> _generateAndShareReport(CashBoxWithBalance currentBox) async {
    try {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('جاري إعداد وتحضير كشف الحساب...')),
      );

      final pdf = await PdfService.generateCashBoxPdf(
        cashBox: currentBox,
        transactions: currentFilteredTransactions,
        initialBalance: currentBox.initialBalance,
      );

      await sharePdfToWhatsApp(pdf: pdf, cashBoxName: currentBox.name);
    } catch (e) {
      log(e.toString());
    }
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
              final currentBox = (state is CashBoxSuccess)
                  ? state.cashBoxes.firstWhere(
                      (element) => element.id == widget.cashBox.id,
                      orElse: () => widget.cashBox,
                    )
                  : widget.cashBox;

              return CashBoxBalanceStatus(
                balance: currentBox.balance,
                initialBalance: currentBox.initialBalance,
                transLen: currentBox.transactionsCount,
                onPressed: () => _generateAndShareReport(currentBox),
                search: search,
                searchFocus: searchFocusNode,
              );
            },
          ),
          const SizedBox(height: 5),
          BlocBuilder<MoneyTransactionCubit, MoneyTransactionState>(
            builder: (context, state) {
              if (state is MoneyTransactionSuccess) {
                final query = search.text.toLowerCase();
                final filteredTransactions = state.moneyTransactions.where((
                  transaction,
                ) {
                  return transaction.description
                          .toString()
                          .toLowerCase()
                          .contains(query) ||
                      transaction.amount.toString().toLowerCase().contains(
                        query,
                      ) ||
                      transaction.accountName.toString().toLowerCase().contains(
                        query,
                      );
                }).toList();
                currentFilteredTransactions = filteredTransactions;
                if (filteredTransactions.isEmpty) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(height: 20),
                      NoDataWidget(
                        title: search.text.isEmpty
                            ? 'لا يوجد حركات مالية'
                            : 'لا توجد نتائج',
                        icon: Icons.money_off,
                      ),
                    ],
                  );
                } else {
                  return MoneyTransactionList(
                    moneyTransaction: filteredTransactions,
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
