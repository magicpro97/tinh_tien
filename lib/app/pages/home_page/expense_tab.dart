import 'dart:developer';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:timeline_list/timeline.dart';
import 'package:timeline_list/timeline_model.dart';
import 'package:tinh_tien/app/blocs/activity/bloc.dart';
import 'package:tinh_tien/app/blocs/expense/bloc.dart';
import 'package:tinh_tien/app/data/models/activity/activity.dart';
import 'package:tinh_tien/app/route.dart';
import 'package:tinh_tien/app/utils.dart';
import 'package:tinh_tien/app/widgets/app_tabview.dart';
import 'package:tinh_tien/app/widgets/empty_list.dart';
import 'package:tinh_tien/app/widgets/expense_item.dart';
import 'package:tinh_tien/app/widgets/timeline_expense_body_item.dart';
import 'package:tinh_tien/common/dimens.dart';

import '../../inject_container.dart';

class ExpenseTab extends StatefulWidget {
  final String name;
  final Activity activity;

  const ExpenseTab({Key key, @required this.activity, this.name})
      : super(key: key);

  @override
  _ExpenseTabState createState() => _ExpenseTabState();
}

class _ExpenseTabState extends State<ExpenseTab> {
  ActivityBloc _activityBloc;
  ExpenseBloc _expenseBloc;

  @override
  void initState() {
    super.initState();
    _activityBloc = BlocProvider.of<ActivityBloc>(context);
    _expenseBloc = sl<ExpenseBloc>();
  }

  @override
  void dispose() {
    _expenseBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final expenseTimelines = widget.activity.expenseADay
        .map((activityExpense) => TimelineModel(
              TimeLineExpenseBodyItem(
                title: DateUtils.toDate(activityExpense.date),
                expenseItems: activityExpense.expenses
                    .map((expense) => ExpenseItem(
                          activity: widget.activity,
                          expense: expense,
                          onDeleted: () {
                            _expenseBloc.add(DeleteExpense(
                              activityId: widget.activity.id,
                              expenseId: expense.id,
                            ));
                          },
                        ))
                    .toList()
                    .reversed
                    .toList(),
              ),
            ))
        .toList()
        .reversed
        .toList();

    return BlocListener<ExpenseBloc, ExpenseState>(
      bloc: _expenseBloc,
      child: AppTabView(
        body: Expanded(
          child: Scaffold(
            body: CustomScrollView(
              slivers: [
                SliverAppBar(
                  expandedHeight: Dimens.EXPANDED_HEIGHT,
                  automaticallyImplyLeading: false,
                  flexibleSpace: _buildExpenseChart(context),
                ),
                SliverAppBar(
                  title: Text('Expenses'),
                  automaticallyImplyLeading: false,
                  floating: true,
                  pinned: true,
                ),
                SliverFillRemaining(
                  hasScrollBody: false,
                  child: widget.activity.expenses.isNotEmpty
                      ? Timeline(
                          children: expenseTimelines,
                          position: TimelinePosition.Left,
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                        )
                      : EmptyList(),
                ),
              ],
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: widget.activity.people.length > 1
                  ? () {
                      Navigator.pushNamed(context, EXPENSE_PAGE,
                          arguments: widget.activity);
                    }
                  : null,
              child: Icon(Icons.add),
            ),
          ),
        ),
      ),
      listener: (_, state) {
        if (state is ExpenseDeletedState) {
          _activityBloc.add(GetActivityEvent());
        }
      },
    );
  }

  Widget _buildExpenseChart(BuildContext context) {
    final totals =
        widget.activity.expenseADay.map((expense) => expense.total).toList();
    final showIndexes =
        widget.activity.expenseADay.fold<List<int>>([], (previous, expense) {
      if (previous.isNotEmpty) {
        previous.add(previous.last + 1);
      } else {
        previous.add(0);
      }
      return previous;
    });

    final lineBarsData = [
      LineChartBarData(
        showingIndicators: showIndexes,
        isCurved: true,
        spots: widget.activity.expenseADay
            .asMap()
            .entries
            .map((entry) => FlSpot(entry.key.toDouble(), entry.value.total))
            .toList(),
        barWidth: 4.0,
        belowBarData: BarAreaData(
          show: true,
          colors: [Colors.teal],
        ),
        dotData: FlDotData(
          show: true,
          dotColor: Colors.orange,
          checkToShowDot: (dot) => totals.last == dot.y,
        ),
        colors: [Colors.white],
        preventCurveOverShooting: true,
      ),
    ];
    final LineChartBarData tooltipsOnBar = lineBarsData[0];
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(
        Dimens.NORMAL_PADDING,
        Dimens.NORMAL_PADDING,
        Dimens.NORMAL_PADDING,
        0,
      ),
      child: widget.activity.expenseADay.isNotEmpty
          ? Card(
              elevation: 10.0,
              child: _buildChart(
                  context, showIndexes, tooltipsOnBar, lineBarsData),
            )
          : EmptyList(),
    );
  }

  Widget _buildChart(BuildContext context, List<int> showIndexes,
      LineChartBarData tooltipsOnBar, List<LineChartBarData> lineBarsData) {
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
        maxY: widget.activity.maxExpenseADay * 1.5,
        maxX: widget.activity.expenseADay.length.toDouble(),
        gridData: const FlGridData(show: false),
        borderData: FlBorderData(border: Border()),
        titlesData: FlTitlesData(
          leftTitles: const SideTitles(
            showTitles: false,
          ),
          bottomTitles: SideTitles(
              showTitles: true,
              getTitles: (value) {
                if (value < widget.activity.expenseADay.length) {
                  return DateUtils.toDate2(
                      widget.activity.expenseADay[value.toInt()].date);
                }
                return '';
              }),
        ),
        axisTitleData: FlAxisTitleData(
          leftTitle: const AxisTitle(showTitle: true, titleText: 'Money'),
          bottomTitle: const AxisTitle(showTitle: true, titleText: 'Date'),
        )));
  }
}
