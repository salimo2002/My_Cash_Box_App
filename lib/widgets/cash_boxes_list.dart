import 'package:cash_box/cubits/account_cubit/account_cubit.dart';
import 'package:cash_box/cubits/cash_box/cash_box_cubit.dart';
import 'package:cash_box/model/cash_box_with_balance.dart';
import 'package:cash_box/utils/ios_liked_route.dart';
import 'package:cash_box/utils/show_alert_dialog.dart';
import 'package:cash_box/utils/show_snack_bar.dart';
import 'package:cash_box/views/cash_box_transactions_view.dart';
import 'package:cash_box/widgets/cash_box_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CashBoxesList extends StatefulWidget {
  const CashBoxesList({super.key, required this.cashBoxes});
  final List<CashBoxWithBalance> cashBoxes;

  @override
  State<CashBoxesList> createState() => _CashBoxesListState();
}

class _CashBoxesListState extends State<CashBoxesList> {
  late CashBoxCubit cashBoxCubit;
  late AccountCubit accountCubit;

  @override
  void initState() {
    super.initState();
    cashBoxCubit = context.read<CashBoxCubit>();
    accountCubit = context.read<AccountCubit>();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        await cashBoxCubit.getCashBoxesWithBalance();
        await accountCubit.getAccountsWithBalance();
      },
      child: ListView.builder(
        itemCount: widget.cashBoxes.length,
        itemBuilder: (context, index) {
          return CashBoxWidget(
            title: widget.cashBoxes[index].name,
            balance: widget.cashBoxes[index].balance.toString(),
            cur: widget.cashBoxes[index].currency,
            onDelet: () {
              showAlertDialog(
                context: context,
                title: 'سيتم حذف جميع الحركات المالية\nهل انت متأكد ؟',
                onDelete: () async {
                  await cashBoxCubit.deleteCashBox(widget.cashBoxes[index].id);
                  if (!context.mounted) return;
                  showSnackBar(
                    context: context,
                    title: 'تم حذف الصندوق النقدي بنجاح',
                  );
                  if (!mounted) return;
                },
              );
            },
            onTap: () {
              Navigator.push(
                context,
                iosLikeRoute(
                  CashBoxTransactionsView(cashBox: widget.cashBoxes[index]),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
