import 'package:cash_box/cubits/account_cubit/account_state.dart';
import 'package:cash_box/data/finance_repository.dart';
import 'package:cash_box/model/account_model.dart';
import 'package:cash_box/model/account_with_balance.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AccountCubit extends Cubit<AccountState> {
  AccountCubit() : super(AccountInitial());
  List<AccountWithBalance> accounts = [];
  Future<void> createAccount({required AccountModel account}) async {
    emit(AccountLoading());
    try {
      await FinanceRepository.instance.createAccount(account: account);
      accounts = await FinanceRepository.instance.getAccountsWithBalance();
      emit(AccountSuccess(accounts: accounts));
    } catch (e) {
      emit(AccountFailure(message: 'حدث خطأ اثناء انشاء الحساب'));
    }
  }

  Future<void> getAccountsWithBalance() async {
    emit(AccountLoading());
    try {
      final accountsWithBalance = await FinanceRepository.instance
          .getAccountsWithBalance();
      accounts = accountsWithBalance;
      emit(AccountSuccess(accounts: accounts));
    } catch (e) {
      emit(AccountFailure(message: 'حدث خطأ في جلب الحسابات'));
    }
  }

  Future<void> deleteAccount(int id) async {
    emit(AccountLoading());
    try {
      await FinanceRepository.instance.deleteAccount(id);
      accounts = await FinanceRepository.instance.getAccountsWithBalance();
      emit(AccountSuccess(accounts: accounts));
    } catch (e) {
      emit(
        AccountFailure(
          message:
              'لايمكن حذف الحساب قم اولا بحذف الحركات المالية المرتبطة به, قم بالتمرير للاسفل للتحديث',
        ),
      );
    }
  }
}
