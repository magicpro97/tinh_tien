import 'package:moor/moor.dart';

abstract class BaseTable extends Table {
  TextColumn get id => text()();

  DateTimeColumn get createdAt => dateTime()();

  DateTimeColumn get updateAt => dateTime()();
}
