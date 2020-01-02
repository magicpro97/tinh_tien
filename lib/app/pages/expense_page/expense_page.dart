import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
  String _option;
  final options = ['All', 'Choose particular participant'];
  final chips = [
    AppChip(
      label: '1cxzcxzcxczxz',
      onChanged: (value) {},
    ),
    AppChip(
      label: '1cxzcxzcxczxz',
      onChanged: (value) {},
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      appBarAction: <Widget>[
        Center(child: Text('Add a new expense')),
      ],
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text('Paid by:'),
          ChipList(
            chips: chips,
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
            chips: chips,
          ),
          SizedBox(
            height: Dimens.LARGE_PADDING,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              FlatButton(
                child: Text('Back', style: Theme.of(context).textTheme.button,),
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
    );
  }
}
