import 'dart:io';

import 'package:moor/moor.dart';
import 'package:moor_ffi/moor_ffi.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:tinh_tien/app/data/datasources/local/activity_local_datasource.dart';

import 'tables/acitivity_table.dart';
import 'tables/activity_member_table.dart';
import 'tables/expense_particitant_table.dart';
import 'tables/expense_payer_table.dart';
import 'tables/expense_table.dart';
import 'tables/people_table.dart';

part 'local_database.g.dart';

LazyDatabase _openConnection() {
  // the LazyDatabase util lets us find the right location for the file async.
  return LazyDatabase(() async {
    // put the database file, called db.sqlite here, into the documents folder
    // for your app.
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'db.sqlite'));
    return VmDatabase(file);
  });
}

@UseMoor(
  tables: [
    Activities,
    ActivityMembers,
    ExpenseParticipants,
    ExpensePayers,
    Expenses,
    People,
  ],
  daos: [
    ActivityLocalDataSource,
  ],
)
class LocalDatabase extends _$LocalDatabase {
  LocalDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;
}
