import 'package:moor/moor.dart';
import 'package:tinh_tien/app/data/datasources/local/tables/expense_particitant_table.dart';
import 'package:tinh_tien/app/data/datasources/local/tables/expense_payer_table.dart';
import 'package:tinh_tien/app/data/datasources/local/tables/expense_table.dart';

import 'local_database.dart';

part 'expense_local_datasource.g.dart';

@UseDao(
  tables: [Expenses, ExpenseParticipants, ExpensePayers],
)
class ExpenseLocalDataSource extends DatabaseAccessor<LocalDatabase>
    with _$ExpenseLocalDataSourceMixin {
  ExpenseLocalDataSource(LocalDatabase db) : super(db);
}
