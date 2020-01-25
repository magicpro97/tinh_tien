import 'package:dartz/dartz.dart';
import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:meta/meta.dart';
import 'package:tinh_tien/app/data/datasources/activity_datasource.dart';
import 'package:tinh_tien/app/data/models/activity/activity.dart';
import 'package:tinh_tien/app/data/models/activity/activity_request.dart';
import 'package:tinh_tien/app/data/models/activity/activity_shared_expenses.dart';
import 'package:tinh_tien/app/data/models/activity/activity_summary.dart';
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
          await activityDatasource.create(ActivityRequest(name));
      return data.fold(
        (error) => Left(ActivityFailure(error.message)),
        (activity) => Right(activity),
      );
    } else {
      throw NoNetworkConnection();
    }
  }

  Future<Either<ActivityFailure, ActivitySummary>> getSummary(String id) async {
    if (await hasNetworkConnection()) {
      final data = await activityDatasource.getSummary(id);
      return data.fold(
        (error) => Left(ActivityFailure(error.message)),
        (summary) => Right(summary),
      );
    } else {
      throw NoNetworkConnection();
    }
  }

  Future<Either<ActivityFailure, Activity>> getById(String id) async {
    if (await hasNetworkConnection()) {
      final data = await activityDatasource.get(id);
      return data.fold(
        (error) => Left(ActivityFailure(error.message)),
        (activity) => Right(activity),
      );
    } else {
      throw NoNetworkConnection();
    }
  }

  Future<Either<ActivityFailure, ActivitySharedExpenses>> getSharedExpenses(
      String id) async {
    if (await hasNetworkConnection()) {
      final data = await activityDatasource.getSharedExpenses(id);
      return data.fold(
        (error) => Left(ActivityFailure(error.message)),
        (sharedExpense) => Right(sharedExpense),
      );
    } else {
      throw NoNetworkConnection();
    }
  }

  Future<Either<ActivityFailure, Activity>> deleteActivity(
      {String activityId}) async {
    if (await hasNetworkConnection()) {
      final data =
          await activityDatasource.delete(activityId: activityId);
      return data.fold(
        (error) => Left(ActivityFailure(error.message)),
        (data) => Right(data),
      );
    } else {
      throw NoNetworkConnection();
    }
  }
}
