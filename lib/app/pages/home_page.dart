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
      appBarAction: <Widget>[
        Center(
          child: Text('Manage team expenses'),
        ),
      ],
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Column(
          children: <Widget>[
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: Dimens.NORMAL_PADDING),
              child: AppLogo(
                height: 150.0,
                width: 150.0,
              ),
            ),
            TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Your activity's name",
              ),
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
            Text('Linh đẹp trai'),
          ],
        ),
      ),
    );
  }
}
