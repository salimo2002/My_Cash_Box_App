import 'package:cash_box/utils/custom_drawer.dart';
import 'package:cash_box/utils/main_app_bar.dart';
import 'package:cash_box/utils/main_floatinf_button.dart';
import 'package:cash_box/widgets/cash_box_widgt.dart';
import 'package:flutter/material.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: mainAppBar(context, 'الصناديق'),
      drawer: CustomDrawer(),
      floatingActionButton: MainFloatingButton(onTap: () {}),
      body: ListView.builder(
        itemCount: 3,
        itemBuilder: (context, index) {
          return CashBoxWidgt(title: 'سوري', balance: '2570000', cur: 'SYP');
        },
      ),
    );
  }
}
