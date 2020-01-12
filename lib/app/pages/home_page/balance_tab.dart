import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:random_color/random_color.dart';
import 'package:tinh_tien/app/data/models/activity/activity.dart';
import 'package:tinh_tien/common/colors.dart';
import 'package:tinh_tien/common/dimens.dart';

class BalanceTab extends StatelessWidget {
  final Activity activity;

  const BalanceTab({Key key, @required this.activity}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _randomColor = RandomColor();
    return Container(
      child: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            expandedHeight: 240.0,
            automaticallyImplyLeading: false,
            flexibleSpace: Container(
              padding: const EdgeInsets.all(Dimens.NORMAL_PADDING),
              child: Card(
                elevation: 10.0,
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
          ),
          SliverAppBar(
            title: Text('Balance'),
            centerTitle: false,
            floating: true,
            snap: true,
            pinned: true,
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
          )
//          SliverList(
//            delegate: SliverChildBuilderDelegate((_, index) => activ),
//          ),
        ],
      ),
    );
  }
}
