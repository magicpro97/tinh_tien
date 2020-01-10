import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:tinh_tien/app/widgets/action_item.dart';
import 'package:tinh_tien/app/widgets/app_tabview.dart';
import 'package:tinh_tien/common/dimens.dart';

class OutstandingTab extends StatelessWidget {
  final SlidableController slidableController = SlidableController();

  @override
  Widget build(BuildContext context) {
    final list = List.generate(
      10,
      (index) => _peopleItem(context, index),
    );

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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(
                child: Card(
                  elevation: 10.0,
                  child: ListView.separated(
                      itemBuilder: (_, index) => list[index],
                      separatorBuilder: (_, __) => SizedBox(
                            height: Dimens.XSMALL_PADDING,
                          ),
                      itemCount: list.length),
                ),
              ),
              Padding(
                child: Text('Total transaction'),
                padding: const EdgeInsets.all(Dimens.NORMAL_PADDING),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _peopleItem(BuildContext context, int index) {
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
