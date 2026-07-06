import 'package:cash_box/style/app_color.dart' show AppColor;
import 'package:cash_box/style/number_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MainTextField extends StatelessWidget {
  const MainTextField({
    super.key,
    required this.controller,
    this.keyboardType,
    required this.hintText,
    required this.focusNode,
    this.validator, this.onChanged,
  });
  final TextEditingController controller;
  final TextInputType? keyboardType;
  final String hintText;
  final FocusNode focusNode;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: TextFormField(
        onChanged: onChanged,
        validator: validator,
        controller: controller,
        keyboardType: keyboardType,
        focusNode: focusNode,
        inputFormatters: keyboardType == TextInputType.number
            ? [FilteringTextInputFormatter.digitsOnly, NumberFormatter()]
            : [],
        decoration: InputDecoration(
          hintText: hintText,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(18),
            borderSide: BorderSide(color: AppColor.primaryColor, width: 2),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(18),
            borderSide: BorderSide(color: Colors.red, width: 2),
          ),
        ),
      ),
    );
  }
}
