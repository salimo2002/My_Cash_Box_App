import 'package:cash_box/cubits/money_transaction/money_transaction_state.dart';
import 'package:cash_box/data/finance_repository.dart';
import 'package:cash_box/model/money_transaction_model.dart';
import 'package:cash_box/model/money_transaction_view_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MoneyTransactionCubit extends Cubit<MoneyTransactionState> {
  MoneyTransactionCubit() : super(MoneyTransactionInitial());
  List<MoneyTransactionViewModel> moneyTransactions = [];
  Future<void> getCashBoxTransactions(int cashBoxId) async {
    emit(MoneyTransactionLoading());
    try {
      moneyTransactions = await FinanceRepository.instance
          .getCashBoxTransactionsWithAccount(cashBoxId);
      emit(MoneyTransactionSuccess(moneyTransactions: moneyTransactions));
    } catch (e) {
      emit(
        MoneyTransactionFailure(message: 'حدث خطأ اثناء جلب الحركات المالية'),
      );
    }
  }

  Future<void> addTransaction({
    required MoneyTransactionModel transaction,
  }) async {
    emit(MoneyTransactionLoading());
    try {
      await FinanceRepository.instance.addTransaction(transaction: transaction);
      moneyTransactions = await FinanceRepository.instance
          .getCashBoxTransactionsWithAccount(transaction.cashBoxId);
      emit(MoneyTransactionSuccess(moneyTransactions: moneyTransactions));
    } catch (e) {
      emit(
        MoneyTransactionFailure(message: 'حدث خطأ اثناء إضافة الحركة المالية'),
      );
    }
  }

  Future<void> deleteTransaction({
    required MoneyTransactionModel transaction,
  }) async {
    emit(MoneyTransactionLoading());
    try {
      await FinanceRepository.instance.deleteTransaction(transaction.id!);
      moneyTransactions = await FinanceRepository.instance
          .getCashBoxTransactionsWithAccount(transaction.cashBoxId);
      emit(MoneyTransactionSuccess(moneyTransactions: moneyTransactions));
    } catch (e) {
      emit(
        MoneyTransactionFailure(message: 'حدث خطأ اثناء حذف الحركة المالية'),
      );
    }
  }
}
