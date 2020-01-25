import 'package:dartz/dartz.dart';
import 'package:tinh_tien/app/data/models/error/error_response.dart';
import 'package:tinh_tien/app/data/models/expense/expense_request.dart';
import 'package:tinh_tien/app/data/models/no_data.dart';
import 'package:tinh_tien/app/network/client.dart';
import 'package:dio/dio.dart';

class ExpenseDatasource {
  Future<Either<ErrorResponse, NoData>> create(
      {String activityId, ExpenseRequest expenseRequest}) async {
    try {
      await dio.post(
        '$ACTIVITIES/$activityId/$EXPENSES',
        data: expenseRequest.toJson(),
      );
      return Right(NoData());
    } on DioError catch (e) {
      return Left(ErrorResponse.fromJson(e.response.data));
    }
  }

  Future<Either<ErrorResponse, NoData>> update({
    String activityId,
    ExpenseRequest expenseRequest,
    String expenseId,
  }) async {
    try {
      await dio.put(
        '$ACTIVITIES/$activityId/$EXPENSES/$expenseId',
        data: expenseRequest.toJson(),
      );
      return Right(NoData());
    } on DioError catch (e) {
      return Left(ErrorResponse.fromJson(e.response.data));
    }
  }

  Future<Either<ErrorResponse, NoData>> delete(
      {String activityId, String expenseId}) async {
    try {
      await dio.delete(
        '$ACTIVITIES/$activityId/$EXPENSES/$expenseId',
      );
      return Right(NoData());
    } on DioError catch (e) {
      return Left(ErrorResponse.fromJson(e.response.data));
    }
  }
}
