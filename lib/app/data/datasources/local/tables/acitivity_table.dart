import 'package:moor/moor.dart';

import 'base_table.dart';

@DataClassName("Activity")
class Activities extends BaseTable {
  TextColumn get name => text()();

  Set<Column> get primaryKey => {id};
}
