import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
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
            SizedBox(
              height: Dimens.NORMAL_PADDING,
            ),
            CachedNetworkImage(
              imageUrl:
                  'https://www.filevine.com/wp-content/uploads/2018/02/expense-tracking.png',
              fit: BoxFit.cover,
              height: 150,
              width: 150,
            ),
            SizedBox(
              height: Dimens.NORMAL_PADDING,
            ),
            TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
              ),
            ),
            MaterialButton(
              onPressed: () {},
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
