import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tinh_tien/app/blocs/activity/bloc.dart';
import 'package:tinh_tien/app/data/models/activity/activity.dart';
import 'package:tinh_tien/app/pages/welcome_page/welcome_page.dart';
import 'package:tinh_tien/app/widgets/app_tabview.dart';

class MoreTab extends StatelessWidget {
  final Activity activity;

  const MoreTab({Key key, @required this.activity}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppTabView(
      body: BlocBuilder<ActivityBloc, ActivityState>(
        bloc: BlocProvider.of<ActivityBloc>(context),
        builder: (_, state) => ListView(
          children: <Widget>[
            ListTile(
              leading: Icon(Icons.delete_forever),
              title: Text(
                'Delete activity',
                style: TextStyle(fontSize: 20),
              ),
              onTap: state is ActivityLoadedState
                  ? () {
                      showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                                title: Text("Confirm"),
                                content: Text(
                                    'You are about to delete activity "${state.activity.name}". \nAre you sure want to continue?'),
                                actions: <Widget>[
                                  FlatButton(
                                    child: Text('Cancel',
                                        style: Theme.of(context)
                                            .textTheme
                                            .button
                                            .apply(color: Colors.red)),
                                    onPressed: Navigator.of(context).pop,
                                  ),
                                  FlatButton(
                                    child: Text(
                                      'OK',
                                      style: Theme.of(context)
                                          .textTheme
                                          .button
                                          .apply(color: Colors.blue),
                                    ),
                                    onPressed: () {
                                      BlocProvider.of<ActivityBloc>(context)
                                          .add(
                                              DeleteActivity(activity.id));
                                      Navigator.pushNamedAndRemoveUntil(context,
                                          WelcomePage.route, (route) => false);
                                    },
                                  )
                                ],
                              ));
                    }
                  : null,
            )
          ],
        ),
      ),
    );
  }
}
