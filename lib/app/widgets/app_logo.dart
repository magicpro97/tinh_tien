import 'package:cached_network_image/cached_network_image.dart';
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
    return CachedNetworkImage(
      imageUrl:
          'https://www.filevine.com/wp-content/uploads/2018/02/expense-tracking.png',
      fit: fit,
      height: height,
      width: width,
    );
  }
}
