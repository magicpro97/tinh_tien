import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
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
  List<AppChip> peopleItemList;

  @override
  void didChangeDependencies() {
    activity = activity ?? ModalRoute.of(context).settings.arguments;
    activity.people
        .addAll([Person(name: 'tri dep  trai'), Person(name: 'tri dep  trai 1')]);
    peopleItemList = activity.people
        .map((person) => AppChip(
              label: person.name,
            ))
        .toList();
    super.didChangeDependencies();
  }

  // @override
  // void initState() {

  //   super.initState();
  // }

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
              chips: peopleItemList,
            ),
            SizedBox(
              height: Dimens.NORMAL_PADDING,
            ),
            Text('Paid for:'),
            TextField(
              decoration: InputDecoration(hintText: 'Description Ex:Beer'),
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
            ),
            SizedBox(
              height: Dimens.NORMAL_PADDING,
            ),
            Text('Participants:'),
            ChipList(
              chips: peopleItemList,
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
                  onPressed: () {},
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
