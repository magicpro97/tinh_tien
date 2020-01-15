import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoadingPlaceholder extends StatelessWidget {
  final String title;

  const LoadingPlaceholder({Key key, @required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          AppBar(
            title: Text(title),
            centerTitle: false,
          ),
          LinearProgressIndicator(),
        ],
      ),
    );
  }
}
