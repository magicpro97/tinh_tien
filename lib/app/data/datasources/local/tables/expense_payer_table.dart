import 'package:moor/moor.dart';

class ExpensePayerTable extends Table {
  TextColumn get expenseRef => text()();

  TextColumn get personRef => text()();
}
