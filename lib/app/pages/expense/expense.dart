import 'package:flutter/material.dart';
import 'package:tinh_tien/app/widgets/app_scaffold.dart';
import 'package:tinh_tien/common/dimens.dart';

class Expense extends StatefulWidget {
  @override
  _ExpenseState createState() => _ExpenseState();
}

class _ExpenseState extends State<Expense> {
  String _option;
  final options = ['All', 'Choose particular participant'];

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      appBarAction: <Widget>[
        Center(child: Text('Add a new expense')),
      ],
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: Dimens.NORMAL_PADDING),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('Paid by'),
            TextField(),
            Text('Participants:'),
            Radio(value: _option, groupValue: options, onChanged: (value) {
              _option = value;
            }),
          ],
        ),
      ),
    );
  }
}
