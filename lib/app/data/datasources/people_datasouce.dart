import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:tinh_tien/app/data/models/error/error_response.dart';
import 'package:tinh_tien/app/data/models/no_data.dart';
import 'package:tinh_tien/app/data/models/people/person.dart';
import 'package:tinh_tien/app/network/client.dart';

class PeopleDatasouce {
  Future<Either<ErrorResponse, Person>> create({
    String activityId,
    String name,
  }) async {
    try {
      final response = await dio
          .post('$ACTIVITIES/$activityId/people', data: {"name": name});
      return Right(Person.fromJson(response.data));
    } on DioError catch (e) {
      return Left(ErrorResponse.fromJson(e.response.data));
    }
  }

  Future<Either<ErrorResponse, NoData>> update({
    String activityId,
    String name,
    String personId,
  }) async {
    try {
      await dio.put(
        '$ACTIVITIES/$activityId/people/$personId',
        data: {"name": name},
      );
      return Right(NoData());
    } on DioError catch (e) {
      return Left(ErrorResponse.fromJson(e.response.data));
    }
  }

  Future<Either<ErrorResponse, NoData>> delete({
    String activityId,
    String personId,
  }) async {
    try {
      await dio.delete(
        '$ACTIVITIES/$activityId/people/$personId',
      );
      return Right(NoData());
    } on DioError catch (e) {
      return Left(ErrorResponse.fromJson(e.response.data));
    }
  }
}
