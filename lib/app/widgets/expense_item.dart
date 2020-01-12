import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:tinh_tien/app/data/models/expense/expense.dart';

import 'action_item.dart';

class ExpenseItem extends StatelessWidget {
  final Expense expense;

  const ExpenseItem({Key key, @required this.expense}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Slidable(
      key: Key(expense.id),
      child: ListTile(
        title: Row(
          children: <Widget>[
            Text(
              expense.paidBy.toString(),
              style: TextStyle(color: Colors.red),
            ),
            Text('paid '),
            Text(
              '${expense.amount}',
              style: TextStyle(color: Colors.blueAccent),
            ),
            Text('for '),
            Text(
              expense.people.toString(),
              style: TextStyle(color: Colors.green),
            ),
            Expanded(
              child: Container(),
            ),
          ],
        ),
        subtitle: Text('at ${expense.createdAt}'),
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
      secondaryActions: defaultActionItems,
      dismissal: defaultDismissal(
        context,
        'Expense will be deteled',
        'Expense is deleted',
      ),
    );
  }
}
