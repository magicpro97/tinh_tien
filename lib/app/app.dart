import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tinh_tien/app/blocs/welcome/welcome_bloc.dart';
import 'package:tinh_tien/app/route.dart';

import 'inject_container.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<WelcomeBloc>(
          create: (_) => sl(),
        ),
      ],
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
