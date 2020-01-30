import 'package:moor/moor.dart';

class ActivityMemberTable extends Table {
  TextColumn get activityRef => text()();

  TextColumn get personRef => text()();

  @override
  // TODO: implement primaryKey
  Set<Column> get primaryKey => {activityRef, personRef};
}
