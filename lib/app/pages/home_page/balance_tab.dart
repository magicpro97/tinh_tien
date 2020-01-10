import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:random_color/random_color.dart';
import 'package:tinh_tien/common/colors.dart';

class BalanceTab extends StatelessWidget {
  final _randomColor = RandomColor();
  final list = List.generate(
      10,
      (index) => Card(
            child: Text('$index'),
          ));

  @override
  Widget build(BuildContext context) {
    return Container(
      child: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            expandedHeight: 240.0,
            automaticallyImplyLeading: false,
            floating: true,
            snap: true,
            pinned: true,
            title: Text('Balance'),
            actions: <Widget>[
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  Text(
                    'Total: 0.00',
                    style: Theme.of(context).textTheme.subtitle.apply(
                          color: AppColors.WHITE_TEXT,
                        ),
                  ),
                  Text('Average: 0.00',
                      style: Theme.of(context).textTheme.subtitle.apply(
                            color: AppColors.WHITE_TEXT,
                          )),
                ],
              )
            ],
            flexibleSpace: Container(
              child: PieChart(
                PieChartData(
                  sections: [
                    PieChartSectionData(
                      radius: 90.0,
                      value: 10,
                      color: _randomColor.randomColor(),
                    ),
                    PieChartSectionData(
                      value: 30,
                      radius: 90.0,
                      color: _randomColor.randomColor(),
                    ),
                    PieChartSectionData(
                      value: 40,
                      radius: 90.0,
                      color: _randomColor.randomColor(),
                    ),
                    PieChartSectionData(
                      value: 20,
                      radius: 90.0,
                      color: _randomColor.randomColor(),
                    ),
                  ],
                  centerSpaceRadius: 0.0,
                  sectionsSpace: 10.0,
                  borderData: FlBorderData(show: false),
                ),
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate((_, index) => list[9]),
          ),
        ],
      ),
    );
  }
}