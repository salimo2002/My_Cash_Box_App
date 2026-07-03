import 'package:cash_box/model/money_transaction_view_model.dart';

sealed class MoneyTransactionState {}

final class MoneyTransactionInitial extends MoneyTransactionState {}

final class MoneyTransactionLoading extends MoneyTransactionState {}

final class MoneyTransactionSuccess extends MoneyTransactionState {
  final List<MoneyTransactionViewModel> moneyTransactions;

  MoneyTransactionSuccess({required this.moneyTransactions});
}

final class MoneyTransactionFailure extends MoneyTransactionState {
  final String message;

  MoneyTransactionFailure({required this.message});
}
