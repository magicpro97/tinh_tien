import 'package:flutter/material.dart';
import 'package:tinh_tien/common/colors.dart';
import 'package:tinh_tien/common/dimens.dart';

class AppTabView extends StatelessWidget {
  final String title;
  final Widget body;

  const AppTabView({
    Key key,
    @required this.title,
    @required this.body,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(Dimens.NORMAL_PADDING),
            child: Text(
              title,
              style: Theme
                  .of(context)
                  .textTheme
                  .title
                  .apply(
                color: AppColors.MAIN_COLOR,
                decoration: TextDecoration.underline,
              ),
            ),
          ),
          body,
        ],
      ),
    );
  }
}
