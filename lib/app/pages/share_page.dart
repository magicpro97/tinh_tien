import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:tinh_tien/app/widgets/app_button.dart';
import 'package:tinh_tien/common/colors.dart';
import 'package:tinh_tien/common/dimens.dart';

class SharePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: Dimens.NORMAL_PADDING,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              QrImage(data: 'aaaaaaaa'),
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
      ),
    );
  }
}
