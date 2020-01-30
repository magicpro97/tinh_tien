import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';
import 'package:tinh_tien/app/data/models/error/error_response.dart';
import 'package:tinh_tien/app/data/models/expense/expense.dart';
import 'package:tinh_tien/app/data/models/expense/expense_request.dart';
import 'package:tinh_tien/app/data/models/no_data.dart';
import 'package:tinh_tien/app/network/client.dart';

class ExpenseRemoteDatasource {
  Future<Either<ErrorResponse, NoData>> create({
    @required String activityId,
    @required ExpenseRequest expenseRequest,
  }) async {
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
    @required String activityId,
    @required ExpenseRequest expenseRequest,
    @required String expenseId,
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

  Future<Either<ErrorResponse, NoData>> delete({
    @required String activityId,
    @required String expenseId,
  }) async {
    try {
      await dio.delete(
        '$ACTIVITIES/$activityId/$EXPENSES/$expenseId',
      );
      return Right(NoData());
    } on DioError catch (e) {
      return Left(ErrorResponse.fromJson(e.response.data));
    }
  }

  Future<Either<ErrorResponse, List<Expense>>> gets({
    @required String activityId,
  }) async {
    try {
      final response = await dio.get('$ACTIVITIES/$activityId/$EXPENSES');
      return Right((response.data as List)
          .map((data) => Expense.fromJson(data))
          .toList());
    } on DioError catch (e) {
      return Left(ErrorResponse.fromJson(e.response.data));
    }
  }
}
