import 'package:dartz/dartz.dart';
import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:meta/meta.dart';
import 'package:tinh_tien/app/data/datasources/expense_datasource.dart';
import 'package:tinh_tien/app/data/models/expense/expense.dart';
import 'package:tinh_tien/app/data/models/people/person.dart';
import 'package:tinh_tien/app/network/no_network_connection_exception.dart';
import 'package:tinh_tien/core/errors/failures/expense_failure.dart';

import 'base_repository.dart';

class ExpenseRepository extends BaseRepository {
  final ExpenseDatasouce expenseDatasource;

  ExpenseRepository({
    @required this.expenseDatasource,
    DataConnectionChecker dataConnectionChecker,
  }) : super(dataConnectionChecker);

  Future<Either<ExpenseFailure, Expense>> createExpense({
      String activityId,
      List<Person> paidBy,
      List<Person> participants,
      String paidFor,
      double amount}) async {
    if (await hasNetworkConnection()) {
      final data = await expenseDatasource.createExpense(
          activityId, paidBy, participants, paidFor, amount);
      return data.fold((error) => Left(ExpenseFailure(error.message)),
          (expense) => Right(expense));
    } else {
      throw NoNetworkConnection();
    }
  }
}
