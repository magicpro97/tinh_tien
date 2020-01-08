import 'package:flutter/material.dart';
import 'package:qr_mobile_vision/qr_camera.dart';
import 'package:tinh_tien/app/route.dart';
import 'package:tinh_tien/app/widgets/app_button.dart';
import 'package:tinh_tien/common/colors.dart';
import 'package:tinh_tien/common/dimens.dart';

class AlreadyHaveActivityPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: QrCamera(
        qrCodeCallback: (code) {},
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(Dimens.NORMAL_PADDING),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  height: kToolbarHeight,
                  child: Row(
                    children: <Widget>[
                      FlatButton.icon(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: Icon(
                          Icons.arrow_back,
                          color: Colors.white,
                        ),
                        label: Container(),
                      ),
                      Text(
                        'Scan your QR code',
                        style: Theme.of(context)
                            .textTheme
                            .title
                            .apply(color: AppColors.WHITE_TEXT),
                      ),
                    ],
                  ),
                ),
                Placeholder(
                  fallbackWidth: 300,
                  fallbackHeight: 300,
                ),
                SizedBox(
                  height: Dimens.NORMAL_PADDING,
                ),
                TextField(
                  decoration: InputDecoration(
                      fillColor: AppColors.MAIN_COLOR,
                      border: OutlineInputBorder(),
                      hintText: 'Type your activity id',
                      hintStyle: TextStyle(
                        color: AppColors.WHITE_TEXT,
                      )),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    AppButton(
                      onPressed: () {
                        Navigator.pushReplacementNamed(context, HOME_PAGE);
                      },
                      text: 'Enter',
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
