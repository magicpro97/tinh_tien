import 'package:moor/moor.dart';

import 'base_table.dart';

class ExpenseTable extends BaseTable {
  RealColumn get amount => real()();

  TextColumn get paidFor => text()();
}
