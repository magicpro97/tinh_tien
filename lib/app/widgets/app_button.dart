import 'package:flutter/material.dart';
import 'package:tinh_tien/common/colors.dart';

class AppButton extends StatelessWidget {
  final String text;
  final Function onPressed;

  const AppButton({
    Key key,
    @required this.text,
    @required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      child: Text(
        text,
        style: TextStyle(color: AppColors.WHITE_TEXT),
      ),
      onPressed: onPressed,
      color: AppColors.MAIN_COLOR,
    );
  }
}
