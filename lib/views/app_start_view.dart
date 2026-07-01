import 'package:cash_box/data/app_db.dart';
import 'package:cash_box/views/home_view.dart';
import 'package:cash_box/views/welcom_view.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppStart extends StatelessWidget {
  const AppStart({super.key});

  Future<Widget> _decideStart() async {
    final prefs = await SharedPreferences.getInstance();
    final isDone = prefs.getBool('isSetupDone') ?? false;

    if (isDone) {
      await AppDb.instance.database;
      return const HomeView();
    }
    return const WelcomView();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Widget>(
      future: _decideStart(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }
        return snapshot.data!;
      },
    );
  }
}
