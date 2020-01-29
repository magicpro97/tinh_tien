import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';
import 'package:tinh_tien/app/data/datasources/activity_datasource.dart';
import 'package:tinh_tien/app/data/models/activity/activity.dart';
import 'package:tinh_tien/app/data/models/activity/activity_request.dart';
import 'package:tinh_tien/app/data/models/activity/activity_shared_expenses.dart';
import 'package:tinh_tien/app/data/models/activity/activity_summary.dart';
import 'package:tinh_tien/app/network/no_network_connection_exception.dart';
import 'package:tinh_tien/core/errors/failures/activity_failure.dart';

class ActivityRepository {
  final ActivityDatasource activityDatasource;

  ActivityRepository({
    @required this.activityDatasource,
  });

  Future<Either<ActivityFailure, Activity>> createActivity(String name) async {
    try {
      final data = await activityDatasource.create(ActivityRequest(name));
      return data.fold(
        (error) => Left(ActivityFailure(error.message)),
        (activity) => Right(activity),
      );
    } catch (e) {
      throw NoNetworkConnection();
    }
  }

  Future<Either<ActivityFailure, ActivitySummary>> getSummary(String id) async {
    try {
      final data = await activityDatasource.getSummary(id);
      return data.fold(
        (error) => Left(ActivityFailure(error.message)),
        (summary) => Right(summary),
      );
    } catch (e) {
      throw NoNetworkConnection();
    }
  }

  Future<Either<ActivityFailure, Activity>> getById(String id) async {
    try {
      final data = await activityDatasource.get(id);
      return data.fold(
        (error) => Left(ActivityFailure(error.message)),
        (activity) => Right(activity),
      );
    } catch (e) {
      throw NoNetworkConnection();
    }
  }

  Future<Either<ActivityFailure, ActivitySharedExpenses>> getSharedExpenses(
      String id) async {
    try {
      final data = await activityDatasource.getSharedExpenses(id);
      return data.fold(
        (error) => Left(ActivityFailure(error.message)),
        (sharedExpense) => Right(sharedExpense),
      );
    } catch (e) {
      throw NoNetworkConnection();
    }
  }

  Future<Either<ActivityFailure, Activity>> deleteActivity(
      {String activityId}) async {
    try {
      final data = await activityDatasource.delete(activityId: activityId);
      return data.fold(
        (error) => Left(ActivityFailure(error.message)),
        (data) => Right(data),
      );
    } catch (e) {
      throw NoNetworkConnection();
    }
  }
}
