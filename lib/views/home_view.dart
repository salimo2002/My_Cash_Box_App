import 'package:cash_box/utils/custom_drawer.dart';
import 'package:cash_box/utils/ios_liked_route.dart';
import 'package:cash_box/utils/main_app_bar.dart';
import 'package:cash_box/utils/main_floatinf_button.dart';
import 'package:cash_box/utils/show_alert_dialog.dart';
import 'package:cash_box/views/cash_box_transactions.dart';
import 'package:cash_box/widgets/cash_box_details.dart';
import 'package:cash_box/widgets/cash_box_widgt.dart';
import 'package:flutter/material.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: mainAppBar(context, 'الصناديق'),
      drawer: CustomDrawer(),
      floatingActionButton: MainFloatingButton(
        onTap: () {
          showDialog(
            context: context,
            builder: (context) {
              return CashBoxDetails();
            },
          );
        },
      ),
      body: ListView.builder(
        itemCount: 3,
        itemBuilder: (context, index) {
          return CashBoxWidgt(
            title: 'سوري',
            balance: '2570000',
            cur: 'SYP',
            onDelet: () {
              showAlertDialog(
                context: context,
                title: 'سيتم حذف جميع الحركات المالية\nهل انت متأكد ؟',
                onDelete: () {},
              );
            },
            onTap: () {
              Navigator.push(context, iosLikeRoute(CashBoxTransactions()));
            },
          );
        },
      ),
    );
  }
}
