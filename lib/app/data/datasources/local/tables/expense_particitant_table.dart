import 'package:moor/moor.dart';

class ExpenseParticipantTable extends Table {
  TextColumn get expenseRef => text()();

  TextColumn get personRef => text()();
}
