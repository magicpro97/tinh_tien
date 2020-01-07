import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:tinh_tien/app/data/models/activity/activity.dart';
import 'package:tinh_tien/app/data/models/activity/activity_request.dart';
import 'package:tinh_tien/app/data/models/error/error_response.dart';

import '../../network/client.dart';

class ActivityDatasource {
  Future<Either<ErrorResponse, Activity>> createActivity(
      ActivityRequest activityRequest) async {
    try {
      final response =
          await dio.post('/activities', data: activityRequest.toJson());
      return Right(Activity.fromJson(response.data));
    } on DioError catch (e) {
      return Left(ErrorResponse.fromJson(e.response.data));
    }
  }
}
