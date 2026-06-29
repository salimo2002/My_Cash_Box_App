import 'package:cash_box/utils/delet_alert_dialog.dart';
import 'package:flutter/material.dart';

showAlertDialog({
  required BuildContext context,
  required String title,
  required VoidCallback onDelete,
}) {
  showDialog(
    context: context,
    builder: (context) {
      return DeleteAlertDialog(title: title, onDelete: onDelete);
    },
  );
}
