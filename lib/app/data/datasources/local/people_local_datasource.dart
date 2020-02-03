import 'package:moor/moor.dart';
import 'package:tinh_tien/app/data/datasources/local/local_database.dart';
import 'package:tinh_tien/app/data/datasources/local/tables/people_table.dart';

part 'people_local_datasource.g.dart';

@UseDao(
  tables: [People],
)
class PeopleLocalDataSource extends DatabaseAccessor<LocalDatabase>
    with _$PeopleLocalDataSourceMixin {
  PeopleLocalDataSource(LocalDatabase db) : super(db);
}
