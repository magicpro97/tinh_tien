import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';
import 'package:tinh_tien/app/data/datasources/local/activity_local_datasource.dart';
import 'package:tinh_tien/app/data/datasources/remote/activity_remote_datasource.dart';
import 'package:tinh_tien/app/data/models/activity/activity.dart';
import 'package:tinh_tien/app/data/models/activity/activity_request.dart';
import 'package:tinh_tien/app/data/models/activity/activity_shared_expenses.dart';
import 'package:tinh_tien/app/data/models/activity/activity_summary.dart';
import 'package:tinh_tien/app/data/models/no_data.dart';
import 'package:tinh_tien/app/network/no_network_connection_exception.dart';
import 'package:tinh_tien/core/errors/failures/activity_failure.dart';

class ActivityRepository {
  final ActivityRemoteDataSource activityDataSource;
  final ActivityLocalDataSource activityLocalDataSource;

  ActivityRepository({
    @required this.activityDataSource,
    @required this.activityLocalDataSource,
  });

  Future<Either<ActivityFailure, Activity>> createActivity(String name) async {
    try {
      final data = await activityDataSource.create(ActivityRequest(name));
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
      final data = await activityDataSource.getSummary(id);
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
      final data = await activityDataSource.get(id);
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
      final data = await activityDataSource.getSharedExpenses(id);
      return data.fold(
        (error) => Left(ActivityFailure(error.message)),
        (sharedExpense) => Right(sharedExpense),
      );
    } catch (e) {
      throw NoNetworkConnection();
    }
  }

  Future<Either<ActivityFailure, NoData>> deleteActivity(
      {String activityId}) async {
    try {
      final data = await activityDataSource.delete(activityId: activityId);
      return data.fold(
        (error) => Left(ActivityFailure(error.message)),
        (data) => Right(data),
      );
    } catch (e) {
      throw NoNetworkConnection();
    }
  }
}
