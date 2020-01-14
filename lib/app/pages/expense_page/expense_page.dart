import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:tinh_tien/app/blocs/home/bloc.dart';
import 'package:tinh_tien/app/data/models/activity/activity.dart';
import 'package:tinh_tien/app/data/models/people/person.dart';
import 'package:tinh_tien/app/widgets/app_chip.dart';
import 'package:tinh_tien/app/widgets/app_scaffold.dart';
import 'package:tinh_tien/app/widgets/chip_list.dart';
import 'package:tinh_tien/common/colors.dart';
import 'package:tinh_tien/common/dimens.dart';

class ExpensePage extends StatefulWidget {
  @override
  _ExpensePageState createState() => _ExpensePageState();
}

class _ExpensePageState extends State<ExpensePage> {
  Activity activity;
  List<AppChip<Person>> participantList;
  List<AppChip<Person>> paidByList;
  HomeBloc _homeBloc;
  List<Person> checkedPaidBy = [];
  List<Person> checkedParticipants = [];
  String paidFor;
  double amount;

  @override
  void didChangeDependencies() {
    activity = activity ?? ModalRoute.of(context).settings.arguments;
    activity.people.clear();
    activity.people
        .addAll([Person(name: 'tri dep trai'), Person(name: 'tri dep trai 1')]);
    paidByList = activity.people
        .map((person) => AppChip<Person>(
              label: person.name,
              value: person,
              onChanged: (checked, value) {
                if (checked && !checkedPaidBy.contains(value)) {
                  checkedPaidBy.add(value);
                } else {
                  checkedPaidBy.remove(value);
                }
              },
            ))
        .toList();
        
    participantList = activity.people
        .map((person) => AppChip<Person>(
              label: person.name,
              value: person,
              onChanged: (checked, value) {
                if (checked && !checkedParticipants.contains(value)) {
                  checkedParticipants.add(value);
                } else {
                  checkedParticipants.remove(value);
                }
              },
            ))
        .toList();
    super.didChangeDependencies();
  }

  @override
  void initState() {
    _homeBloc = BlocProvider.of<HomeBloc>(context);
    super.initState();
  }

  @override
  void dispose() {
    _homeBloc.close();
    super.dispose();
  }

  DateTime selectedTime = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      appBarAction: <Widget>[],
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('Paid by:'),
            ChipList(
              chips: paidByList,
            ),
            SizedBox(
              height: Dimens.NORMAL_PADDING,
            ),
            Text('Paid for:'),
            TextField(
              decoration: InputDecoration(hintText: 'Description Ex:Beer'),
                onChanged: (value) {
                paidFor = value;
              },
            ),
            SizedBox(
              height: Dimens.NORMAL_PADDING,
            ),
            Text('Amount of money'),
            TextField(
              decoration: InputDecoration(hintText: 'Amount Ex:10000'),
              keyboardType:
                  TextInputType.numberWithOptions(signed: true, decimal: false),
              inputFormatters: <TextInputFormatter>[
                WhitelistingTextInputFormatter.digitsOnly,
              ],
              onChanged: (value) {
                amount = double.parse(value);
              },
            ),
            SizedBox(
              height: Dimens.NORMAL_PADDING,
            ),
            Text('Participants:'),
            ChipList(
              chips: participantList,
            ),
            SizedBox(
              height: Dimens.NORMAL_PADDING,
            ),
            GestureDetector(
              onTap: () {
                DatePicker.showDateTimePicker(context, minTime: DateTime.now(),
                    onConfirm: (dateTime) {
                  setState(() {
                    selectedTime = dateTime;
                  });
                });
              },
              child: Container(
                width: double.infinity,
                color: Colors.grey[200],
                padding: const EdgeInsets.all(Dimens.NORMAL_PADDING),
                child: Row(children: <Widget>[
                  Icon(
                    Icons.date_range,
                    color: AppColors.MAIN_COLOR,
                  ),
                  SizedBox(
                    width: Dimens.NORMAL_PADDING,
                  ),
                  Text(
                    '$selectedTime',
                  )
                ]),
              ),
            ),
            SizedBox(
              height: Dimens.LARGE_PADDING,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                FlatButton(
                  child: Text(
                    'Back',
                    style: Theme.of(context).textTheme.button,
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                MaterialButton(
                  height: 40.0,
                  color: AppColors.MAIN_COLOR,
                  child: Text(
                    'Add',
                    style: Theme.of(context).textTheme.button.apply(
                          color: AppColors.WHITE_TEXT,
                        ),
                  ),
                  onPressed: () {
                    log(activity.id, name: 'activityId');
                    log(checkedPaidBy.toString(), name: 'checkedPaidBy');
                    log(checkedParticipants.toString(), name: 'checkedParticipants');
                    log(paidFor, name: 'paidFor');
                    log(amount.toString(), name: 'amount');
                    _homeBloc.add(CreateExpenseEvent(
                      activityId: activity.id,
                      paidBy: checkedPaidBy,
                      participants: checkedParticipants,
                      paidFor: paidFor,
                      amount: amount,
                    ));
                    log('test', name: 'afterBloc');
                  },
                ),
              ],
            )
          ],
        ),
      ),
    );
  }


}
