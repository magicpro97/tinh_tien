import 'package:moor/moor.dart';

class ActivityMembers extends Table {
  TextColumn get activityRef =>
      text()();

  TextColumn get personRef => text()();

  @override
  Set<Column> get primaryKey => {activityRef, personRef};
}
