import 'package:flutter/material.dart';
import 'package:tinh_tien/app/route.dart';
import 'package:tinh_tien/app/widgets/app_logo.dart';
import 'package:tinh_tien/common/colors.dart';
import 'package:tinh_tien/common/dimens.dart';

class WelcomePage extends StatefulWidget {
  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding:
              const EdgeInsets.symmetric(horizontal: Dimens.NORMAL_PADDING),
          child: Column(
            children: <Widget>[
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: Dimens.NORMAL_PADDING),
                child: AppLogo(
                  height: 150,
                  width: 150,
                ),
              ),
              Text(
                'Tinh Tien',
                style: Theme.of(context).textTheme.display1.apply(
                      color: AppColors.MAIN_COLOR,
                    ),
              ),
              Text(
                'Manage team expenses',
                style: Theme.of(context).textTheme.headline,
              ),
              SizedBox(
                height: Dimens.LARGE_PADDING,
              ),
              TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "Your activity's name",
                ),
              ),
              SizedBox(
                height: Dimens.LARGE_PADDING,
              ),
              MaterialButton(
                onPressed: () {
                  Navigator.pushNamed(context, HOME_PAGE);
                },
                child: Text(
                  'CREATE YOUR ACTIVITY',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                color: Colors.blue,
              ),
              FlatButton(
                onPressed: () {
                  Navigator.pushNamed(context, ALREADY_HAVE_ACTIVITY_PAGE);
                },
                child: Text(
                  'I HAVE ACTIVITY ALREADY',
                  style: TextStyle(color: AppColors.MAIN_COLOR),
                ),
              ),
              Expanded(
                child: Container(),
              ),
              Text('Linh đẹp trai'),
            ],
          ),
        ),
      ),
    );
  }
}
