import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tinh_tien/app/inject_container.dart';
import 'package:tinh_tien/common/constants.dart';

import 'app/app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await init();
  final prefs = sl<SharedPreferences>();
  runApp(App(lastActivityId: prefs.getString(ACTIVITY_ID)));
}
