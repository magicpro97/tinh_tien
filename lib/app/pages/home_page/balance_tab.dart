import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:random_color/random_color.dart';
import 'package:tinh_tien/app/data/models/activity/activity.dart';
import 'package:tinh_tien/app/data/models/activity/activity_summary.dart';
import 'package:tinh_tien/app/widgets/empty_list.dart';
import 'package:tinh_tien/common/colors.dart';
import 'package:tinh_tien/common/dimens.dart';

class BalanceTab extends StatelessWidget {
  final String name;
  final Activity activity;
  final ActivitySummary activitySummary;

  const BalanceTab(
      {Key key,
      @required this.activity,
      @required this.name,
      @required this.activitySummary})
      : super(key: key);

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.debug}) {
    return name;
  }

  @override
  Widget build(BuildContext context) {
    final _randomColor = RandomColor();
    final summary = activitySummary;
    final expenseSummary = summary.expenseSummary;
    final expenseSummaryItems = expenseSummary
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
                    Text('${summary.spent}'),
                  ],
                ),
                Row(
                  children: <Widget>[
                    Icon(
                      Icons.arrow_drop_up,
                      color: Colors.green,
                    ),
                    Text('${summary.paid}'),
                  ],
                ),
              ],
            ),
            trailing: Text(
              '${summary.amount}',
              style: Theme.of(context).textTheme.body1.apply(
                    color: summary.amount < 0 ? Colors.red : Colors.green,
                  ),
            ),
          ),
        )
        .toList();
    final pieCharDataList = expenseSummary
        .map(
          (summary) => PieChartSectionData(
            radius: 90.0,
            value: summary.spent,
            color: _randomColor.randomColor(),
            showTitle: true,
            title: summary.name,
          ),
        )
        .toList();

    return Container(
      child: CustomScrollView(
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
              child: expenseSummary.isNotEmpty
                  ? Card(
                      elevation: 10.0,
                      child: PieChart(
                        PieChartData(
                          sections: pieCharDataList,
                          centerSpaceRadius: 0.0,
                          sectionsSpace: 10.0,
                          borderData: FlBorderData(show: false),
                        ),
                      ),
                    )
                  : EmptyList(),
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
                    'Total: ${activity.totalExpense}',
                    style: Theme.of(context).textTheme.subtitle.apply(
                          color: AppColors.WHITE_TEXT,
                        ),
                  ),
                  Text('Average: ${activity.averageExpense}',
                      style: Theme.of(context).textTheme.subtitle.apply(
                            color: AppColors.WHITE_TEXT,
                          )),
                ],
              )
            ],
          ),
          summary.expenseSummary.isNotEmpty
              ? SliverList(
                  delegate: SliverChildBuilderDelegate(
                      (_, index) => expenseSummaryItems[index],
                      childCount: summary.expenseSummary.length),
                )
              : SliverFillRemaining(child: EmptyList()),
        ],
      ),
    );
  }
}
