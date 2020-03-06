import 'dart:developer';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading/indicator/ball_pulse_indicator.dart';
import 'package:loading/loading.dart';
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

class ExpenseTab extends StatefulWidget {
  final String name;

  const ExpenseTab({Key key, @required this.name}) : super(key: key);

  @override
  _ExpenseTabState createState() => _ExpenseTabState();
}

class _ExpenseTabState extends State<ExpenseTab>
    with SingleTickerProviderStateMixin {
  ActivityBloc _activityBloc;
  ExpenseBloc _expenseBloc;
  ScrollController _scrollController;
  bool isScrollUp = false;

  @override
  void initState() {
    super.initState();
    _activityBloc = BlocProvider.of<ActivityBloc>(context);
    _expenseBloc = BlocProvider.of<ExpenseBloc>(context);
    _scrollController = ScrollController();
    _scrollController.addListener(() {
        if (_scrollController.offset != 0 ) {
          setState(() {
            isScrollUp = true;
          });
        } else {
          setState(() {
            isScrollUp = false;
          });
        }
      });
    }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ExpenseBloc, ExpenseState>(
      bloc: _expenseBloc,
      child: AppTabView(
        body: Scaffold(
          body: CustomScrollView(
            controller: _scrollController,
            slivers: [
              BlocBuilder<ActivityBloc, ActivityState>(
                  bloc: _activityBloc,
                  builder: (context, state) {
                    return SliverAppBar(
                      expandedHeight: Dimens.EXPANDED_HEIGHT,
                      automaticallyImplyLeading: false,
                      flexibleSpace: _activityBloc.activity != null
                          ? _buildExpenseChart(context, _activityBloc.activity)
                          : EmptyList(),
                    );
                  }),
              SliverAppBar(
                title: Row(
                  children: <Widget>[
                    Text(widget.name),
                    SizedBox(
                      width: Dimens.NORMAL_PADDING,
                    ),
                    BlocBuilder<ActivityBloc, ActivityState>(
                        bloc: _activityBloc,
                        builder: (context, state) {
                          if (state is ActivityLoadingState) {
                            return Loading(
                              indicator: BallPulseIndicator(),
                              size: 25.0,
                            );
                          }
                          return Container();
                        }),
                  ],
                ),
                automaticallyImplyLeading: false,
                floating: true,
                pinned: true,
              ),
              SliverFillRemaining(
                child: _buildExpenseTimeline(_activityBloc.activity),
              ),
            ],
          ),
          floatingActionButton: Visibility(
            child: FloatingActionButton(
                onPressed: () {
                  if (_activityBloc.activity == null ||
                      _activityBloc.activity.people.isNotEmpty) {
                    Navigator.pushNamed(context, EXPENSE_PAGE,
                        arguments: _activityBloc.activity);
                  }
                },
                child: Icon(Icons.add)),
            visible: isScrollUp ? false : true,
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

  Widget _buildExpenseTimeline(Activity activity) {
    if (activity != null && activity.expenses.isNotEmpty) {
      final expenseTimelines = activity.expenseADay
          .map((activityExpense) => TimelineModel(
                TimeLineExpenseBodyItem(
                  title: DateUtils.toDate(activityExpense.date),
                  expenseItems: activityExpense.expenses
                      .map((expense) => ExpenseItem(
                            activity: activity,
                            expense: expense,
                            onDeleted: () {
                              _expenseBloc.add(DeleteExpense(
                                activityId: activity.id,
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
        shrinkWrap: true,
      );
    }
    return EmptyList();
  }

  Widget _buildExpenseChart(BuildContext context, Activity activity) {
    final totals =
        activity.expenseADay.map((expense) => expense.total).toList();
    final showIndexes =
        activity.expenseADay.fold<List<int>>([], (previous, expense) {
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
        spots: activity.expenseADay
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
      child: activity.expenseADay.isNotEmpty
          ? Card(
              elevation: 10.0,
              child: _buildChart(
                  context, showIndexes, tooltipsOnBar, lineBarsData, activity),
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

  // _scrollToTop() {
  //   _scrollController.animateTo(_scrollController.position.minScrollExtent,
  //       duration: Duration(milliseconds: 1000), curve: Curves.easeIn);
  //   setState(() => isOnTop = true);
  // }

  // _scrollToBottom() {
  //   _scrollController.animateTo(_scrollController.position.maxScrollExtent,
  //       duration: Duration(milliseconds: 1000), curve: Curves.easeOut);
  //   setState(() => isOnTop = false);
  // }
}
