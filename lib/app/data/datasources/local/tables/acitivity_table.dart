import 'package:moor/moor.dart';

import 'base_table.dart';

class ActivityTable extends BaseTable {
  TextColumn get name => text()();
}
