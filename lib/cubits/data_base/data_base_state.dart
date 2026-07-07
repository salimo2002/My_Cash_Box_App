abstract class DataBaseState {}

class DataBaseInitial extends DataBaseState {}

class DataBaseLoading extends DataBaseState {}

class DataBaseSuccess extends DataBaseState {
  final String action; // backup | import
  DataBaseSuccess({required this.action});
}

class DataBaseFailure extends DataBaseState {
  final String message;
  final String action; // backup | import

  DataBaseFailure({required this.message, required this.action});
}