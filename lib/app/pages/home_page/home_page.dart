import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tinh_tien/app/blocs/home/bloc.dart';
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
  int _currentIndex = 0;
  final _tabs = [];
  HomeBloc _homeBloc;

  void _onTapNavigationItem(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
    _homeBloc = BlocProvider.of<HomeBloc>(context);
    _homeBloc.add(GetActivity());
  }

  @override
  void dispose() {
    _homeBloc.close();
    super.dispose();
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
      body: BlocBuilder(
        bloc: _homeBloc,
        builder: (context, state) {
          if (state is ActivityLoadedState) {
            final activity = state.activity;
            final peopleTab = PeopleTab(
              activity: activity,
            );
            final expenseTab = ExpenseTab(
              activity: activity,
            );
            final balanceTab = BalanceTab(
              activity: activity,
            );
            final outstandingTab = OutstandingTab(
              activity: activity,
            );
            _tabs.clear();
            _tabs.addAll([
              peopleTab,
              expenseTab,
              balanceTab,
              outstandingTab,
            ]);
            return _tabs[_currentIndex];
          }

          return Container();
        },
      ),
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
        child: BlocBuilder<HomeBloc, HomeState>(
          bloc: _homeBloc,
          builder: (coantext, state) {
            return Text(
              state is ActivityLoadedState ? state.activity.name : "Welcome",
              style: Theme.of(context).textTheme.title,
            );
          },
        ),
      ),
    );
  }
}
