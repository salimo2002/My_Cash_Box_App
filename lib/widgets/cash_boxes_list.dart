import 'dart:developer';
import 'package:cash_box/cubits/cash_box/cash_box_cubit.dart';
import 'package:cash_box/model/cash_box_with_balance.dart';
import 'package:cash_box/utils/ios_liked_route.dart';
import 'package:cash_box/utils/show_alert_dialog.dart';
import 'package:cash_box/utils/show_snack_bar.dart';
import 'package:cash_box/views/cash_box_transactions_view.dart';
import 'package:cash_box/widgets/cash_box_widgt.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CashBoxesList extends StatelessWidget {
  const CashBoxesList({super.key, required this.cashBoxes});
  final List<CashBoxWithBalance> cashBoxes;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: cashBoxes.length,
      itemBuilder: (context, index) {
        return CashBoxWidgt(
          title: cashBoxes[index].name,
          balance: cashBoxes[index].balance.toString(),
          cur: cashBoxes[index].currency,
          onDelet: () {
            log(cashBoxes[index].balance.toString());
            showAlertDialog(
              context: context,
              title: 'سيتم حذف جميع الحركات المالية\nهل انت متأكد ؟',
              onDelete: () {
                context.read<CashBoxCubit>().deleteCashBox(cashBoxes[index].id);
                Navigator.pop(context);
                showSnackBar(
                  context: context,
                  title: 'تم حذف الصندوق النقدي بنجاح',
                );
              },
            );
          },
          onTap: () {
            Navigator.push(context, iosLikeRoute(CashBoxTransactionsView()));
          },
        );
      },
    );
  }
}
