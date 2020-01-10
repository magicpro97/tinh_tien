import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:tinh_tien/app/data/models/activity/activity.dart';
import 'package:tinh_tien/app/route.dart';
import 'package:tinh_tien/app/widgets/action_item.dart';
import 'package:tinh_tien/app/widgets/app_button.dart';
import 'package:tinh_tien/app/widgets/app_tabview.dart';
import 'package:tinh_tien/common/dimens.dart';

class PeopleTab extends StatelessWidget {
  final Activity activity;

  const PeopleTab({Key key, this.activity}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final people = activity.people
        .map((person) => _peopleItem(context, person.id))
        .toList();

    return AppTabView(
      title: 'People',
      body: Expanded(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: Dimens.NORMAL_PADDING),
          child: Column(
            children: <Widget>[
              Card(
                elevation: 10.0,
                child: Padding(
                  padding: const EdgeInsets.only(left: Dimens.NORMAL_PADDING),
                  child: TextField(
                    minLines: 1,
                    decoration: InputDecoration(
                      hintText: 'Enter name...',
                      suffixIcon: Icon(Icons.add),
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Card(
                  elevation: 10.0,
                  child: ListView.separated(
                      itemBuilder: (_, index) => people[index],
                      separatorBuilder: (_, __) =>
                          SizedBox(
                            height: Dimens.XSMALL_PADDING,
                          ),
                      itemCount: people.length),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(Dimens.SMALL_PADDING),
                child: AppButton(
                    text: 'Share',
                    onPressed: () {
                      Navigator.pushNamed(context, SHARE_PAGE,
                          arguments: activity);
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _peopleItem(BuildContext context, String id) {
    final SlidableController slidableController = SlidableController();

    return Slidable(
      key: Key(id),
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
