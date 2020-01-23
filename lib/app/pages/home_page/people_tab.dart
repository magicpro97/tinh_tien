import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:tinh_tien/app/blocs/home/bloc.dart';
import 'package:tinh_tien/app/data/models/activity/activity.dart';
import 'package:tinh_tien/app/data/models/people/person.dart';
import 'package:tinh_tien/app/route.dart';
import 'package:tinh_tien/app/widgets/action_item.dart';
import 'package:tinh_tien/app/widgets/app_button.dart';
import 'package:tinh_tien/app/widgets/app_tabview.dart';
import 'package:tinh_tien/app/widgets/empty_list.dart';
import 'package:tinh_tien/common/dimens.dart';

class PeopleTab extends StatefulWidget {
  final String name;
  final Activity activity;

  const PeopleTab({Key key, @required this.activity, @required this.name})
      : super(key: key);

  @override
  _PeopleTabState createState() => _PeopleTabState();

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.debug}) {
    return name;
  }
}

class _PeopleTabState extends State<PeopleTab> {
  TextEditingController _peopleNameController;
  HomeBloc _homeBloc;

  @override
  void initState() {
    super.initState();
    _peopleNameController = TextEditingController();
    _homeBloc = BlocProvider.of<HomeBloc>(context);
  }

  @override
  void dispose() {
    _peopleNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final people = widget.activity.people
        .map((person) => _peopleItem(context, person))
        .toList();

    return AppTabView(
      title: 'People',
      body: Expanded(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: Dimens.NORMAL_PADDING),
          child: BlocBuilder<HomeBloc, HomeState>(
            builder: (_, state) => Column(
              children: <Widget>[
                Card(
                  elevation: 10.0,
                  child: Padding(
                    padding: const EdgeInsets.only(left: Dimens.NORMAL_PADDING),
                    child: TextField(
                      controller: _peopleNameController,
                      minLines: 1,
                      decoration: InputDecoration(
                        hintText: 'Enter name...',
                        errorText: state is ErrorState ? state.message : null,
                        suffixIcon: IconButton(
                            icon: Icon(Icons.add),
                            onPressed: () {
                              _homeBloc.add(CreatePeopleEvent(
                                name: _peopleNameController.text,
                                activityId: widget.activity.id,
                              ));
                            }),
                        border: InputBorder.none,
                      ),
                      onSubmitted: (value) {
                        _homeBloc.add(CreatePeopleEvent(
                          name: value,
                          activityId: widget.activity.id,
                        ));
                      },
                    ),
                  ),
                ),
                Expanded(
                  child: widget.activity.people.isNotEmpty
                      ? Card(
                          elevation: 10.0,
                          child: ListView.separated(
                              itemBuilder: (_, index) => people[index],
                              separatorBuilder: (_, __) => SizedBox(
                                    height: Dimens.XSMALL_PADDING,
                                  ),
                              itemCount: people.length),
                        )
                      : EmptyList(),
                ),
                Padding(
                  padding: const EdgeInsets.all(Dimens.SMALL_PADDING),
                  child: AppButton(
                      text: 'Share',
                      onPressed: () {
                        Navigator.pushNamed(context, SHARE_PAGE,
                            arguments: widget.activity);
                      }),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _peopleItem(BuildContext context, Person person) {
    final SlidableController slidableController = SlidableController();

    return Slidable(
      key: Key(person.id),
      controller: slidableController,
      dismissal: defaultDismissal(
          context, 'People will be delete', 'People is deleted.', () {
            log(person.id);
          }),
      child: ListTile(
        title: Text(person.name),
      ),
      actionPane: SlidableDrawerActionPane(),
      secondaryActions: defaultActionItems(() {
        log(person.id);
      }, () {
        log(person.id);
      }),
    );
  }
}
