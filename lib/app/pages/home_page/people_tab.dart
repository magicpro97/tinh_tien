import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:tinh_tien/app/widgets/action_item.dart';
import 'package:tinh_tien/app/widgets/app_tabview.dart';
import 'package:tinh_tien/common/dimens.dart';

class PeopleTab extends StatelessWidget {
  final SlidableController slidableController = SlidableController();

  @override
  Widget build(BuildContext context) {
    return AppTabView(
      title: 'People',
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: Dimens.NORMAL_PADDING),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            TextField(
              minLines: 1,
              decoration: InputDecoration(
                hintText: 'Enter name...',
                suffixIcon: Icon(Icons.add),
                border: InputBorder.none,
              ),
            ),
            ...List.generate(
              10,
                  (index) => _peopleItem(context, index),
            ),
          ],
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
      child: Container(
        color: Colors.white,
        child: ListTile(
          title: Text('1'),
        ),
      ),
      actionPane: SlidableBehindActionPane(),
      secondaryActions: defaultActionItems,
    );
  }
}
