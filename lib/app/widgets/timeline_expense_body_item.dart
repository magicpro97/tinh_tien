import 'package:flutter/material.dart';
import 'package:tinh_tien/app/widgets/expense_item.dart';

class TimeLineExpenseBodyItem extends StatelessWidget {
  final String title;
  final List<ExpenseItem> expenseItems;

  const TimeLineExpenseBodyItem({
    Key key,
    @required this.title,
    @required this.expenseItems,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Card(
        elevation: 10.0,
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Text(
                title,
                style: Theme.of(context).textTheme.title,
              ),
            ),
            ListView.builder(
              shrinkWrap: true,
              itemBuilder: (_, index) => expenseItems[index],
              itemCount: expenseItems.length,
              physics: NeverScrollableScrollPhysics(),
            ),
          ],
        ),
      ),
    );
  }
}
