import 'package:dartz/dartz.dart';
import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:meta/meta.dart';
import 'package:tinh_tien/app/data/datasources/activity_datasource.dart';
import 'package:tinh_tien/app/data/models/activity/activity.dart';
import 'package:tinh_tien/app/data/models/activity/activity_request.dart';
import 'package:tinh_tien/app/data/repositories/base_repository.dart';
import 'package:tinh_tien/app/network/no_network_connection_exception.dart';
import 'package:tinh_tien/core/errors/failures/activity_failure.dart';

class ActivityRepository extends BaseRepository {
  final ActivityDatasource activityDatasource;

  ActivityRepository({
    @required this.activityDatasource,
    @required DataConnectionChecker dataConnectionChecker,
  }) : super(dataConnectionChecker);

  Future<Either<ActivityFailure, Activity>> createActivity(String name) async {
    if (await hasNetworkConnection()) {
      final data =
          await activityDatasource.createActivity(ActivityRequest(name));
      return data.fold((error) => Left(ActivityFailure(error.message)),
          (activity) => Right(activity));
    } else {
      throw NoNetworkConnection();
    }
  }
}
