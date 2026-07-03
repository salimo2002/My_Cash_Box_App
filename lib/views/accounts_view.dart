import 'package:cash_box/cubits/account_cubit/account_cubit.dart';
import 'package:cash_box/cubits/account_cubit/account_state.dart';
import 'package:cash_box/cubits/cash_box/cash_box_cubit.dart';
import 'package:cash_box/style/app_color.dart';
import 'package:cash_box/style/app_font.dart';
import 'package:cash_box/utils/main_app_bar.dart';
import 'package:cash_box/utils/main_floating_button.dart';
import 'package:cash_box/widgets/account_details.dart';
import 'package:cash_box/widgets/account_widget.dart';
import 'package:cash_box/widgets/no_data_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AccountsView extends StatefulWidget {
  const AccountsView({super.key});

  @override
  State<AccountsView> createState() => _AccountsViewState();
}

class _AccountsViewState extends State<AccountsView> {
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
      body: BlocBuilder<AccountCubit, AccountState>(
        builder: (context, state) {
          if (state is AccountLoading) {
            return const Center(
              child: CircularProgressIndicator(color: AppColor.primaryColor),
            );
          } else if (state is AccountSuccess) {
            if (state.accounts.isEmpty) {
              return RefreshIndicator(
                onRefresh: () async {
                  await cashBoxCubit.getCashBoxesWithBalance();
                  await accountCubit.getAccountsWithBalance();
                },
                child: ListView(
                  children: [
                    SizedBox(height: MediaQuery.sizeOf(context).height * .4),
                    NoDataWidget(
                      title: 'لا يوجد حسابات',
                      icon: Icons.supervisor_account_sharp,
                    ),
                  ],
                ),
              );
            } else {
              return RefreshIndicator(
                onRefresh: () async {
                  await cashBoxCubit.getCashBoxesWithBalance();
                  await accountCubit.getAccountsWithBalance();
                },
                child: ListView.builder(
                  itemCount: state.accounts.length,
                  itemBuilder: (context, index) {
                    return AccountWidget(account: state.accounts[index]);
                  },
                ),
              );
            }
          } else if (state is AccountFailure) {
            return RefreshIndicator(
              onRefresh: () async {
                await cashBoxCubit.getCashBoxesWithBalance();
                await accountCubit.getAccountsWithBalance();
              },
              child: ListView(
                children: [
                  SizedBox(height: MediaQuery.sizeOf(context).height * .4),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 18),
                    child: Text(
                      state.message,
                      textAlign: TextAlign.center,
                      style: AppFont.boldTextStyle(
                        context,
                        AppFont.body,
                        AppColor.negativeColor,
                      ),
                    ),
                  ),
                ],
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
