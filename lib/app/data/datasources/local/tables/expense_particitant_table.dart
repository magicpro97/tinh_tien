import 'package:moor/moor.dart';

class ExpenseParticipants extends Table {
  TextColumn get expenseRef => text()();

  TextColumn get personRef => text()();

  @override
  Set<Column> get primaryKey => {expenseRef, personRef};
}
