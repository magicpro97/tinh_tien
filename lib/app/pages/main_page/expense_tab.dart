import 'package:flutter/material.dart';
import 'package:tinh_tien/app/pages/expense_page/expense_page.dart';
import 'package:tinh_tien/common/dimens.dart';

class ExpenseTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: SingleChildScrollView(
          padding:
              const EdgeInsets.symmetric(horizontal: Dimens.NORMAL_PADDING),
          child: Column(
            children: <Widget>[
              ListTile(
                leading: Icon(Icons.subdirectory_arrow_left),
                title: Row(
                  children: <Widget>[
                    Text(
                      'dđ ',
                      style: TextStyle(color: Colors.red),
                    ),
                    Text('paid '),
                    Text(
                      '423,423 ',
                      style: TextStyle(color: Colors.blueAccent),
                    ),
                    Text('for '),
                    Text(
                      'gghg.',
                      style: TextStyle(color: Colors.green),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (_) => ExpensePage()));
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
