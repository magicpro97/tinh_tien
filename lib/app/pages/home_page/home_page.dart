import 'dart:developer';

import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:flash/flash.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tinh_tien/app/blocs/home/bloc.dart';
import 'package:tinh_tien/app/pages/home_page/more_tab.dart';
import 'package:tinh_tien/app/pages/home_page/outstanding_tab.dart';
import 'package:tinh_tien/app/route.dart';
import 'package:tinh_tien/app/widgets/app_scaffold.dart';
import 'package:tinh_tien/app/widgets/loading_placeholder.dart';
import 'package:tinh_tien/common/colors.dart';
import 'package:tinh_tien/common/constants.dart';

import 'balance_tab.dart';
import 'expense_tab.dart';
import 'people_tab.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;
  final _tabs = [];
  HomeBloc _homeBloc;
  List<String> tabNames = const [
    "People",
    "Expense",
    "Balance",
    "Outstanding",
    "More"
  ];
  List<String> hintNames = const [
    PEOPLE_HINT,
    EXPENSES_HINT,
    BALANCE_HINT,
    OUTSTANDING_HINT
  ];

  void _onTapNavigationItem(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
    _homeBloc = BlocProvider.of<HomeBloc>(context);
    _homeBloc.connectionStatus.listen((status) {
      if (status == DataConnectionStatus.disconnected) {
        showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                content: Text('No network connection'),
                title: Row(
                  children: <Widget>[
                    Icon(
                      Icons.error,
                      color: Colors.red,
                    ),
                    Text(
                      'Error',
                      style: Theme.of(context)
                          .textTheme
                          .body1
                          .apply(color: Colors.red),
                    ),
                  ],
                ),
                actions: <Widget>[
                  FlatButton(
                    child: Text(
                      'OK',
                      style: Theme.of(context)
                          .textTheme
                          .button
                          .apply(color: AppColors.MAIN_COLOR),
                    ),
                    onPressed: () {
                      Navigator.pushNamedAndRemoveUntil(
                          context, WElCOME_PAGE, (route) => false);
                    },
                  )
                ],
              );
            });
      }
    });
    _homeBloc.add(GetActivity());
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      margin: const EdgeInsets.all(0.0),
      appBarAction: <Widget>[
        IconButton(
            icon: Icon(Icons.info),
            onPressed: () {
              showFlash(
                context: context,
                duration: const Duration(seconds: 5),
                builder: (_, controller) {
                  return Flash.dialog(
                    controller: controller,
                    alignment: const Alignment(0, -0.9),
                    margin: const EdgeInsets.symmetric(
                        horizontal: 16.0, vertical: 8.0),
                    borderRadius: const BorderRadius.all(Radius.circular(8.0)),
                    enableDrag: false,
                    backgroundColor: Colors.black87,
                    child: DefaultTextStyle(
                      style:
                          const TextStyle(fontSize: 16.0, color: Colors.white),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16.0, vertical: 8.0),
                        child: Text(
                          hintNames[_currentIndex].toString(),
                          style: TextStyle(fontSize: 14),
                        ),
                      ),
                    ),
                  );
                },
              );
            }),
      ],
      body: BlocListener(
        bloc: _homeBloc,
        listener: (_, state) {
          if (state is ErrorState) {
            log(state.message);
          } else if (state is PeopleCreatedState || state is DeletedPeopleState || state is EditedPeopleState) {
            _homeBloc.add(GetActivity());
          }
        },
        child: BlocBuilder(
          bloc: _homeBloc,
          builder: (context, state) {
            if (state is ActivityLoadedState) {
              final activity = state.activity;
              final peopleTab = PeopleTab(
                name: tabNames[0],
                activity: activity,
              );
              final expenseTab = ExpenseTab(
                name: tabNames[1],
                activity: activity,
              );
              final balanceTab = BalanceTab(
                name: tabNames[2],
                activity: activity,
                activitySummary: state.activitySummary,
              );
              final outstandingTab = OutstandingTab(
                name: tabNames[3],
                activity: activity,
                activitySharedExpenses: state.activitySharedExpenses,
              );
              final moreTab = MoreTab(
                name: tabNames[4],
                activity: activity,
              );
              _tabs.clear();
              _tabs.addAll(
                  [peopleTab, expenseTab, balanceTab, outstandingTab, moreTab]);
              return _tabs[_currentIndex];
            } else if (state is LoadingState) {
              return LoadingPlaceholder(
                title: tabNames[_currentIndex],
              );
            }

            return Container();
          },
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: _onTapNavigationItem,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.black,
        type: BottomNavigationBarType.fixed,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: Icon(Icons.people), title: Text("People")),
          BottomNavigationBarItem(
              icon: Icon(Icons.attach_money), title: Text('Expense')),
          BottomNavigationBarItem(
              icon: Icon(Icons.account_balance), title: Text('Balance')),
          BottomNavigationBarItem(
              icon: Icon(Icons.assignment), title: Text('Outstanding')),
          BottomNavigationBarItem(
              icon: Icon(Icons.more_horiz), title: Text('More')),
        ],
      ),
      bottom: StreamBuilder(
        stream: _homeBloc.connectionStatus,
        builder: (_, snapshot) {
          return Container(
            width: double.infinity,
            color: snapshot.data == DataConnectionStatus.disconnected
                ? Colors.red
                : Colors.white,
            child: BlocBuilder<HomeBloc, HomeState>(
              bloc: _homeBloc,
              builder: (context, state) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      state is ActivityLoadedState
                          ? state.activity.name
                          : "Welcome",
                      style: Theme.of(context).textTheme.title.apply(
                          color:
                              snapshot.data == DataConnectionStatus.disconnected
                                  ? Colors.white
                                  : Colors.black),
                    ),
                    if (snapshot.data == DataConnectionStatus.disconnected)
                      Text(
                        " - No network connection",
                        style: Theme.of(context)
                            .textTheme
                            .title
                            .apply(color: Colors.white),
                      ),
                  ],
                );
              },
            ),
          );
        },
      ),
    );
  }
}
