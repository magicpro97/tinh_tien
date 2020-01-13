import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:tinh_tien/app/data/models/error/error_response.dart';
import 'package:tinh_tien/app/data/models/people/person.dart';
import 'package:tinh_tien/app/network/client.dart';

class PeopleDatasouce {
  Future<Either<ErrorResponse, Person>> createPeople(
      String activityId, String name) async {
    try {
      final response = await dio.post(
          '$ACTIVITIES/$activityId/people', data: {"name": name});
      return Right(Person.fromJson(response.data));
    } on DioError catch (e) {
      return Left(ErrorResponse.fromJson(e.response.data));
    }
  }
}
