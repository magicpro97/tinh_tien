import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:tinh_tien/app/blocs/activity/bloc.dart';
import 'package:tinh_tien/app/blocs/expense/bloc.dart';
import 'package:tinh_tien/app/data/models/activity/activity.dart';
import 'package:tinh_tien/app/data/models/expense/expense.dart';
import 'package:tinh_tien/app/data/models/expense/expense_request.dart';
import 'package:tinh_tien/app/data/models/people/person.dart';
import 'package:tinh_tien/app/pages/expense_page/expense_argument.dart';
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
  Expense _expense;

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
    final data = ModalRoute.of(context).settings.arguments;
    if (data is Activity) {
      _activity = ModalRoute.of(context).settings.arguments;
    } else if (data is ExpenseArgument) {
      _activity = data.activity;
      _expense = data.expense;
      _expense.paidBy.forEach((person) => _selectedPaidBys.add(person));
      _expense.people.forEach((person) => _selectedParticipants.add(person));
      _paidFor.text = _expense.paidFor;
      _amount.text = _expense.amount.toInt().toString();
      _selectedTime = _expense.date;
    }
    super.didChangeDependencies();
  }

  void _onPaidBySelected(selected, person) {
    final tempPerson = _selectedPaidBys.firstWhere((p1) => p1.id == person.id,
        orElse: () => null);
    if (selected && tempPerson == null) {
      _selectedPaidBys.add(person);
    } else {
      _selectedPaidBys.remove(tempPerson);
    }
    _paidByForValidator.add(_selectedPaidBys.length);
  }

  void _onParticipantSelected(selected, person) {
    final tempPerson = _selectedParticipants
        .firstWhere((p1) => p1.id == person.id, orElse: () => null);
    if (selected && tempPerson == null) {
      _selectedParticipants.add(person);
    } else {
      _selectedParticipants.remove(tempPerson);
    }
    _participantValidator.add(_selectedParticipants.length);
  }

  @override
  Widget build(BuildContext context) {
    final paidByChips = _activity.people
            .map(
              (person) => AppChip<Person>(
                value: person,
                label: person.name,
                onChanged: _onPaidBySelected,
                checked: _selectedPaidBys.firstWhere((p1) => p1.id == person.id,
                        orElse: () => null) !=
                    null,
              ),
            )
            .toList() ??
        [];
    final paticipantChips = _activity.people
            .map(
              (person) => AppChip<Person>(
                value: person,
                label: person.name,
                onChanged: _onParticipantSelected,
                checked: _selectedParticipants.firstWhere(
                        (p1) => p1.id == person.id,
                        orElse: () => null) !=
                    null,
              ),
            )
            .toList() ??
        [];

    return BlocListener<ExpenseBloc, ExpenseState>(
      bloc: _expenseBloc,
      listener: (context, state) {
        if (state is ExpenseCreatedState || state is ExpenseEditedState) {
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
                      chips: paidByChips,
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
                        style: Theme.of(context).textTheme.title.apply(
                              color: AppColors.MAIN_COLOR,
                            ),
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
                        style: Theme.of(context).textTheme.title.apply(
                              color: AppColors.MAIN_COLOR,
                            ),
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
                      chips: paticipantChips,
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
                      DatePicker.showDateTimePicker(
                        context,
                        minTime: _activity.createdAt,
                        currentTime: _selectedTime ?? DateTime.now(),
                        onConfirm: (dateTime) {
                          setState(() {
                            _selectedTime = dateTime;
                          });
                        },
                      );
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
                          'Save',
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
                            if (_expense == null) {
                              _expenseBloc.add(CreateExpense(
                                activityId: _activity.id,
                                expense: expense,
                              ));
                            } else {
                              _expenseBloc.add(EditExpense(
                                expenseId: _expense.id,
                                activityId: _activity.id,
                                expense: expense,
                              ));
                            }
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
