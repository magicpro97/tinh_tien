import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:tinh_tien/app/blocs/activity/bloc.dart';
import 'package:tinh_tien/app/blocs/expense/bloc.dart';
import 'package:tinh_tien/app/data/models/activity/activity.dart';
import 'package:tinh_tien/app/data/models/expense/expense_request.dart';
import 'package:tinh_tien/app/data/models/people/person.dart';
import 'package:tinh_tien/app/utils.dart';
import 'package:tinh_tien/app/widgets/app_chip.dart';
import 'package:tinh_tien/app/widgets/app_scaffold.dart';
import 'package:tinh_tien/app/widgets/chip_list.dart';
import 'package:tinh_tien/common/colors.dart';
import 'package:tinh_tien/common/dimens.dart';
import 'package:tinh_tien/core/vadidator/validator.dart';

import '../../inject_container.dart';

class ExpensePage extends StatefulWidget {
  @override
  _ExpensePageState createState() => _ExpensePageState();
}

class _ExpensePageState extends State<ExpensePage> {
  ActivityBloc _activityBloc;
  ExpenseBloc _expenseBloc;
  List<Person> _selectedPaidBys;
  List<Person> _selectedParticipants;
  DateTime _selectedTime;
  TextEditingController _paidFor;
  TextEditingController _amount;
  FocusNode _amountFocus;
  StreamController<String> _paidForValidator;
  StreamController<String> _amountValidator;
  StreamController<int> _paidByForValidator;
  StreamController<int> _participantValidator;
  Activity _activity;

  @override
  void initState() {
    _activityBloc = BlocProvider.of<ActivityBloc>(context);
    _expenseBloc = sl<ExpenseBloc>();
    _selectedPaidBys = [];
    _selectedParticipants = [];
    _selectedTime = DateTime.now();
    _paidFor = TextEditingController();
    _amount = TextEditingController();
    _amountFocus = FocusNode();
    _paidForValidator = StreamController.broadcast();
    _amountValidator = StreamController.broadcast();
    _paidByForValidator = StreamController.broadcast();
    _participantValidator = StreamController.broadcast();
    super.initState();
  }

  @override
  void dispose() {
    _paidForValidator.close();
    _amountValidator.close();
    _paidByForValidator.close();
    _participantValidator.close();
    _paidFor.dispose();
    _amount.dispose();
    _amountFocus.dispose();
    _expenseBloc.close();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    _activity = ModalRoute.of(context).settings.arguments;
    super.didChangeDependencies();
  }

  void _onPaidBySelected(selected, person) {
    if (selected && !_selectedPaidBys.contains(person)) {
      _selectedPaidBys.add(person);
    } else {
      _selectedPaidBys.remove(person);
    }
    _paidByForValidator.add(_selectedPaidBys.length);
  }

  void _onParticipantSelected(selected, person) {
    if (selected && !_selectedParticipants.contains(person)) {
      _selectedParticipants.add(person);
    } else {
      _selectedParticipants.remove(person);
    }
    _participantValidator.add(_selectedParticipants.length);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ExpenseBloc, ExpenseState>(
      bloc: _expenseBloc,
      listener: (context, state) {
        if (state is ExpenseCreatedState) {
          _activityBloc.add(GetActivityEvent());
          Navigator.pop(context);
        }
      },
      child: BlocBuilder<ExpenseBloc, ExpenseState>(
        bloc: _expenseBloc,
        builder: (context, state) {
          return AppScaffold(
            body: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text('Paid by:'),
                  ListTile(
                    title: ChipList(
                      chips: _activity.people
                              .map((person) => AppChip<Person>(
                                  value: person,
                                  label: person.name,
                                  onChanged: _onPaidBySelected))
                              .toList() ??
                          [],
                    ),
                    subtitle: StreamBuilder<String>(
                      stream:
                          _paidByForValidator.stream.transform(notEmptyList),
                      builder: (context, snapshot) {
                        return Text(
                          snapshot.hasError ? snapshot.error.toString() : '',
                          style: Theme.of(context).textTheme.subtitle.apply(
                                color: Colors.red,
                              ),
                        );
                      },
                    ),
                  ),
                  SizedBox(
                    height: Dimens.NORMAL_PADDING,
                  ),
                  Text('Paid for:'),
                  StreamBuilder(
                    stream: _paidForValidator.stream.transform(notEmptyString),
                    builder: (context, snapshot) {
                      return TextField(
                        textInputAction: TextInputAction.go,
                        controller: _paidFor,
                        decoration: InputDecoration(
                          hintText: 'Description Ex:Beer',
                          errorText: snapshot.hasError ? snapshot.error : null,
                        ),
                        onSubmitted: (value) {
                          _amountFocus.requestFocus();
                        },
                        onChanged: (value) => _paidForValidator.add(value),
                      );
                    },
                  ),
                  SizedBox(
                    height: Dimens.NORMAL_PADDING,
                  ),
                  Text('Amount of money'),
                  StreamBuilder<String>(
                    stream: _amountValidator.stream.transform(notEmptyString),
                    builder: (context, snapshot) {
                      return TextField(
                        focusNode: _amountFocus,
                        textInputAction: TextInputAction.go,
                        controller: _amount,
                        decoration: InputDecoration(
                          hintText: 'Amount Ex:10000',
                          errorText: snapshot.hasError ? snapshot.error : null,
                        ),
                        keyboardType: TextInputType.numberWithOptions(
                            signed: true, decimal: false),
                        inputFormatters: <TextInputFormatter>[
                          WhitelistingTextInputFormatter.digitsOnly,
                        ],
                        onChanged: (value) => _amountValidator.add(value),
                      );
                    },
                  ),
                  SizedBox(
                    height: Dimens.NORMAL_PADDING,
                  ),
                  Text('Participants:'),
                  ListTile(
                    title: ChipList(
                      chips: _activity.people
                              .map((person) => AppChip<Person>(
                                  value: person,
                                  label: person.name,
                                  onChanged: _onParticipantSelected))
                              .toList() ??
                          [],
                    ),
                    subtitle: StreamBuilder<String>(
                      stream:
                          _participantValidator.stream.transform(notEmptyList),
                      builder: (context, snapshot) {
                        return Text(
                            snapshot.hasError ? snapshot.error.toString() : '');
                      },
                    ),
                  ),
                  SizedBox(
                    height: Dimens.NORMAL_PADDING,
                  ),
                  GestureDetector(
                    onTap: () {
                      DatePicker.showDateTimePicker(context,
                          minTime: _activity.createdAt, onConfirm: (dateTime) {
                        setState(() {
                          _selectedTime = dateTime;
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
                          DateUtils.toDateTime(_selectedTime),
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
                          final expense = ExpenseRequest(
                            amount: double.parse(_amount.text),
                            people: _selectedParticipants,
                            paidBy: _selectedPaidBys,
                            paidFor: _paidFor.text,
                            date: _selectedTime,
                          );

                          if (_paidFor.text.length > 0 &&
                              _amount.text.length > 0 &&
                              _selectedPaidBys.isNotEmpty &&
                              _selectedParticipants.isNotEmpty) {
                            _expenseBloc.add(CreateExpense(
                                activityId: _activity.id, expense: expense));
                          }
                        },
                      ),
                    ],
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
