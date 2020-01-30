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

  const ExpenseTab({Key key, @required this.name}) : super(key: key);

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
                  flexibleSpace: BlocBuilder<ActivityBloc, ActivityState>(
                      builder: (context, state) {
                    if (state is ActivityLoadedState) {
                      return _buildExpenseChart(context, state);
                    }
                    return Container();
                  }),
                ),
                SliverAppBar(
                  title: Text('Expenses'),
                  automaticallyImplyLeading: false,
                  floating: true,
                  pinned: true,
                ),
                SliverFillRemaining(
                  hasScrollBody: false,
                  child: BlocBuilder<ActivityBloc, ActivityState>(
                    bloc: _activityBloc,
                    builder: (_, state) {
                      if (state is ActivityLoadedState &&
                          state.activity.expenseADay.isNotEmpty) {
                        final expenseTimelines = state.activity.expenseADay
                            .map((activityExpense) => TimelineModel(
                                  TimeLineExpenseBodyItem(
                                    title:
                                        DateUtils.toDate(activityExpense.date),
                                    expenseItems: activityExpense.expenses
                                        .map((expense) => ExpenseItem(
                                              activity: state.activity,
                                              expense: expense,
                                              onDeleted: () {
                                                _expenseBloc.add(DeleteExpense(
                                                  activityId: state.activity.id,
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

                        return Timeline(
                          children: expenseTimelines,
                          position: TimelinePosition.Left,
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                        );
                      }
                      return EmptyList();
                    },
                  ),
                ),
              ],
            ),
            floatingActionButton: BlocBuilder<ActivityBloc, ActivityState>(
              builder: (_, state) {
                if (state is ActivityLoadedState &&
                    state.activity.people.length > 1) {
                  return FloatingActionButton(
                      onPressed: () {
                        Navigator.pushNamed(context, EXPENSE_PAGE,
                            arguments: state.activity);
                      },
                      child: Icon(Icons.add));
                }
                return Container();
              },
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

  Widget _buildExpenseChart(BuildContext context, ActivityState state) {
    final loadedState = state as ActivityLoadedState;
    final totals = loadedState.activity.expenseADay
        .map((expense) => expense.total)
        .toList();
    final showIndexes = loadedState.activity.expenseADay.fold<List<int>>([],
        (previous, expense) {
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
        spots: loadedState.activity.expenseADay
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
      child: loadedState.activity.expenseADay.isNotEmpty
          ? Card(
              elevation: 10.0,
              child: _buildChart(context, showIndexes, tooltipsOnBar,
                  lineBarsData, loadedState.activity),
            )
          : EmptyList(),
    );
  }

  Widget _buildChart(
      BuildContext context,
      List<int> showIndexes,
      LineChartBarData tooltipsOnBar,
      List<LineChartBarData> lineBarsData,
      Activity activity) {
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
        maxY: activity.maxExpenseADay * 1.5,
        maxX: activity.expenseADay.length.toDouble(),
        gridData: const FlGridData(show: false),
        borderData: FlBorderData(border: Border()),
        titlesData: FlTitlesData(
          leftTitles: const SideTitles(
            showTitles: false,
          ),
          bottomTitles: SideTitles(
              showTitles: true,
              getTitles: (value) {
                if (value < activity.expenseADay.length) {
                  return DateUtils.toDate2(
                      activity.expenseADay[value.toInt()].date);
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
