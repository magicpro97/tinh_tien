import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:tinh_tien/app/route.dart';
import 'package:tinh_tien/app/widgets/action_item.dart';
import 'package:tinh_tien/app/widgets/app_tabview.dart';
import 'package:tinh_tien/common/dimens.dart';

class ExpenseTab extends StatelessWidget {
  final showIndexes = const [1, 2, 3];

  @override
  Widget build(BuildContext context) {
    final lineBarsData = [
      LineChartBarData(
        showingIndicators: showIndexes,
        isCurved: true,
        spots: [
          FlSpot(0, 0),
          FlSpot(10, 20),
          FlSpot(30, 30),
          FlSpot(50, 10),
        ],
        barWidth: 4.0,
        belowBarData: BarAreaData(
          show: true,
        ),
        dotData: FlDotData(show: false),
      ),
    ];
    final LineChartBarData tooltipsOnBar = lineBarsData[0];

    return AppTabView(
      title: 'Expenses',
      body: Expanded(
        child: Scaffold(
          body: Container(
            margin: const EdgeInsets.only(top: Dimens.SMALL_PADDING),
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(
                      horizontal: Dimens.NORMAL_PADDING,
                    ),
                    child: Card(
                      elevation: 10.0,
                      child: LineChart(LineChartData(
                          showingTooltipIndicators: showIndexes.map((index) {
                            return MapEntry(
                              index,
                              [
                                LineBarSpot(
                                    tooltipsOnBar,
                                    lineBarsData.indexOf(tooltipsOnBar),
                                    tooltipsOnBar.spots[index]),
                              ],
                            );
                          }).toList(),
                          lineTouchData: LineTouchData(
                              enabled: false,
                              touchTooltipData: LineTouchTooltipData(
                                  tooltipBgColor: Colors.pink,
                                  tooltipRoundedRadius: 8,
                                  getTooltipItems:
                                      (List<LineBarSpot> lineBarsSpot) {
                                    return lineBarsSpot.map((lineBarSpot) {
                                      return LineTooltipItem(
                                        lineBarSpot.y.toString(),
                                        TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold),
                                      );
                                    }).toList();
                                  })),
                          lineBarsData: lineBarsData,
                          minX: 0,
                          minY: 0,
                          maxY: 40,
                          maxX: 56,
                          gridData: const FlGridData(show: false),
                          borderData: FlBorderData(border: Border()),
                          titlesData: FlTitlesData(
                            leftTitles: const SideTitles(
                              showTitles: false,
                            ),
                            bottomTitles: SideTitles(
                              showTitles: true,
                              getTitles: (value) {
                                switch (value.toInt()) {
                                  case 0:
                                    return '1/1';
                                  case 10:
                                    return '2/1';
                                  case 30:
                                    return '3/1';
                                  case 50:
                                    return '4/1';
                                }
                                return '';
                              },
                            ),
                          ),
                          axisTitleData: FlAxisTitleData(
                            leftTitle: const AxisTitle(
                                showTitle: true, titleText: 'Money'),
                            bottomTitle: const AxisTitle(
                                showTitle: true, titleText: 'Date'),
                          ))),
                    ),
                  ),
                  SizedBox(
                    height: Dimens.NORMAL_PADDING,
                  ),
                  _buildExpenseItem(context),
                ],
              ),
            ),
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
