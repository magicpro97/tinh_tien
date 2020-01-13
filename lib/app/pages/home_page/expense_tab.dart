import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:timeline_list/timeline.dart';
import 'package:timeline_list/timeline_model.dart';
import 'package:tinh_tien/app/data/models/activity/activity.dart';
import 'package:tinh_tien/app/route.dart';
import 'package:tinh_tien/app/widgets/app_tabview.dart';
import 'package:tinh_tien/app/widgets/empty_list.dart';
import 'package:tinh_tien/app/widgets/expense_item.dart';
import 'package:tinh_tien/app/widgets/timeline_expense_body_item.dart';
import 'package:tinh_tien/common/dimens.dart';

class ExpenseTab extends StatelessWidget {
  final Activity activity;

  const ExpenseTab({Key key, @required this.activity}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final showIndexes = activity.expenses.fold<List<int>>(
        [], (previous, expense) => previous..add(previous.last + 1));
    final expenseTimelines = activity.expenseADay
        .map((activityExpense) => TimelineModel(
              TimeLineExpenseBodyItem(
                title: activityExpense.createdAt.toIso8601String(),
                expenseItems:
                    activityExpense.expenses.map((expense) => ExpenseItem(
                          expense: expense,
                        )),
              ),
            ))
        .toList();
    final lineBarsData = [
      LineChartBarData(
        showingIndicators: showIndexes,
        isCurved: true,
        spots: [
          FlSpot(0, 0),
          ...activity.expenseADay
              .asMap()
              .entries
              .map((entry) => FlSpot(entry.key.toDouble(), entry.value.total)),
        ],
        barWidth: 4.0,
        belowBarData: BarAreaData(
          show: true,
          colors: [Colors.teal],
        ),
        dotData: FlDotData(
          show: false,
        ),
        colors: [Colors.white],
        preventCurveOverShooting: true,
      ),
    ];
    final LineChartBarData tooltipsOnBar = lineBarsData[0];

    return AppTabView(
      body: Expanded(
        child: Scaffold(
          body: CustomScrollView(
            slivers: [
              SliverAppBar(
                expandedHeight: 250,
                automaticallyImplyLeading: false,
                flexibleSpace: _buildExpenseChart(
                    tooltipsOnBar, lineBarsData, showIndexes),
              ),
              SliverAppBar(
                title: Text('Expenses'),
                automaticallyImplyLeading: false,
                floating: true,
                pinned: true,
              ),
              SliverFillRemaining(
                hasScrollBody: false,
                child: activity.expenses.isNotEmpty ? Timeline(
                  children: expenseTimelines,
                  position: TimelinePosition.Left,
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                ) : EmptyList(),
              ),
            ],
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              Navigator.pushNamed(context, EXPENSE_PAGE);
            },
            child: Icon(Icons.add),
          ),
        ),
      ),
    );
  }

  Widget _buildExpenseChart(LineChartBarData tooltipsOnBar,
      List<LineChartBarData> lineBarsData, List<int> showIndexes) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(
        Dimens.NORMAL_PADDING,
        Dimens.NORMAL_PADDING,
        Dimens.NORMAL_PADDING,
        0,
      ),
      child: Card(
        elevation: 10.0,
        child: activity.expenseADay.isNotEmpty
            ? _buildChart(showIndexes, tooltipsOnBar, lineBarsData)
            : EmptyList()
      ),
    );
  }

  Widget _buildChart(List<int> showIndexes, LineChartBarData tooltipsOnBar,
      List<LineChartBarData> lineBarsData) {
    return LineChart(LineChartData(
        showingTooltipIndicators: showIndexes.map((index) {
          return MapEntry(
            index,
            [
              LineBarSpot(tooltipsOnBar, lineBarsData.indexOf(tooltipsOnBar),
                  tooltipsOnBar.spots[index]),
            ],
          );
        }).toList(),
        lineTouchData: LineTouchData(
            enabled: false,
            touchTooltipData: LineTouchTooltipData(
                tooltipBgColor: Colors.orange,
                tooltipRoundedRadius: 8,
                getTooltipItems: (List<LineBarSpot> lineBarsSpot) {
                  return lineBarsSpot.map((lineBarSpot) {
                    return LineTooltipItem(
                      lineBarSpot.y.toString(),
                      TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    );
                  }).toList();
                })),
        lineBarsData: lineBarsData,
        minX: 0,
        minY: 0,
        maxY: activity.maxExpenseADay,
        maxX: activity.expenseADay.length.toDouble(),
        gridData: const FlGridData(show: false),
        borderData: FlBorderData(border: Border()),
        titlesData: FlTitlesData(
          leftTitles: const SideTitles(
            showTitles: false,
          ),
          bottomTitles: SideTitles(
            showTitles: true,
            getTitles: (value) => activity.expenseADay
                .firstWhere((expense) => expense.total == value)
                .createdAt
                .toIso8601String(),
          ),
        ),
        axisTitleData: FlAxisTitleData(
          leftTitle: const AxisTitle(showTitle: true, titleText: 'Money'),
          bottomTitle: const AxisTitle(showTitle: true, titleText: 'Date'),
        )));
  }
}
