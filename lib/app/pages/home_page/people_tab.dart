import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tinh_tien/app/blocs/activity/bloc.dart';
import 'package:tinh_tien/app/blocs/people/bloc.dart';
import 'package:tinh_tien/app/data/models/people/person.dart';
import 'package:tinh_tien/app/route.dart';
import 'package:tinh_tien/app/widgets/app_tabview.dart';
import 'package:tinh_tien/app/widgets/app_textfield.dart';
import 'package:tinh_tien/app/widgets/empty_list.dart';
import 'package:tinh_tien/common/colors.dart';
import 'package:tinh_tien/common/dimens.dart';

import '../../inject_container.dart';

class PeopleTab extends StatefulWidget {
  final String name;

  const PeopleTab({Key key, @required this.name}) : super(key: key);

  @override
  _PeopleTabState createState() => _PeopleTabState();

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.debug}) {
    return name;
  }
}

class _PeopleTabState extends State<PeopleTab> {
  TextEditingController _peopleNameController;
  ActivityBloc _activityBloc;
  PeopleBloc _peopleBloc;
  FocusNode _peopleNameFocus;
  bool editPeopleNameMode = false;
  Person _editingPerson;

  @override
  void initState() {
    super.initState();
    _peopleNameFocus = FocusNode();
    _peopleNameFocus.addListener(() {
      if (!_peopleNameFocus.hasFocus) {
        setState(() {
          editPeopleNameMode = false;
        });
      }
    });
    _peopleNameController = TextEditingController();
    _activityBloc = BlocProvider.of<ActivityBloc>(context);
    _peopleBloc = sl<PeopleBloc>();
  }

  @override
  void dispose() {
    _peopleNameController.dispose();
    _peopleBloc.close();
    _peopleNameFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AppTabView(
      title: 'People',
      actions: <Widget>[
        Padding(
          padding: const EdgeInsets.all(Dimens.SMALL_PADDING),
          child: BlocBuilder<ActivityBloc, ActivityState>(
              builder: (context, state) {
            return OutlineButton(
              child: Text(
                'Share',
                style: Theme.of(context).textTheme.button.apply(
                      color: AppColors.WHITE_TEXT,
                    ),
              ),
              borderSide: const BorderSide(
                color: AppColors.WHITE_TEXT,
              ),
              onPressed: state is ActivityLoadedState
                  ? () {
                      Navigator.pushNamed(context, SHARE_PAGE,
                          arguments: state.activity);
                    }
                  : null,
            );
          }),
        ),
      ],
      body: Expanded(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: Dimens.NORMAL_PADDING),
          child: BlocListener<PeopleBloc, PeopleState>(
            bloc: _peopleBloc,
            listener: (context, state) {
              if (state is PeopleCreatedState ||
                  state is PeopleEditedState ||
                  state is PeopleDeletedState) {
                _activityBloc.add(GetActivityEvent());
              }
            },
            child: BlocBuilder<PeopleBloc, PeopleState>(
              bloc: _peopleBloc,
              builder: (_, state) => Column(
                children: <Widget>[
                  Card(
                    elevation: 10.0,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: Dimens.NORMAL_PADDING),
                      child: AppTextField(
                        editMode: editPeopleNameMode,
                        addLabelText: "Add a person",
                        editLabelText: "Edit person's name",
                        hintText: "Enter a name...",
                        helpText: "Ex: John",
                        controller: _peopleNameController,
                        focusNode: _peopleNameFocus,
                        onDone: () {
                          if (editPeopleNameMode) {
                            _peopleBloc.add(EditPeopleEvent(
                                activityId: _activityBloc.activityId,
                                name: _peopleNameController.text,
                                personId: _editingPerson.id));
                          } else {
                            _peopleBloc.add(CreatePeopleEvent(
                              activityId: _activityBloc.activityId,
                              name: _peopleNameController.text,
                            ));
                          }
                        },
                      ),
                    ),
                  ),
                  Expanded(
                    child: BlocBuilder<ActivityBloc, ActivityState>(
                      builder: (_, state) {
                        if (state is ActivityLoadedState &&
                            state.activity.people.isNotEmpty) {
                          final peopleItems = state.activity.people
                              .map((person) => _peopleItem(context, person))
                              .toList();
                          return Card(
                            elevation: 10.0,
                            child: ListView.separated(
                                itemBuilder: (_, index) => peopleItems[index],
                                separatorBuilder: (_, __) => SizedBox(
                                      height: Dimens.XSMALL_PADDING,
                                    ),
                                itemCount: peopleItems.length),
                          );
                        }
                        return EmptyList();
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _peopleItem(BuildContext context, Person person) {
    return ListTile(
      title: Text(person.name),
      trailing: editPeopleNameMode && _editingPerson.id == person.id
          ? OutlineButton(
              child: Text(
                'Cancel',
                style: Theme.of(context).textTheme.button.apply(
                      color: Colors.red,
                    ),
              ),
              onPressed: () {
                setState(() {
                  _peopleNameController.clear();
                  editPeopleNameMode = false;
                });
              },
              borderSide: BorderSide(
                color: Colors.red,
              ),
            )
          : Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                IconButton(
                  icon: Icon(
                    Icons.edit,
                    color: AppColors.MAIN_COLOR,
                  ),
                  onPressed: () {
                    setState(() {
                      _peopleNameController.text = person.name;
                      _editingPerson = person;
                      editPeopleNameMode = true;
                    });
                  },
                ),
                IconButton(
                  icon: Icon(
                    Icons.delete_forever,
                    color: AppColors.DANGER_COLOR,
                  ),
                  onPressed: () async {
                    final result = await showDialog(
                      builder: (_) {
                        return AlertDialog(
                          title: Row(
                            children: <Widget>[
                              Icon(
                                Icons.warning,
                                color: AppColors.WARNING_COLOR,
                              ),
                              Text(
                                'Warning',
                                style: Theme.of(context).textTheme.title.apply(
                                      color: AppColors.WARNING_COLOR,
                                    ),
                              ),
                            ],
                          ),
                          content: RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                    text: 'Do you want delete ',
                                    style: Theme.of(context)
                                        .textTheme
                                        .subtitle
                                        .apply(
                                          color: Colors.black,
                                        )),
                                TextSpan(
                                    text: '${person.name}?',
                                    style:
                                        Theme.of(context).textTheme.title.apply(
                                              color: AppColors.MAIN_COLOR,
                                            )),
                              ],
                            ),
                          ),
                          actions: <Widget>[
                            FlatButton(
                              child: Text(
                                'NO',
                                style: Theme.of(context)
                                    .textTheme
                                    .button
                                    .apply(color: AppColors.DANGER_COLOR),
                              ),
                              onPressed: () {
                                Navigator.pop(context, false);
                              },
                            ),
                            FlatButton(
                              child: Text('YES'),
                              onPressed: () {
                                Navigator.pop(context, true);
                              },
                            ),
                          ],
                        );
                      },
                      context: context,
                    );
                    if (result) {
                      _peopleBloc.add(DeletePeopleEvent(
                        activityId: _activityBloc.activityId,
                        personId: person.id,
                      ));
                    }
                  },
                ),
              ],
            ),
    );
  }
}
