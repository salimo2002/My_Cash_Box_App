import 'package:cash_box/cubits/account_cubit/account_cubit.dart';
import 'package:cash_box/cubits/cash_box/cash_box_cubit.dart';
import 'package:cash_box/style/app_color.dart';
import 'package:cash_box/style/app_font.dart';
import 'package:cash_box/utils/custom_drawer.dart';
import 'package:cash_box/utils/main_app_bar.dart';
import 'package:cash_box/utils/main_floating_button.dart';
import 'package:cash_box/widgets/cash_box_details.dart';
import 'package:cash_box/widgets/cash_boxes_list.dart';
import 'package:cash_box/widgets/no_data_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  void initState() {
    super.initState();
    context.read<CashBoxCubit>().getCashBoxesWithBalance();
    context.read<AccountCubit>().getAccountsWithBalance();
  }

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
      body: BlocBuilder<CashBoxCubit, CashBoxState>(
        builder: (context, state) {
          if (state is CashBoxLoading) {
            return const Center(
              child: CircularProgressIndicator(color: AppColor.primaryColor),
            );
          } else if (state is CashBoxSuccess) {
            if (state.cashBoxes.isEmpty) {
              return NoDataWidget(
                title: 'لا يوجد صناديق',
                icon: Icons.account_balance_wallet,
              );
            } else {
              return CashBoxesList(cashBoxes: state.cashBoxes);
            }
          } else if (state is CashBoxFailure) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18),
                child: Text(
                  state.message,
                  style: AppFont.boldTextStyle(
                    context,
                    AppFont.body,
                    AppColor.negativeColor,
                  ),
                ),
              ),
            );
          } else {
            return const SizedBox.shrink();
          }
        },
      ),
    );
  }
}
