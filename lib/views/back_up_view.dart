import 'package:cash_box/cubits/data_base/data_base_cubit.dart';
import 'package:cash_box/cubits/data_base/data_base_state.dart';
import 'package:cash_box/style/app_color.dart';
import 'package:cash_box/style/app_font.dart';
import 'package:cash_box/utils/ios_liked_route.dart';
import 'package:cash_box/utils/main_app_bar.dart';
import 'package:cash_box/views/home_view.dart';
import 'package:cash_box/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BackUpView extends StatelessWidget {
  const BackUpView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => DataBaseCubit(),
      child: Scaffold(
        appBar: mainAppBar(context, 'نسخة احتياطية'),
        body: Center(
          child: BlocConsumer<DataBaseCubit, DataBaseState>(
            listener: (context, state) {
              if (state is DataBaseSuccess) {
                if (state.action == 'backup') {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('تم إنشاء النسخة الاحتياطية بنجاح'),
                    ),
                  );
                } else if (state.action == 'import') {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('تم استيراد النسخة بنجاح')),
                  );
                  Navigator.pushAndRemoveUntil(
                    context,
                    iosLikeRoute(HomeView()),
                    (route) => false,
                  );
                }
              } else if (state is DataBaseFailure) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('حدث خطأ: ${state.message}')),
                );
              }
            },
            builder: (context, state) {
              if (state is DataBaseLoading) {
                return CircularProgressIndicator(color: AppColor.primaryColor);
              }

              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '${DateTime.now().year}-${DateTime.now().month}-${DateTime.now().day} : تاريخ النسخة',
                    style: AppFont.boldTextStyle(
                      context,
                      AppFont.h3,
                      Colors.black,
                    ),
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: 200,
                    child: CustomButton(
                      color: AppColor.primaryColor,
                      textColor: AppColor.backGroundColor,
                      title: 'حفظ نسخة احتياطية',
                      onTap: () {
                        context.read<DataBaseCubit>().createBackup();
                      },
                    ),
                  ),

                  const SizedBox(height: 30),

                  Text(
                    'استيراد نسخة احتياطية',
                    style: AppFont.boldTextStyle(
                      context,
                      AppFont.h3,
                      Colors.black,
                    ),
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: 200,
                    child: CustomButton(
                      color: AppColor.primaryColor,
                      textColor: AppColor.backGroundColor,
                      title: 'استيراد نسخة',
                      onTap: () {
                        context.read<DataBaseCubit>().importBackup();
                      },
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
