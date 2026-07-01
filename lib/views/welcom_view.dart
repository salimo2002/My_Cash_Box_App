import 'dart:developer';
import 'package:cash_box/data/app_db.dart';
import 'package:cash_box/style/app_font.dart';
import 'package:cash_box/utils/ios_liked_route.dart';
import 'package:cash_box/service/mark_set_up_done.dart';
import 'package:cash_box/views/home_view.dart';
import 'package:cash_box/widgets/option_card.dart';
import 'package:flutter/material.dart';

class WelcomView extends StatelessWidget {
  const WelcomView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 16),
              Text(
                'Cash Box',
                textAlign: TextAlign.center,
                style: AppFont.appNameStyle(),
              ),
              const SizedBox(height: 8),
              Text(
                'مرحباً! اختر طريقة البدء',
                textAlign: TextAlign.center,
                style: AppFont.normalTextStyle(
                  context,
                  AppFont.body,
                  Colors.grey.shade700,
                ),
              ),
              const Spacer(),
              OptionCard(
                icon: Icons.add_circle_outline,
                title: 'متابعة من جديد',
                subtitle: 'إنشاء قاعدة بيانات محلياً على الجهاز',
                onTap: () async {
                  showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder: (_) =>
                        const Center(child: CircularProgressIndicator()),
                  );
                  await createDataBase();
                  if (!context.mounted) return;
                  Navigator.pop(context);
                  Navigator.pushReplacement(context, iosLikeRoute(HomeView()));
                },
              ),
              const SizedBox(height: 12),
              OptionCard(
                icon: Icons.file_download_outlined,
                title: 'استيراد نسخة بيانات',
                subtitle: 'اختيار ملف قاعدة بيانات (db) من تخزين الجهاز',
                onTap: () {
                  Navigator.pushReplacement(context, iosLikeRoute(HomeView()));
                },
              ),
              const Spacer(),
              Text(
                'يمكنك تغيير ذلك لاحقاً من الإعدادات.',
                textAlign: TextAlign.center,
                style: AppFont.normalTextStyle(
                  context,
                  13,
                  Colors.grey.shade600,
                ),
              ),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }

  createDataBase() async {
    final db = await AppDb.instance.database;
    await markSetupDone();
    log('Database opened at: ${db.path}');
  }
}
