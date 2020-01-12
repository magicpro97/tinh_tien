import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:tinh_tien/app/data/models/activity/activity.dart';
import 'package:tinh_tien/app/widgets/action_item.dart';
import 'package:tinh_tien/app/widgets/app_tabview.dart';
import 'package:tinh_tien/app/widgets/empty_list.dart';
import 'package:tinh_tien/common/dimens.dart';

class OutstandingTab extends StatelessWidget {
  final Activity activity;

  const OutstandingTab({Key key, @required this.activity}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppTabView(
      title: 'Outstanding',
      body: Expanded(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(
            Dimens.NORMAL_PADDING,
            Dimens.SMALL_PADDING,
            Dimens.NORMAL_PADDING,
            0,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Card(
                elevation: 10.0,
                child: Padding(
                  child: Text('Total transaction: '),
                  padding: const EdgeInsets.all(Dimens.NORMAL_PADDING),
                ),
              ),
              Expanded(
                child: EmptyList(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // activity.expenses.isNotEmpty ? ListView.separated(
  //                    itemBuilder: (_, index) => list[index],
  //                    separatorBuilder: (_, __) => SizedBox(
  //                          height: Dimens.XSMALL_PADDING,
  //                        ),
  //                    itemCount: list.length) :

  Widget _peopleItem(BuildContext context, int index) {
    final SlidableController slidableController = SlidableController();
    return Slidable(
      key: Key('$index'),
      controller: slidableController,
      dismissal: defaultDismissal(
          context, 'People will be delete', 'People is deleted.'),
      child: ListTile(
        title: Text('1'),
      ),
      actionPane: SlidableDrawerActionPane(),
      secondaryActions: defaultActionItems,
    );
  }
}
