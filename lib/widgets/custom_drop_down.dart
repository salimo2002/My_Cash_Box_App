import 'package:cash_box/style/app_color.dart';
import 'package:cash_box/style/app_font.dart';
import 'package:cash_box/utils/show_snack_bar.dart';
import 'package:flutter/material.dart';

class CustomDropDown extends StatelessWidget {
  const CustomDropDown({
    super.key,
    required this.accounts,
    this.onSelected,
    this.hintText = "اختر الحساب",
  });

  final List<String> accounts;
  final void Function(String?)? onSelected;
  final String hintText;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (accounts.isEmpty) {
          showSnackBar(context: context, title: 'قم بانشاء حساب');
        }
      },
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: DropdownButtonFormField<String>(
          decoration: InputDecoration(
            labelText: hintText,
            prefixIcon: const Icon(Icons.account_circle_outlined),
            filled: true,
            fillColor: AppColor.backGroundColor,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide(color: AppColor.primaryColor),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide(color: AppColor.primaryColor),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide(color: AppColor.primaryColor, width: 2),
            ),
          ),
          items: accounts.map((account) {
            return DropdownMenuItem<String>(
              value: account,
              child: Text(account, style: const TextStyle(fontSize: 16)),
            );
          }).toList(),
          onChanged: onSelected,
          isExpanded: true,
          icon: const Icon(Icons.arrow_drop_down),
          iconSize: 30,
          elevation: 8,
          style: const TextStyle(fontSize: 16, color: Colors.black),
          dropdownColor: AppColor.dropColor,
          borderRadius: BorderRadius.circular(14),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'الرجاء اختيار حساب';
            }
            return null;
          },
        ),
      ),
    );
  }
}
