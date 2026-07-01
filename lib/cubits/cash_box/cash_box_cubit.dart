import 'dart:developer';

import 'package:cash_box/data/finance_repository.dart';
import 'package:cash_box/model/cash_box_model.dart';
import 'package:cash_box/model/cash_box_with_balance.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'cash_box_state.dart';

class CashBoxCubit extends Cubit<CashBoxState> {
  CashBoxCubit() : super(CashBoxInitial());
  Future<void> createCashBox({required CashBoxModel cashBox}) async {
    emit(CashBoxLoading());
    try {
      await FinanceRepository.instance.createCashBox(cashBox: cashBox);
      emit(CashBoxSuccess());
    } catch (e) {
      log(e.toString());
      emit(CashBoxFailure(message: 'حصل خطأ اثناء إنشاء الصندوق النقدي'));
    }
  }

  Future<void> getCashBoxesWithBalance() async {
    emit(CashBoxLoading());
    try {
      final cashBoxes = await FinanceRepository.instance
          .getCashBoxesWithBalance();
      emit(CashBoxSuccess(cashBoxes: cashBoxes));
    } catch (e) {
      log(e.toString());
      emit(CashBoxFailure(message: 'حصل خطأ اثناء جلب الصناديق النقدية'));
    }
  }
}
