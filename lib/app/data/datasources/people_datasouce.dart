import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:tinh_tien/app/data/models/error/error_response.dart';
import 'package:tinh_tien/app/data/models/people/person.dart';
import 'package:tinh_tien/app/network/client.dart';

class PeopleDatasouce {
  Future<Either<ErrorResponse, Person>> createPerson(
      String activityId, String name) async {
    try {
      final response = await dio.post(
          '$ACTIVITIES/$activityId/people', data: {"name": name});
      return Right(Person.fromJson(response.data));
    } on DioError catch (e) {
      return Left(ErrorResponse.fromJson(e.response.data));
    }
  }

  Future<Either<ErrorResponse, Person>> editPerson(
      String activityId, String personId, String name) async {
    try {
      final response = await dio.put(
          '$ACTIVITIES/$activityId/people/$personId', data: {"name": name});
      return Right(Person.fromJson(response.data));
    } on DioError catch (e) {
      return Left(ErrorResponse.fromJson(e.response.data));
    }
  }

  Future<Either<ErrorResponse, Person>> deletePerson(
      String personId, String activityId) async {
    try {
      final response = await dio.delete(
          '$ACTIVITIES/$activityId/people/$personId');
      return Right(Person.fromJson(response.data));
    } on DioError catch (e) {
      return Left(ErrorResponse.fromJson(e.response.data));
    }
  }
}
