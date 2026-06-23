import 'package:cash_box/style/app_color.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';

class CustomDropDown extends StatelessWidget {
  const CustomDropDown({
    super.key,
    required this.accounts,
    required this.initValue,
    this.onSelected,
  });

  final List<String> accounts;
  final String initValue;
  final void Function(String?)? onSelected;

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: DropdownSearch<String>(
        selectedItem: initValue,
        items: (filter, loadProps) => accounts,
        onSelected: onSelected,
        popupProps: PopupProps.bottomSheet(
          showSearchBox: true,
          bottomSheetProps: const BottomSheetProps(
            backgroundColor: AppColor.dropColor,
            elevation: 10,
          ),
          searchFieldProps: TextFieldProps(
            decoration: InputDecoration(
              hintText: "ابحث عن الحساب...",
              prefixIcon: const Icon(Icons.search),
              filled: true,
              fillColor: Colors.grey.shade100,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14),
                borderSide: BorderSide.none,
              ),
            ),
          ),
        ),
        decoratorProps: DropDownDecoratorProps(
          decoration: InputDecoration(
            labelText: "اختر الحساب",
            prefixIcon: const Icon(Icons.account_balance_wallet),
            filled: true,
            fillColor: AppColor.backGroundColor,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide(color: AppColor.primaryColor),
            ),
          ),
        ),
      ),
    );
  }
}
