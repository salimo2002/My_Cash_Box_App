import 'package:cash_box/utils/main_app_bar.dart';
import 'package:cash_box/utils/main_floatinf_button.dart';
import 'package:cash_box/widgets/account_details.dart';
import 'package:cash_box/widgets/account_widget.dart';
import 'package:flutter/material.dart';

class AccountsView extends StatelessWidget {
  const AccountsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: mainAppBar(context, 'الحسابات'),
      floatingActionButton: MainFloatingButton(
        onTap: () {
          showDialog(
            context: context,
            builder: (context) {
              return AccountDetails();
            },
          );
        },
      ),
      body: ListView.builder(
        itemCount: 3,
        itemBuilder: (context, index) {
          return AccountWidget(accountName: 'معربا', onDelete: () {});
        },
      ),
    );
  }
}
