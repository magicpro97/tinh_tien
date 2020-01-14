import 'package:flutter/material.dart';
import 'package:tinh_tien/app/inject_container.dart';

import 'app/app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await init();
  runApp(App());
}
