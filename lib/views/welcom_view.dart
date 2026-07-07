import 'dart:developer';
import 'package:cash_box/data/app_db.dart';
import 'package:cash_box/style/app_font.dart';
import 'package:cash_box/utils/ios_liked_route.dart';
import 'package:cash_box/service/mark_set_up_done.dart';
import 'package:cash_box/views/home_view.dart';
import 'package:cash_box/widgets/option_card.dart';
import 'package:file_picker/file_picker.dart';
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

              /// ✅ إنشاء جديد
              OptionCard(
                icon: Icons.add_circle_outline,
                title: 'متابعة من جديد',
                subtitle: 'إنشاء قاعدة بيانات محلياً على الجهاز',
                onTap: () async {
                  _showLoading(context);

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
                onTap: () async {
                  _showLoading(context);
                  try {
                    final result = await FilePicker.pickFiles(
                      type: FileType.custom,
                      allowedExtensions: ['db'],
                    );

                    if (result == null || result.files.single.path == null) {
                      Navigator.pop(context);
                      return;
                    }

                    final path = result.files.single.path!;

                    await AppDb.instance.importDatabaseFromPath(path);

                    await markSetupDone();

                    if (!context.mounted) return;
                    Navigator.pop(context);

                    Navigator.pushReplacement(
                      context,
                      iosLikeRoute(HomeView()),
                    );
                  } catch (e) {
                    Navigator.pop(context);

                    if (!context.mounted) return;
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('فشل الاستيراد: ${e.toString()}')),
                    );
                  }
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

  /// ✅ إنشاء قاعدة جديدة
  Future<void> createDataBase() async {
    final db = await AppDb.instance.database;
    await markSetupDone();
    log('Database opened at: ${db.path}');
  }

  /// ✅ عرض لودينغ
  void _showLoading(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => const Center(child: CircularProgressIndicator()),
    );
  }
}
