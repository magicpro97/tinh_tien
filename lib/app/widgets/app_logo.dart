import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';

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
    return FadeInImage.memoryNetwork(
      image:
          'https://www.filevine.com/wp-content/uploads/2018/02/expense-tracking.png',
      placeholder: kTransparentImage,
      fit: fit,
      height: height,
      width: width,
    );
  }
}
