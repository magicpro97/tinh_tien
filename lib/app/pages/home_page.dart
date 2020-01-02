import 'package:flutter/material.dart';
import 'package:tinh_tien/app/pages/main_page/main_page.dart';
import 'package:tinh_tien/app/widgets/app_logo.dart';
import 'package:tinh_tien/app/widgets/app_scaffold.dart';
import 'package:tinh_tien/common/dimens.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      body: Column(
        children: <Widget>[
          Padding(
            padding:
                const EdgeInsets.symmetric(vertical: Dimens.NORMAL_PADDING),
            child: AppLogo(
              height: 150.0,
              width: 150.0,
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
    );
  }
}
