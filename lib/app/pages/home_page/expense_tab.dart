import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:timeline_list/timeline.dart';
import 'package:timeline_list/timeline_model.dart';
import 'package:tinh_tien/app/route.dart';
import 'package:tinh_tien/app/widgets/action_item.dart';
import 'package:tinh_tien/app/widgets/app_tabview.dart';
import 'package:tinh_tien/common/colors.dart';
import 'package:tinh_tien/common/dimens.dart';

class ExpenseTab extends StatelessWidget {
  final showIndexes = const [1, 2, 3];

  @override
  Widget build(BuildContext context) {
    final list1 = List.generate(5, (index) => _buildExpenseItem(context));
    final expenses = [
      TimelineModel(
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Card(
            elevation: 10.0,
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Text(
                    '1-1-2020',
                    style: Theme.of(context).textTheme.title,
                  ),
                ),
                ListView.builder(
                  shrinkWrap: true,
                  itemBuilder: (_, index) => list1[index],
                  itemCount: list1.length,
                  physics: NeverScrollableScrollPhysics(),
                ),
              ],
            ),
          ),
        ),
        //icon: Icon(Icons.ac_unit),
        iconBackground: AppColors.MAIN_COLOR,
      ),
      TimelineModel(
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Card(
            elevation: 10.0,
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Text(
                    '1-1-2020',
                    style: Theme.of(context).textTheme.title,
                  ),
                ),
                ListView.builder(
                  shrinkWrap: true,
                  itemBuilder: (_, index) => list1[index],
                  itemCount: list1.length,
                  physics: NeverScrollableScrollPhysics(),
                ),
              ],
            ),
          ),
        ),
        //icon: Icon(Icons.ac_unit),
        iconBackground: AppColors.MAIN_COLOR,
      ),
    ];
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
                flexibleSpace: _buildExpenseChart(tooltipsOnBar, lineBarsData),
              ),
              SliverAppBar(
                title: Text('Expenses'),
                automaticallyImplyLeading: false,
                floating: true,
                pinned: true,
              ),
              SliverFillRemaining(
                hasScrollBody: false,
                child: Timeline(
                  children: expenses,
                  position: TimelinePosition.Left,
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                ),
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

  Widget _buildExpenseChart(
      LineChartBarData tooltipsOnBar, List<LineChartBarData> lineBarsData) {
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
              leftTitle: const AxisTitle(showTitle: true, titleText: 'Money'),
              bottomTitle: const AxisTitle(showTitle: true, titleText: 'Date'),
            ))),
      ),
    );
  }

  Widget _buildExpenseItem(BuildContext context) {
    return Slidable(
      key: Key('aa'),
      child: ListTile(
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
            Expanded(
              child: Container(),
            ),
          ],
        ),
        subtitle: Text('at 10:00'),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Icon(
              Icons.lens,
              size: 16.0,
            ),
            Text('pending'),
          ],
        ),
      ),
      actionPane: SlidableDrawerActionPane(),
      secondaryActions: defaultActionItems,
      dismissal: defaultDismissal(
        context,
        'Expense will be deteled',
        'Expense is deleted',
      ),
    );
  }
}
