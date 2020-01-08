import 'package:flutter/material.dart';
import 'package:tinh_tien/app/pages/welcome_page.dart';
import 'package:tinh_tien/app/route.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Tinh tien',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: WelcomePage(),
      routes: routes,
    );
  }
}
