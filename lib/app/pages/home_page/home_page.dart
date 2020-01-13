import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tinh_tien/app/blocs/home/bloc.dart';
import 'package:tinh_tien/app/data/models/activity/activity.dart';
import 'package:tinh_tien/app/pages/home_page/outstanding_tab.dart';
import 'package:tinh_tien/app/widgets/app_scaffold.dart';

import 'balance_tab.dart';
import 'expense_tab.dart';
import 'people_tab.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  void _onTapNavigationItem(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  int _currentIndex = 0;
  Activity _activity;
  final _tabs = [];
  HomeBloc _homeBloc;

  @override
  void initState() {
    super.initState();
    _homeBloc = BlocProvider.of<HomeBloc>(context);
  }

  @override
  void dispose() {
    _homeBloc.close();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _activity = ModalRoute
        .of(context)
        .settings
        .arguments as Activity;
    _tabs.clear();
    _tabs.addAll([
      PeopleTab(
        activity: _activity,
      ),
      ExpenseTab(
        activity: _activity,
      ),
      BalanceTab(
        activity: _activity,
      ),
      OutstandingTab(
        activity: _activity,
      ),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      margin: const EdgeInsets.all(0.0),
      appBarAction: <Widget>[
        Row(
          children: <Widget>[
            IconButton(icon: Icon(Icons.info), onPressed: () {}),
          ],
        )
      ],
      body: _tabs[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: _onTapNavigationItem,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.black,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: Icon(Icons.people), title: Text('People')),
          BottomNavigationBarItem(
              icon: Icon(Icons.attach_money), title: Text('Expense')),
          BottomNavigationBarItem(
              icon: Icon(Icons.account_balance), title: Text('Balance')),
          BottomNavigationBarItem(
              icon: Icon(Icons.assignment), title: Text('Outstanding')),
        ],
      ),
      bottom: Container(
        width: double.infinity,
        color: Colors.white,
        alignment: Alignment.center,
        child: Text(
          _activity.name,
          style: Theme
              .of(context)
              .textTheme
              .title,
        ),
      ),
    );
  }
}
