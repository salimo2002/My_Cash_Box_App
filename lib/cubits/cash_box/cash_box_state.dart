part of 'cash_box_cubit.dart';

sealed class CashBoxState {}

final class CashBoxInitial extends CashBoxState {}

final class CashBoxFailure extends CashBoxState {
  final String message;

  CashBoxFailure({required this.message});
}

final class CashBoxLoading extends CashBoxState {}

final class CashBoxSuccess extends CashBoxState {
  final List<CashBoxWithBalance>? cashBoxes;

  CashBoxSuccess({this.cashBoxes});
}
