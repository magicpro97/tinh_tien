import 'package:flutter/material.dart';
import 'package:tinh_tien/app/pages/main_page/main_page.dart';
import 'package:tinh_tien/app/widgets/app_logo.dart';
import 'package:tinh_tien/common/colors.dart';
import 'package:tinh_tien/common/dimens.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
                  Navigator.pushReplacement(
                      context, MaterialPageRoute(builder: (_) => MainPage()));
                },
                child: Text(
                  'CREATE YOUR ACTIVITY',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                color: Colors.blue,
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
