import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:tinh_tien/app/pages/expense_page/expense_page.dart';
import 'package:tinh_tien/app/widgets/action_item.dart';
import 'package:tinh_tien/app/widgets/app_tabview.dart';
import 'package:tinh_tien/common/dimens.dart';

class ExpenseTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AppTabView(
      title: 'Expenses',
      body: Expanded(
        child: Scaffold(
          body: Container(
            color: Colors.white,
            child: SingleChildScrollView(
              padding:
                  const EdgeInsets.symmetric(horizontal: Dimens.NORMAL_PADDING),
              child: Column(
                children: <Widget>[_buildExpenseItem(context)],
              ),
            ),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (_) => ExpensePage()));
            },
            child: Icon(Icons.add),
          ),
        ),
      ),
    );
  }

  Widget _buildExpenseItem(BuildContext context) {
    return Slidable(
      key: Key('aa'),
      child: ListTile(
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
      ),
      actionPane: SlidableDrawerActionPane(),
      secondaryActions: defaultActionItems,
      dismissal: defaultDismissal(
          context, 'Expense will be deteled', 'Expense is deleted'),
    );
  }
}
