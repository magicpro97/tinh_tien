import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:random_color/random_color.dart';
import 'package:tinh_tien/app/blocs/activity/bloc.dart';
import 'package:tinh_tien/app/data/models/activity/activity_summary.dart';
import 'package:tinh_tien/app/widgets/empty_list.dart';
import 'package:tinh_tien/common/colors.dart';
import 'package:tinh_tien/common/dimens.dart';

class BalanceTab extends StatelessWidget {
  final String name;

  const BalanceTab({
    Key key,
    @required this.name,
  }) : super(key: key);

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.debug}) {
    return name;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: BlocBuilder<ActivityBloc, ActivityState>(
          bloc: BlocProvider.of<ActivityBloc>(context),
          builder: (_, state) {
            return CustomScrollView(
              slivers: <Widget>[
                SliverAppBar(
                  expandedHeight: Dimens.EXPANDED_HEIGHT,
                  flexibleSpace: Container(
                    padding: const EdgeInsets.fromLTRB(
                      Dimens.NORMAL_PADDING,
                      Dimens.NORMAL_PADDING,
                      Dimens.NORMAL_PADDING,
                      Dimens.ZERO,
                    ),
                    child: BlocBuilder<ActivityBloc, ActivityState>(
                      bloc: BlocProvider.of<ActivityBloc>(context),
                      builder: (_, state) {
                        if (state is ActivityLoadedState &&
                            state.activitySummary.filteredExpenseSummary
                                .isNotEmpty) {
                          final _randomColor = RandomColor();
                          final pieCharDataList =
                              state.activitySummary.filteredExpenseSummary
                                  .map(
                                    (summary) => PieChartSectionData(
                                        radius: 100.0,
                                        value: summary.spent,
                                        color: _randomColor.randomColor(),
                                        showTitle: true,
                                        title: summary.name,
                                        titleStyle: Theme.of(context)
                                            .textTheme
                                            .title
                                            .copyWith(fontSize: 14)),
                                  )
                                  .toList();
                          return Card(
                            elevation: 10.0,
                            child: PieChart(
                              PieChartData(
                                sections: pieCharDataList,
                                centerSpaceRadius: 0.0,
                                sectionsSpace: 1.0,
                                borderData: FlBorderData(show: false),
                              ),
                            ),
                          );
                        }
                        return EmptyList();
                      },
                    ),
                  ),
                ),
                SliverAppBar(
                  title: Text('Balance'),
                  centerTitle: false,
                  floating: true,
                  snap: true,
                  pinned: true,
                  automaticallyImplyLeading: false,
                  actions: <Widget>[
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        Text(
                          'Total: ${state is ActivityLoadedState ? state.activity.totalExpense.toStringAsFixed(2) : 0}',
                          style: Theme.of(context).textTheme.subtitle.apply(
                                color: AppColors.WHITE_TEXT,
                              ),
                        ),
                        Text(
                            'Average: ${state is ActivityLoadedState ? state.activity.averageExpense.toStringAsFixed(2) : 0}',
                            style: Theme.of(context).textTheme.subtitle.apply(
                                  color: AppColors.WHITE_TEXT,
                                )),
                      ],
                    )
                  ],
                ),
                state is ActivityLoadedState &&
                        state.activitySummary.filteredExpenseSummary.isNotEmpty
                    ? SliverList(
                        delegate: SliverChildBuilderDelegate(
                            (_, index) => expenseSummaryItems(
                                context,
                                state.activitySummary
                                    .filteredExpenseSummary)[index],
                            childCount: state
                                .activitySummary.filteredExpenseSummary.length),
                      )
                    : SliverFillRemaining(child: EmptyList()),
              ],
            );
          }),
    );
  }

  List<Widget> expenseSummaryItems(
          BuildContext context, List<ExpenseSummary> expenseSummary) =>
      expenseSummary
          .map(
            (summary) => ListTile(
              title: Text(summary.name),
              subtitle: Row(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Icon(
                        Icons.arrow_drop_down,
                        color: Colors.red,
                      ),
                      Text('${summary.spent.toStringAsFixed(2)}'),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Icon(
                        Icons.arrow_drop_up,
                        color: Colors.green,
                      ),
                      Text('${summary.paid.toStringAsFixed(2)}'),
                    ],
                  ),
                ],
              ),
              trailing: Text(
                '${summary.amount.toStringAsFixed(2)}',
                style: Theme.of(context).textTheme.body1.apply(
                      color: summary.amount < 0 ? Colors.red : Colors.green,
                    ),
              ),
            ),
          )
          .toList();
}
