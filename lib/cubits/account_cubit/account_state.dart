import 'package:cash_box/model/account_with_balance.dart';

sealed class AccountState {}

final class AccountInitial extends AccountState {}

final class AccountSuccess extends AccountState {
  final List<AccountWithBalance> accounts;

  AccountSuccess({required this.accounts});
}

final class AccountLoading extends AccountState {}

final class AccountFailure extends AccountState {
  final String message;

  AccountFailure({required this.message});
}
