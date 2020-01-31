import 'package:moor/moor.dart';

import 'base_table.dart';

class Expenses extends BaseTable {
  RealColumn get amount => real()();

  TextColumn get paidFor => text()();

  Set<Column> get primaryKey => {id};
}
