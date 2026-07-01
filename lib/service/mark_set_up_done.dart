import 'package:shared_preferences/shared_preferences.dart';

Future<void> markSetupDone() async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setBool('isSetupDone', true);
}
