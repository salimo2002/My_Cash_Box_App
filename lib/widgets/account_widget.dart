import 'package:cash_box/cubits/account_cubit/account_cubit.dart';
import 'package:cash_box/model/account_with_balance.dart';
import 'package:cash_box/style/app_color.dart';
import 'package:cash_box/style/app_font.dart';
import 'package:cash_box/utils/show_alert_dialog.dart';
import 'package:cash_box/utils/show_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AccountWidget extends StatefulWidget {
  const AccountWidget({super.key, required this.account});
  final AccountWithBalance account;
  @override
  State<AccountWidget> createState() => _AccountWidgetState();
}

class _AccountWidgetState extends State<AccountWidget> {
  late AccountCubit accountCubit;
  @override
  void initState() {
    super.initState();
    accountCubit = context.read<AccountCubit>();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Padding(
        padding: const EdgeInsets.only(right: 12, left: 12, top: 8),
        child: ListTile(
          contentPadding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          tileColor: AppColor.tileColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),
          leading: Icon(
            Icons.account_circle,
            color: AppColor.primaryColor,
            size: 30,
          ),
          title: Text(
            widget.account.name,
            style: AppFont.boldTextStyle(
              context,
              AppFont.h3,
              AppColor.primaryColor,
            ),
          ),
          subtitle: Text(
            AppFont.formatMoney(widget.account.calculatedBalance).toString(),
            style: AppFont.boldTextStyle(
              context,
              AppFont.small,
              widget.account.calculatedBalance > 0
                  ? AppColor.paymentColor
                  : AppColor.receiveColor,
            ),
          ),
          trailing: IconButton(
            onPressed: () {
              showAlertDialog(
                context: context,
                title:
                    'عند حذف الحساب سيتم حذف جميع الحركات المرتبطة به , هل انت متأكد؟',
                onDelete: () async {
                  await accountCubit.deleteAccount(widget.account.id);
                  if (!context.mounted) return;
                  showSnackBar(context: context, title: 'تم حذف الحساب بنجاح');
                },
              );
            },
            icon: Icon(Icons.delete_outline, color: AppColor.negativeColor),
          ),
        ),
      ),
    );
  }
}
