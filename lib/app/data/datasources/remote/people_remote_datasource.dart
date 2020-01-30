import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';
import 'package:tinh_tien/app/data/models/error/error_response.dart';
import 'package:tinh_tien/app/data/models/no_data.dart';
import 'package:tinh_tien/app/data/models/people/person.dart';
import 'package:tinh_tien/app/network/client.dart';

class PeopleRemoteDatasouce {
  Future<Either<ErrorResponse, Person>> create({
    @required String activityId,
    @required String name,
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
    @required String activityId,
    @required String name,
    @required String personId,
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
    @required String activityId,
    @required String personId,
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

  Future<Either<ErrorResponse, List<Person>>> getPeople({
    @required String activityId,
  }) async {
    try {
      final response = await dio.get('$ACTIVITIES/$activityId/peope');
      return Right((response.data as List)
          .map((data) => Person.fromJson(data))
          .toList());
    } on DioError catch (e) {
      return Left(ErrorResponse.fromJson(e.response.data));
    }
  }
}
