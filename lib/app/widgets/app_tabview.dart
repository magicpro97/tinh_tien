import 'package:flutter/material.dart';

class AppTabView extends StatelessWidget {
  final String title;
  final Widget body;

  const AppTabView({
    Key key,
    this.title,
    @required this.body,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
         title != null ? AppBar(
          title: Text(title),
          centerTitle: false,
         ) : Container(),
          body,
        ],
      ),
    );
  }
}
