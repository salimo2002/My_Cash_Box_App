import 'package:cash_box/style/app_color.dart';
import 'package:cash_box/style/app_font.dart';
import 'package:cash_box/utils/ios_liked_route.dart';
import 'package:cash_box/views/accounts_view.dart';
import 'package:flutter/material.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(color: AppColor.primaryColor),
            child: Align(
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Cash Box V0.1',
                    style: AppFont.boldTextStyle(
                      context,
                      AppFont.h1,
                      Colors.white,
                    ),
                  ),
                  Text(
                    'By Salimo',
                    style: AppFont.boldTextStyle(
                      context,
                      AppFont.h3,
                      Color.fromARGB(164, 144, 185, 255),
                    ),
                  ),
                ],
              ),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.backup),
            title: const Text('نسخة احتياطية'),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.supervisor_account_sharp),
            title: const Text('الحسابات'),
            onTap: () {
              Navigator.push(context, iosLikeRoute(AccountsView()));
            },
          ),
        ],
      ),
    );
  }
}
