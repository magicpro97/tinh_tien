import 'package:moor/moor.dart';

import 'base_table.dart';

class People extends BaseTable {
  TextColumn get name => text()();

  Set<Column> get primaryKey => {id};
}
