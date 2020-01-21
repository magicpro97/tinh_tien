import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tinh_tien/app/blocs/home/bloc.dart';
import 'package:tinh_tien/app/blocs/home/home_bloc.dart';
import 'package:tinh_tien/app/data/models/activity/activity.dart';
import 'package:tinh_tien/app/route.dart';
import 'package:tinh_tien/app/widgets/app_tabview.dart';

class MoreTab extends StatefulWidget {
  final String name;
  final Activity activity;

  const MoreTab({Key key, @required this.activity, @required this.name})
      : super(key: key);

  @override
  _MoreTabState createState() => _MoreTabState();

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.debug}) {
    return name;
  }
}

class _MoreTabState extends State<MoreTab> {
  HomeBloc _homeBloc;

  @override
  void initState() {
    super.initState();
    _homeBloc = BlocProvider.of<HomeBloc>(context);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final activityId = widget.activity.id;

    return AppTabView(
      body: Expanded(
        child: ListView(
          children: <Widget>[
            ListTile(
              leading: Icon(Icons.delete_forever),
              title: Text(
                'Delete activity',
                style: TextStyle(fontSize: 20),
              ),
              onTap: () {
                log(activityId, name: 'MoreTab');
                showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                          title: Text("Confirm"),
                          content: Text(
                              'You are about to delete activity "${widget.activity.name}". \nAre you sure want to continue?'),
                          actions: <Widget>[
                            FlatButton(
                              child: Text('Cancel',  style: Theme.of(context).textTheme.button.apply(color: Colors.red)),
                              onPressed: Navigator.of(context).pop,
                            ),
                            FlatButton(
                              child: Text('OK', style: Theme.of(context).textTheme.button.apply(color: Colors.blue),),
                              onPressed: () {
                                _homeBloc.add(DeleteActivityEvent(activityId));
                                Navigator.pushNamed(context, WElCOME_PAGE);
                              },
                            )
                          ],
                        ));
              },
            )
          ],
        ),
      ),
    );
  }
}
