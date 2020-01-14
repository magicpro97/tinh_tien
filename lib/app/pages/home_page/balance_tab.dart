import 'dart:developer';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:random_color/random_color.dart';
import 'package:shimmer/shimmer.dart';
import 'package:tinh_tien/app/blocs/home/bloc.dart';
import 'package:tinh_tien/app/data/models/activity/activity.dart';
import 'package:tinh_tien/app/widgets/empty_list.dart';
import 'package:tinh_tien/common/colors.dart';
import 'package:tinh_tien/common/dimens.dart';

class BalanceTab extends StatefulWidget {
  final Activity activity;

  const BalanceTab({Key key, @required this.activity}) : super(key: key);

  @override
  _BalanceTabState createState() => _BalanceTabState();
}

class _BalanceTabState extends State<BalanceTab> {
  HomeBloc _homeBloc;

  @override
  void initState() {
    super.initState();
    _homeBloc = BlocProvider.of<HomeBloc>(context);
    _homeBloc.add(GetActivitySummary());
  }

  @override
  void dispose() {
    _homeBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<HomeBloc, HomeState>(
      bloc: _homeBloc,
      listener: (context, state) {
        log(state.toString());
      },
      child: BlocBuilder<HomeBloc, HomeState>(
          bloc: _homeBloc,
          builder: (_, state) {
            if (state is LoadingState) {
              return Shimmer.fromColors(
                child: _BalanceTabPlaceholder(),
                baseColor: Colors.grey,
                highlightColor: Colors.white,
              );
            } else if (state is SummaryLoadedState) {
              final _randomColor = RandomColor();
              final summary = state.activitySummary;
              final expenseSummary = summary.expenseSummary;
              final expenseSummaryItems = expenseSummary
                  .map(
                    (summary) => ListTile(
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
                        style: Theme.of(context).textTheme.body1.apply(
                              color: summary.amount < 0
                                  ? Colors.red
                                  : Colors.green,
                            ),
                      ),
                    ),
                  )
                  .toList();
              final pieCharDataList = expenseSummary.map(
                (summary) => PieChartSectionData(
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
                              'Total: ${widget.activity.totalExpense}',
                              style: Theme.of(context).textTheme.subtitle.apply(
                                    color: AppColors.WHITE_TEXT,
                                  ),
                            ),
                            Text('Average: ${widget.activity.averageExpense}',
                                style:
                                    Theme.of(context).textTheme.subtitle.apply(
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
            } else if (state is ErrorState) {
              return Center(
                child: Text(state.message),
              );
            } else {
              return Container();
            }
          }),
    );
  }
}

class _BalanceTabPlaceholder extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Expanded(
            flex: 2,
            child: Container(
              padding: const EdgeInsets.all(Dimens.NORMAL_PADDING),
              color: Colors.blue,
              child: Card(),
            ),
          ),
          Expanded(
            flex: 3,
            child: Container(),
          )
        ],
      ),
    );
  }
}
