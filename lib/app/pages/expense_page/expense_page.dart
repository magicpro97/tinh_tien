import 'package:flutter/material.dart';
import 'package:tinh_tien/app/widgets/app_chip.dart';
import 'package:tinh_tien/app/widgets/app_scaffold.dart';
import 'package:tinh_tien/app/widgets/chip_list.dart';
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
          Text('Participants:'),
          ChipList(
            chips: chips,
          ),
        ],
      ),
    );
  }
}
