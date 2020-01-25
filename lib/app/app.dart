import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tinh_tien/app/blocs/activity/activity_bloc.dart';
import 'package:tinh_tien/app/route.dart';

import 'inject_container.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<ActivityBloc>(
      create: (_) => sl(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Tinh tien',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        routes: routes,
        initialRoute: WElCOME_PAGE,
      ),
    );
  }
}
