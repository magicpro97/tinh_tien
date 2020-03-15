import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tinh_tien/app/route.dart';

import 'blocs/activity/activity_bloc.dart';
import 'inject_container.dart';

class App extends StatelessWidget {
  final String lastActivityId;
  const App({Key key, this.lastActivityId}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Tinh tien',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        onGenerateRoute: routes(lastActivityId),
      ), value: sl<ActivityBloc>(),
    );
  }
}
