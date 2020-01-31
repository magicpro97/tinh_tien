import 'package:moor/moor.dart';

import 'local_database.dart';
import 'tables/acitivity_table.dart';
import 'tables/activity_member_table.dart';

part 'activity_local_datasource.g.dart';

@UseDao(
  tables: [Activities, ActivityMembers],
)
class ActivityLocalDataSource extends DatabaseAccessor<LocalDatabase>
    with _$ActivityLocalDatasourceMixin {
  ActivityLocalDataSource(LocalDatabase db) : super(db);
}
