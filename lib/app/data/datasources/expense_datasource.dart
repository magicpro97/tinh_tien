import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:tinh_tien/app/data/models/error/error_response.dart';
import 'package:tinh_tien/app/data/models/expense/expense.dart';
import 'package:tinh_tien/app/data/models/people/person.dart';
import 'package:tinh_tien/app/network/client.dart';

class ExpenseDatasouce {
  Future<Either<ErrorResponse, Expense>> createExpense(
      String activityId,
      List<Person> paidBy,
      List<Person> participants,
      String paidFor,
      double amount
      ) async {
    try {
      final response =
          await dio.post('$ACTIVITIES/$activityId/expenses', data: {
        "activity": activityId,
        "amount": amount,
        "paid_for": paidFor,
        "people": participants,
        "paid_by": paidBy
      });
      return Right(Expense.fromJson(response.data));
    } on DioError catch (e) {
      return Left(ErrorResponse.fromJson(e.response.data));
    }
  }
}
