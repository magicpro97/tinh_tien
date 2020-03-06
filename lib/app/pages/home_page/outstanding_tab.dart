import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tinh_tien/app/blocs/activity/bloc.dart';
import 'package:tinh_tien/app/data/models/activity/activity_shared_expenses.dart';
import 'package:tinh_tien/app/widgets/app_tabview.dart';
import 'package:tinh_tien/app/widgets/empty_list.dart';
import 'package:tinh_tien/common/dimens.dart';

class OutstandingTab extends StatelessWidget {
  final String name;

  const OutstandingTab({
    Key key,
    this.name,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppTabView(
      title: 'Outstanding',
      body: Padding(
        padding: const EdgeInsets.fromLTRB(
          Dimens.NORMAL_PADDING,
          Dimens.SMALL_PADDING,
          Dimens.NORMAL_PADDING,
          0,
        ),
        child: BlocBuilder<ActivityBloc, ActivityState>(
          bloc: BlocProvider.of<ActivityBloc>(context),
          builder: (_, state) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Card(
                  elevation: 10.0,
                  child: Padding(
                    child: Text(
                        'Total transaction: ${state is ActivityLoadedState ? state.activitySharedExpenses.sharedExpenses?.length ?? 0 : 0}'),
                    padding: const EdgeInsets.all(Dimens.NORMAL_PADDING),
                  ),
                ),
                Expanded(
                  child: state is ActivityLoadedState
                      ? state.activitySharedExpenses.sharedExpenses.isEmpty
                          ? EmptyList()
                          : Card(
                              elevation: 10.0,
                              child: ListView.builder(
                                itemBuilder: (context, index) =>
                                    _sharedExpensesItem(context, index,
                                        state.activitySharedExpenses),
                                itemCount: state.activitySharedExpenses
                                    .sharedExpenses.length,
                              ),
                            )
                      : EmptyList(),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _sharedExpensesItem(BuildContext context, int index,
      ActivitySharedExpenses activitySharedExpenses) {
    final paidBy = activitySharedExpenses.sharedExpenses[index].paidBy.name;
    final paidFor = activitySharedExpenses.sharedExpenses[index].paidFor.name;
    final amount = activitySharedExpenses.sharedExpenses[index].amount;

    return ListTile(
        title: RichText(
            text: TextSpan(
      style: DefaultTextStyle.of(context).style,
      children: [
        TextSpan(text: paidBy, style: TextStyle(color: Colors.blue)),
        TextSpan(text: ' gives '),
        TextSpan(
            text: ' ${amount.toStringAsFixed(2)}',
            style: TextStyle(color: Colors.green)),
        TextSpan(text: ' to '),
        TextSpan(text: paidFor, style: TextStyle(color: Colors.red)),
      ],
    )));
  }
}
