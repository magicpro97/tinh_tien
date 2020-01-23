import 'package:flutter/material.dart';

class AppLogo extends StatelessWidget {
  final double height;
  final double width;
  final BoxFit fit;

  const AppLogo({
    Key key,
    @required this.height,
    @required this.width,
    this.fit = BoxFit.cover,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      'assets/images/logo.png',
      fit: BoxFit.cover,
      height: height,
      width: width,
    );
  }
}
