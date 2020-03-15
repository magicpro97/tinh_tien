import 'package:flash/flash.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:tinh_tien/app/data/models/activity/activity.dart';
import 'package:tinh_tien/app/widgets/app_button.dart';
import 'package:tinh_tien/common/colors.dart';
import 'package:tinh_tien/common/dimens.dart';

class SharePage extends StatelessWidget {
  final Activity activity;
  static const route = '/share';

  const SharePage({Key key, @required this.activity}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Builder(builder: (context) {
        return SafeArea(
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: Dimens.NORMAL_PADDING,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(activity.id),
                    IconButton(
                      onPressed: () => _onCopyClick(context, activity),
                      icon: Icon(
                        Icons.content_copy,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: Dimens.NORMAL_PADDING,
                ),
                QrImage(data: activity.id),
                SizedBox(
                  height: Dimens.NORMAL_PADDING,
                ),
                AppButton(
                  text: 'Send a invite link',
                  onPressed: () {},
                ),
                FlatButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text(
                      'Back',
                      style: Theme.of(context)
                          .textTheme
                          .button
                          .apply(color: AppColors.MAIN_COLOR),
                    ))
              ],
            ),
          ),
        );
      }),
    );
  }

  void _onCopyClick(BuildContext context, Activity activity) {
    Clipboard.setData(ClipboardData(text: activity.id)).then((data) {
      showFlash(
        context: context,
        duration: const Duration(seconds: 3),
        builder: (_, controller) {
          return Flash.dialog(
            controller: controller,
            alignment: const Alignment(0, -0.9),
            margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            borderRadius: const BorderRadius.all(Radius.circular(8.0)),
            enableDrag: false,
            backgroundColor: Colors.black87,
            child: DefaultTextStyle(
              style: const TextStyle(fontSize: 16.0, color: Colors.white),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: Text('Copied'),
              ),
            ),
          );
        },
      );
    });
  }
}
