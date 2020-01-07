import 'package:flutter/material.dart';

import '../../common/dimens.dart';

class AppScaffold extends StatelessWidget {
  final Widget body;
  final Widget bottomNavigationBar;
  final List<Widget> appBarAction;
  final Widget bottom;

  const AppScaffold({
    Key key,
    @required this.body,
    this.bottomNavigationBar,
    @required this.appBarAction,
    this.bottom,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tinh tien'),
        actions: appBarAction,
        bottom: PreferredSize(
          child: bottom ?? Container(),
          preferredSize: Size.fromHeight(bottom == null ? 0 : 24.0),
        ),
      ),
      body: SafeArea(
          child: Container(
        padding: const EdgeInsets.fromLTRB(
          Dimens.NORMAL_PADDING,
          Dimens.NORMAL_PADDING,
          Dimens.NORMAL_PADDING,
          Dimens.ZERO,
        ),
        child: body,
      )),
      bottomNavigationBar: bottomNavigationBar,
    );
  }
}
