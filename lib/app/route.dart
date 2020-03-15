import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tinh_tien/app/blocs/people/bloc.dart';
import 'package:tinh_tien/app/data/models/activity/activity.dart';
import 'package:tinh_tien/app/inject_container.dart';
import 'package:tinh_tien/app/pages/expense_page/expense_page.dart';
import 'package:tinh_tien/app/pages/home_page/home_page.dart';
import 'package:tinh_tien/app/pages/share_page.dart';
import 'package:tinh_tien/app/pages/welcome_page/scan_qr_page.dart';
import 'package:tinh_tien/app/pages/welcome_page/welcome_page.dart';

import 'blocs/expense/bloc.dart';
import 'pages/flash_page.dart';
import 'pages/expense_page/expense_argument.dart';

var bootStage = 1;

RouteFactory routes(String lastActivityId) {
  return (settings) {
    Widget screen;
    bool fullScreen = false;

    if (bootStage == 1) {
      bootStage = 2;
      return PageRouteBuilder(
        pageBuilder: (_, __, ___) => FlashPage(lastActivityId),
      );
    }
    final arguments = settings.arguments as Map<String, dynamic> ?? {};
    switch (settings.name) {
      case WelcomePage.route:
        screen = WelcomePage();
        break;
      case HomePage.route:
        screen = MultiBlocProvider(
            providers: [
              BlocProvider<PeopleBloc>(
                create: (_) => sl(),
              ),
              BlocProvider<ExpenseBloc>(
                create: (_) => sl(),
              ),
            ],
            child: HomePage(
              activity: Activity.fromJson(arguments),
            ));
        break;
      case ExpensePage.route:
        screen = BlocProvider<ExpenseBloc>(
          create: (_) => sl(),
          child: ExpensePage(
            expenseArgument: ExpenseArgument.fromJson(arguments),
          ),
        );
        break;
      case ScanQRPage.route:
        screen = ScanQRPage();
        break;
      case SharePage.route:
        screen = SharePage(
          activity: Activity.fromJson(arguments),
        );
        break;
    }

    if (bootStage == 2) {
      bootStage = 3;
      return PageRouteBuilder(
        pageBuilder: (BuildContext context, _, __) {
          return screen;
        },
        transitionDuration: const Duration(milliseconds: 500),
      );
    }
    if (fullScreen) {
      return MaterialPageRoute(
        builder: (_) => screen,
        fullscreenDialog: true,
      );
    }

    return PageRouteBuilder(pageBuilder: (BuildContext context, _, __) {
      return screen;
    }, transitionsBuilder: (_, Animation<double> animation, __, Widget child) {
      return FadeTransition(opacity: animation, child: child);
    });
  };
}
