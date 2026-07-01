import 'package:cash_box/cubits/cash_box/cash_box_cubit.dart';
import 'package:cash_box/style/app_color.dart';
import 'package:cash_box/views/welcom_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main(List<String> args) {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(CashBox());
}

class CashBox extends StatelessWidget {
  const CashBox({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [BlocProvider(create: (context) => CashBoxCubit())],
      child: MaterialApp(
        theme: ThemeData(scaffoldBackgroundColor: AppColor.backGroundColor),
        debugShowCheckedModeBanner: false,
        home: WelcomView(),
      ),
    );
  }
}
