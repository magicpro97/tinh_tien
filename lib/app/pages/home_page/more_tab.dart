import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tinh_tien/app/blocs/activity/bloc.dart';
import 'package:tinh_tien/app/route.dart';
import 'package:tinh_tien/app/widgets/app_tabview.dart';

class MoreTab extends StatefulWidget {
  final String name;

  const MoreTab({Key key, @required this.name}) : super(key: key);

  @override
  _MoreTabState createState() => _MoreTabState();

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.debug}) {
    return name;
  }
}

class _MoreTabState extends State<MoreTab> {
  ActivityBloc _activityBloc;

  @override
  void initState() {
    super.initState();
    _activityBloc = BlocProvider.of<ActivityBloc>(context);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AppTabView(
      body: BlocBuilder<ActivityBloc, ActivityState>(
        bloc: _activityBloc,
        builder: (_, state) =>
            ListView(
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
                        builder: (context) =>
                            AlertDialog(
                              title: Text("Confirm"),
                              content: Text(
                                  'You are about to delete activity "${state
                                      .activity
                                      .name}". \nAre you sure want to continue?'),
                              actions: <Widget>[
                                FlatButton(
                                  child: Text('Cancel',
                                      style: Theme
                                          .of(context)
                                          .textTheme
                                          .button
                                          .apply(color: Colors.red)),
                                  onPressed: Navigator
                                      .of(context)
                                      .pop,
                                ),
                                FlatButton(
                                  child: Text(
                                    'OK',
                                    style: Theme
                                        .of(context)
                                        .textTheme
                                        .button
                                        .apply(color: Colors.blue),
                                  ),
                                  onPressed: () {
                                    _activityBloc.add(DeleteActivityEvent(
                                        state.activity.id));
                                    Navigator.pushNamedAndRemoveUntil(context,
                                        WElCOME_PAGE, (route) => false);
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
