import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:tinh_tien/app/data/models/expense/expense.dart';

import '../utils.dart';
import 'action_item.dart';

class ExpenseItem extends StatelessWidget {
  final Expense expense;

  const ExpenseItem({Key key, @required this.expense}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Slidable(
      key: Key(expense.id),
      child: ListTile(
        title: RichText(
          text: TextSpan(
            style: DefaultTextStyle.of(context).style,
            children: [
              TextSpan(
                text: expense.paidBy.join(", "),
                style: TextStyle(color: Colors.red),
              ),
              TextSpan(text: ' paid '),
              TextSpan(
                text: '${expense.amount}',
                style: TextStyle(color: Colors.blueAccent),
              ),
              TextSpan(text: ' for '),
              TextSpan(
                text: expense.people.join(", "),
                style: TextStyle(color: Colors.green),
              ),
            ],
          ),
        ),
        subtitle: Text('at ${DateUtils.toTime(expense.createdAt)}'),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Icon(
              Icons.lens,
              size: 16.0,
            ),
            Text('pending'),
          ],
        ),
      ),
      actionPane: SlidableDrawerActionPane(),
      secondaryActions: defaultActionItems(() {
        log(expense.id);
      }, () {
        log(expense.id);
      }),
      dismissal: defaultDismissal(
          context, 'Expense will be deteled', 'Expense is deleted'),
    );
  }
}
