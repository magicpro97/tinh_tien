import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tinh_tien/app/blocs/people/bloc.dart';
import 'package:tinh_tien/app/inject_container.dart';
import 'package:tinh_tien/app/pages/expense_page/expense_page.dart';
import 'package:tinh_tien/app/pages/home_page/home_page.dart';
import 'package:tinh_tien/app/pages/share_page.dart';
import 'package:tinh_tien/app/pages/welcome_page/already_have_activity_page.dart';
import 'package:tinh_tien/app/pages/welcome_page/welcome_page.dart';

import 'blocs/expense/bloc.dart';

const WElCOME_PAGE = "/";
const HOME_PAGE = "/home";
const EXPENSE_PAGE = "/expense";
const ALREADY_HAVE_ACTIVITY_PAGE = "/already";
const SHARE_PAGE = "/share";

final routes = {
  WElCOME_PAGE: (context) => WelcomePage(),
  HOME_PAGE: (context) =>
      MultiBlocProvider(providers: [
        BlocProvider<PeopleBloc>(
          create: (_) => sl(),
        ),
        BlocProvider<ExpenseBloc>(
          create: (_) => sl(),
        ),
      ], child: HomePage()),
  EXPENSE_PAGE: (context) =>
      BlocProvider<ExpenseBloc>(
        create: (_) => sl(),
        child: ExpensePage(),
      ),
  ALREADY_HAVE_ACTIVITY_PAGE: (context) => AlreadyHaveActivityPage(),
  SHARE_PAGE: (context) => SharePage(),
};
