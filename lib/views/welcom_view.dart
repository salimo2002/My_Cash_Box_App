import 'package:cash_box/style/app_font.dart';
import 'package:cash_box/utils/ios_liked_route.dart';
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
                onTap: () {
                  Navigator.push(context, iosLikeRoute(HomeView()));
                },
              ),
              const SizedBox(height: 12),
              OptionCard(
                icon: Icons.file_download_outlined,
                title: 'استيراد نسخة بيانات',
                subtitle: 'اختيار ملف قاعدة بيانات (db) من تخزين الجهاز',
                onTap: () {
                  Navigator.push(context, iosLikeRoute(HomeView()));
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
}
