import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:tinh_tien/app/blocs/home/bloc.dart';
import 'package:tinh_tien/app/data/models/expense/expense.dart';
import 'package:tinh_tien/app/data/models/people/person.dart';
import 'package:tinh_tien/app/utils.dart';
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
  HomeBloc _homeBloc;
  List<Person> _selectedPaidBys;
  List<Person> _selectedParticipants;
  DateTime _selectedTime;
  TextEditingController _paidFor;
  TextEditingController _amount;
  FocusNode _amountFocus;

  @override
  void initState() {
    _homeBloc = BlocProvider.of<HomeBloc>(context);
    _selectedPaidBys = [];
    _selectedParticipants = [];
    _selectedTime = DateTime.now();
    _paidFor = TextEditingController();
    _amount = TextEditingController();
    _amountFocus = FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    _paidFor.dispose();
    _amount.dispose();
    _amountFocus.dispose();
    super.dispose();
  }

  void _onPaidBySelected(selected, person) {
    if (selected && !_selectedPaidBys.contains(person)) {
      _selectedPaidBys.add(person);
    } else {
      _selectedPaidBys.remove(person);
    }
  }

  void _onParticipantSelected(selected, person) {
    if (selected && !_selectedParticipants.contains(person)) {
      _selectedParticipants.add(person);
    } else {
      _selectedParticipants.remove(person);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener(
      bloc: _homeBloc,
      listener: (_, state) {
        if (state is ExpenseCreatedState) {
          _homeBloc.add(GetActivity());
          //Navigator.pop(context);
        }
      },
      child: BlocBuilder<HomeBloc, HomeState>(
        bloc: _homeBloc,
        builder: (context, state) {
          return AppScaffold(
            appBarAction: <Widget>[],
            body: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text('Paid by:'),
                  if (state is ActivityLoadedState)
                    ListTile(
                      title: ChipList(
                        chips: state.activity.people
                            .map((person) =>
                            AppChip<Person>(
                                value: person,
                                label: person.name,
                                onChanged: _onPaidBySelected))
                            .toList(),
                      ),
                      subtitle: Text(
                          _selectedParticipants.isNotEmpty ? '' : 'Required'),
                    ),
                  SizedBox(
                    height: Dimens.NORMAL_PADDING,
                  ),
                  Text('Paid for:'),
                  TextField(
                    textInputAction: TextInputAction.go,
                    controller: _paidFor,
                    decoration: InputDecoration(
                      hintText: 'Description Ex:Beer',
                      errorText: _paidFor.text.length > 0 ? null : "Required",
                    ),
                    onSubmitted: (value) {
                      _amountFocus.requestFocus();
                    },
                  ),
                  SizedBox(
                    height: Dimens.NORMAL_PADDING,
                  ),
                  Text('Amount of money'),
                  TextField(
                    focusNode: _amountFocus,
                    textInputAction: TextInputAction.go,
                    controller: _amount,
                    decoration: InputDecoration(
                      hintText: 'Amount Ex:10000',
                      errorText: _amount.text.length > 0 ? null : "Required",
                    ),
                    keyboardType: TextInputType.numberWithOptions(
                        signed: true, decimal: false),
                    inputFormatters: <TextInputFormatter>[
                      WhitelistingTextInputFormatter.digitsOnly,
                    ],
                  ),
                  SizedBox(
                    height: Dimens.NORMAL_PADDING,
                  ),
                  Text('Participants:'),
                  if (state is ActivityLoadedState)
                    ChipList(
                      chips: state.activity.people
                          .map((person) =>
                          AppChip<Person>(
                              value: person,
                              label: person.name,
                              onChanged: _onParticipantSelected))
                          .toList(),
                    ),
                  SizedBox(
                    height: Dimens.NORMAL_PADDING,
                  ),
                  if (state is ActivityLoadedState)
                    GestureDetector(
                      onTap: () {
                        DatePicker.showDateTimePicker(context,
                            minTime: state.activity.createdAt,
                            onConfirm: (dateTime) {
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
                          style: Theme
                              .of(context)
                              .textTheme
                              .button,
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
                          style: Theme
                              .of(context)
                              .textTheme
                              .button
                              .apply(
                            color: AppColors.WHITE_TEXT,
                          ),
                        ),
                        onPressed: () {
                          final expense = Expense(
                            amount: double.parse(_amount.text),
                            people: _selectedParticipants,
                            paidBy: _selectedPaidBys,
                            date: _selectedTime,
                          );
                          log(expense.toJson().toString());
                          if (_paidFor.text.length > 0 &&
                              _amount.text.length > 0 &&
                              _selectedPaidBys.isNotEmpty &&
                              _selectedParticipants.isNotEmpty) {
                            _homeBloc.add(CreateExpense(expense));
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
