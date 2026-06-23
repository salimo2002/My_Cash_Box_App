
import 'package:cash_box/style/app_color.dart';
import 'package:cash_box/style/app_font.dart';
import 'package:cash_box/widgets/container_date_time.dart';
import 'package:flutter/material.dart';

class ChoseDateWidget extends StatelessWidget {
  const ChoseDateWidget({
    super.key,
    required this.selectedDate,
  });

  final ValueNotifier<DateTime> selectedDate;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          'التاريخ',
          style: AppFont.normalTextStyle(
            context,
            AppFont.body,
            AppColor.primaryColor,
          ),
        ),
        SizedBox(height: 10),
        GestureDetector(
          onTap: () async {
            final pickedDate = await showDatePicker(
              context: context,
              firstDate: DateTime(2000),
              lastDate: DateTime(2100),
              initialDate: selectedDate.value,
            );
            if (pickedDate != null) {
              selectedDate.value = pickedDate;
            }
          },
          child: ValueListenableBuilder(
            valueListenable: selectedDate,
            builder: (context, value, child) {
              return ContainerDateTime(value: value);
            },
          ),
        ),
      ],
    );
  }
}
