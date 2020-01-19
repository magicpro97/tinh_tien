import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:random_color/random_color.dart';
import 'package:tinh_tien/app/data/models/activity/activity.dart';
import 'package:tinh_tien/app/data/models/activity/activity_summary.dart';
import 'package:tinh_tien/app/widgets/app_tabview.dart';
import 'package:tinh_tien/app/widgets/empty_list.dart';
import 'package:tinh_tien/common/colors.dart';
import 'package:tinh_tien/common/dimens.dart';

class MoreTab extends StatelessWidget {
  final String name;
  final Activity activity;

  const MoreTab(
      {Key key,
      @required this.activity,
      @required this.name})
      : super(key: key);

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.debug}) {
    return name;
  }

  @override
  Widget build(BuildContext context) {
      return AppTabView(
        body: Expanded(
          child: ListView(
            children: <Widget>[
              ListTile(
                leading: Icon(Icons.remove),
                title: Text('Delete activity'),
              )
            ],
          ),
        ),
      );
  }
}
