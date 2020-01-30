import 'package:moor/moor.dart';

import 'base_table.dart';

class PeopleTable extends BaseTable {
  TextColumn get name => text()();

  Set<Column> get primaryKey => {id};
}
