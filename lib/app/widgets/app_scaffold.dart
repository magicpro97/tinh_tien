import 'package:flutter/material.dart';
import 'package:tinh_tien/app/widgets/app_logo.dart';

class AppScaffold extends StatelessWidget {
  final Widget body;
  final Widget bottomNavigationBar;
  final List<Widget> appBarAction;

  const AppScaffold({
    Key key,
    this.body,
    this.bottomNavigationBar,
    this.appBarAction,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: AppLogo(height: 16.0, width: 16.0),
        title: Text('Tinh tien'),
        actions: appBarAction,
      ),
      body: body,
      bottomNavigationBar: bottomNavigationBar,
    );
  }
}
