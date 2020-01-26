import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:tinh_tien/app/data/models/activity/activity.dart';
import 'package:tinh_tien/app/data/models/expense/expense.dart';
import 'package:tinh_tien/app/pages/expense_page/expense_argument.dart';
import 'package:tinh_tien/common/dimens.dart';

import '../route.dart';
import '../utils.dart';
import 'action_item.dart';

class ExpenseItem extends StatelessWidget {
  final Activity activity;
  final Expense expense;
  final Function onDeleted;

  const ExpenseItem({
    Key key,
    @required this.expense,
    @required this.activity,
    @required this.onDeleted,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Slidable(
      key: Key(expense.id),
      child: Card(
        elevation: Dimens.ZERO,
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
          // trailing: Column(
          //   mainAxisAlignment: MainAxisAlignment.spaceAround,
          //   children: <Widget>[
          //     Icon(
          //       Icons.lens,
          //       size: 16.0,
          //     ),
          //     Text('pending'),
          //   ],
          // ),
        ),
      ),
      actionPane: const SlidableDrawerActionPane(),
      secondaryActions: defaultActionItems(() {
        Navigator.pushNamed(context, EXPENSE_PAGE,
            arguments: ExpenseArgument(activity, expense));
      }, onDeleted),
      dismissal: defaultDismissal(
        context,
        'Expense will be deteled',
        'Expense is deleted',
        onDeleted,
      ),
    );
  }
}
