
import 'package:cash_box/model/cash_box_with_balance.dart';
import 'package:cash_box/utils/ios_liked_route.dart';
import 'package:cash_box/utils/show_alert_dialog.dart';
import 'package:cash_box/views/cash_box_transactions_view.dart';
import 'package:cash_box/widgets/cash_box_widgt.dart';
import 'package:flutter/material.dart';

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
            showAlertDialog(
              context: context,
              title: 'سيتم حذف جميع الحركات المالية\nهل انت متأكد ؟',
              onDelete: () {},
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
