import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:flash/flash.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tinh_tien/app/blocs/activity/bloc.dart';
import 'package:tinh_tien/app/pages/home_page/more_tab.dart';
import 'package:tinh_tien/app/pages/home_page/outstanding_tab.dart';
import 'package:tinh_tien/app/route.dart';
import 'package:tinh_tien/app/widgets/app_scaffold.dart';
import 'package:tinh_tien/app/widgets/loading_placeholder.dart';
import 'package:tinh_tien/common/colors.dart';
import 'package:tinh_tien/common/constants.dart';
import 'package:tinh_tien/common/dimens.dart';

import '../../inject_container.dart';
import 'balance_tab.dart';
import 'expense_tab.dart';
import 'people_tab.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ActivityBloc _activityBloc;
  DataConnectionChecker _dataConnectionChecker;
  int _currentIndex = 0;
  final _tabs = [];
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
    _activityBloc = BlocProvider.of<ActivityBloc>(context);
    _activityBloc.add(GetActivityEvent());
    _dataConnectionChecker = sl<DataConnectionChecker>();
    _dataConnectionChecker.onStatusChange.listen((status) {
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
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      margin: const EdgeInsets.all(Dimens.ZERO),
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
      body: BlocBuilder<ActivityBloc, ActivityState>(
        bloc: _activityBloc,
        builder: (context, state) {
          if (state is ActivityLoadingState) {
            return LoadingPlaceholder(
              title: tabNames[_currentIndex],
            );
          }
          final peopleTab = PeopleTab(
            name: tabNames[0],
          );
          final expenseTab = ExpenseTab(
            name: tabNames[1],
          );
          final balanceTab = BalanceTab(
            name: tabNames[2],
          );
          final outstandingTab = OutstandingTab(
            name: tabNames[3],
          );
          final moreTab = MoreTab(
            name: tabNames[4],
          );
          _tabs.clear();
          _tabs.addAll([
            peopleTab,
            expenseTab,
            balanceTab,
            outstandingTab,
            moreTab,
          ]);
          return _tabs[_currentIndex];
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: _onTapNavigationItem,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.black,
        type: BottomNavigationBarType.fixed,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: Icon(Icons.people), title: Text(tabNames[0])),
          BottomNavigationBarItem(
              icon: Icon(Icons.attach_money), title: Text(tabNames[1])),
          BottomNavigationBarItem(
              icon: Icon(Icons.account_balance), title: Text(tabNames[2])),
          BottomNavigationBarItem(
              icon: Icon(Icons.assignment), title: Text(tabNames[3])),
          BottomNavigationBarItem(
              icon: Icon(Icons.more_horiz), title: Text(tabNames[4])),
        ],
      ),
      bottom: StreamBuilder(
        stream: _dataConnectionChecker.onStatusChange,
        builder: (_, snapshot) {
          return Container(
            width: double.infinity,
            color: snapshot.data == DataConnectionStatus.disconnected
                ? Colors.red
                : Colors.white,
            child: BlocBuilder<ActivityBloc, ActivityState>(
              bloc: _activityBloc,
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
