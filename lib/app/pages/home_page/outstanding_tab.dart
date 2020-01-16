import 'package:flutter/material.dart';
import 'package:tinh_tien/app/data/models/activity/activity.dart';
import 'package:tinh_tien/app/data/models/activity/activity_shared_expenses.dart';
import 'package:tinh_tien/app/widgets/app_tabview.dart';
import 'package:tinh_tien/app/widgets/empty_list.dart';
import 'package:tinh_tien/common/dimens.dart';

class OutstandingTab extends StatelessWidget {
  final String name;
  final Activity activity;
  final ActivitySharedExpenses activitySharedExpenses;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.debug}) {
    return name;
  }

  const OutstandingTab({
    Key key,
    @required this.activity,
    this.name,
    @required this.activitySharedExpenses,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppTabView(
      title: 'Outstanding',
      body: Expanded(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(
            Dimens.NORMAL_PADDING,
            Dimens.SMALL_PADDING,
            Dimens.NORMAL_PADDING,
            0,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Card(
                elevation: 10.0,
                child: Padding(
                  child: Text(
                      'Total transaction: ${activitySharedExpenses
                          .sharedExpenses?.length ?? 0}'),
                  padding: const EdgeInsets.all(Dimens.NORMAL_PADDING),
                ),
              ),
              Expanded(
                child: activitySharedExpenses.sharedExpenses.isEmpty
                    ? EmptyList()
                    : ListView.builder(
                  itemBuilder: _sharedExpensesItem,
                  itemCount: activitySharedExpenses.sharedExpenses.length,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _sharedExpensesItem(BuildContext context, int index) {
    final paidBy =
        activitySharedExpenses.sharedExpenses[index].paidBy?.first?.name ?? '';
    final paidFor =
        activitySharedExpenses.sharedExpenses[index].paidFor?.first?.name ?? '';
    final amount = activitySharedExpenses.sharedExpenses[index].amount;

    return ListTile(
        title: RichText(
            text: TextSpan(
              style: DefaultTextStyle
                  .of(context)
                  .style,
              children: [
                TextSpan(text: paidBy, style: TextStyle(color: Colors.blue)),
                TextSpan(text: ' paid for '),
                TextSpan(text: paidFor, style: TextStyle(color: Colors.red)),
                TextSpan(
                    text: ' $amount', style: TextStyle(color: Colors.green)),
              ],
            )));
  }
}
