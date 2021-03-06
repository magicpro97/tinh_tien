import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:tinh_tien/app/data/models/activity/activity.dart';
import 'package:tinh_tien/app/data/models/activity/activity_request.dart';
import 'package:tinh_tien/app/data/models/activity/activity_shared_expenses.dart';
import 'package:tinh_tien/app/data/models/activity/activity_summary.dart';
import 'package:tinh_tien/app/data/models/error/error_response.dart';
import 'package:tinh_tien/app/data/models/no_data.dart';

import '../../../network/client.dart';

class ActivityRemoteDataSource {
  Future<Either<ErrorResponse, Activity>> create(
      ActivityRequest activityRequest) async {
    try {
      final response =
          await dio.post(ACTIVITIES, data: activityRequest.toJson());
          log(response.data.toString(), name: 'ActivityRemoteDatasource');
      return Right(Activity.fromJson(response.data));
    } on DioError catch (e) {
      return Left(ErrorResponse.fromJson(e.response.data));
    }
  }

  Future<Either<ErrorResponse, Activity>> get(String id) async {
    try {
      final response = await dio.get('$ACTIVITIES/$id');
      return Right(Activity.fromJson(response.data));
    } on DioError catch (e) {
      return Left(ErrorResponse.fromJson(e.response.data));
    }
  }

  Future<Either<ErrorResponse, ActivitySummary>> getSummary(String id) async {
    try {
      final response = await dio.get('$ACTIVITIES/$id/$SUMMARY');
      return Right(ActivitySummary.fromJson(response.data as List));
    } on DioError catch (e) {
      return Left(ErrorResponse.fromJson(e.response.data));
    }
  }

  Future<Either<ErrorResponse, ActivitySharedExpenses>> getSharedExpenses(
      String id) async {
    try {
      final response = await dio.get('$ACTIVITIES/$id/$SHARED_EXPENSES');
      return Right(ActivitySharedExpenses.fromJson(response.data as List));
    } on DioError catch (e) {
      return Left(ErrorResponse.fromJson(e.response.data));
    }
  }

  Future<Either<ErrorResponse, NoData>> delete(
      {String activityId}) async {
    try {
      await dio.delete('$ACTIVITIES/$activityId');
      return Right(NoData());
    } on DioError catch (e) {
      return Left(ErrorResponse.fromJson(e.response.data));
    }
  }
}
