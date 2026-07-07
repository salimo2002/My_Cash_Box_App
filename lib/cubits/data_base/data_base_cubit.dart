import 'package:cash_box/cubits/data_base/data_base_state.dart';
import 'package:cash_box/data/app_db.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DataBaseCubit extends Cubit<DataBaseState> {
  DataBaseCubit() : super(DataBaseInitial());

  Future<void> createBackup() async {
    try {
      emit(DataBaseLoading());

      await AppDb.instance.exportBackupUserChooseLocation();

      emit(DataBaseSuccess(action: 'backup'));
    } catch (e) {
      emit(DataBaseFailure(
        message: e.toString(),
        action: 'backup',
      ));
    }
  }

  Future<void> importBackup() async {
    try {
      emit(DataBaseLoading());

      final result = await FilePicker.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['db'],
      );

      if (result == null || result.files.single.path == null) {
        emit(DataBaseInitial());
        return;
      }

      final path = result.files.single.path!;

      await AppDb.instance.importDatabaseFromPath(path);

      emit(DataBaseSuccess(action: 'import'));
    } catch (e) {
      emit(DataBaseFailure(
        message: e.toString(),
        action: 'import',
      ));
    }
  }
}