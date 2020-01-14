import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:random_color/random_color.dart';
import 'package:tinh_tien/app/blocs/home/bloc.dart';
import 'package:tinh_tien/app/data/models/activity/activity.dart';
import 'package:tinh_tien/app/widgets/empty_list.dart';
import 'package:tinh_tien/common/colors.dart';
import 'package:tinh_tien/common/dimens.dart';

class BalanceTab extends StatelessWidget {
  final Activity activity;

  const BalanceTab({Key key, @required this.activity}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
        bloc: BlocProvider.of<HomeBloc>(context),
        builder: (_, state) {
          if (state is SummaryLoadedState) {
            final _randomColor = RandomColor();
            final summary = state.activitySummary;
            final expenseSummary = summary.expenseSummary;
            final expenseSummaryItems = expenseSummary
                .map(
                  (summary) =>
                  ListTile(
                    title: Text(summary.name),
                    subtitle: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text('Spent: ${summary.spent}'),
                        Text('Paid: ${summary.paid}'),
                      ],
                    ),
                    trailing: Text(
                      '${summary.amount}',
                      style: Theme
                          .of(context)
                          .textTheme
                          .body1
                          .apply(
                        color: summary.amount < 0 ? Colors.red : Colors.green,
                      ),
                    ),
                  ),
            )
                .toList();
            final pieCharDataList = expenseSummary.map(
                  (summary) =>
                  PieChartSectionData(
                    radius: 90.0,
                    value: summary.spent,
                    color: _randomColor.randomColor(),
                  ),
            );

            return Container(
              child: CustomScrollView(
                slivers: <Widget>[
                  SliverAppBar(
                    expandedHeight: 240.0,
                    automaticallyImplyLeading: false,
                    flexibleSpace: Container(
                      padding: const EdgeInsets.all(Dimens.NORMAL_PADDING),
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
                    actions: <Widget>[
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: <Widget>[
                          Text(
                            'Total: ${activity.totalExpense}',
                            style: Theme
                                .of(context)
                                .textTheme
                                .subtitle
                                .apply(
                              color: AppColors.WHITE_TEXT,
                            ),
                          ),
                          Text('Average: ${activity.averageExpense}',
                              style: Theme
                                  .of(context)
                                  .textTheme
                                  .subtitle
                                  .apply(
                                color: AppColors.WHITE_TEXT,
                              )),
                        ],
                      )
                    ],
                  ),
                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                            (_, index) => expenseSummaryItems[index],
                        childCount: summary.expenseSummary.length),
                  ),
                ],
              ),
            );
          } else {
            return Container();
          }
        });
  }
}
