import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';
import 'package:tinh_tien/app/data/datasources/local/expense_local_datasource.dart';
import 'package:tinh_tien/app/data/datasources/remote/expense_remote_datasource.dart';
import 'package:tinh_tien/app/data/models/expense/expense.dart';
import 'package:tinh_tien/app/data/models/expense/expense_request.dart';
import 'package:tinh_tien/app/data/models/no_data.dart';
import 'package:tinh_tien/app/network/no_network_connection_exception.dart';
import 'package:tinh_tien/core/errors/failures/expense_failure.dart';

class ExpenseRepository {
  final ExpenseRemoteDataSource expenseDataSource;
  final ExpenseLocalDataSource expenseLocalDataSource;

  ExpenseRepository({
    @required this.expenseDataSource,
    @required this.expenseLocalDataSource,
  });

  Future<Either<ExpenseFailure, NoData>> create({
    @required String activityId,
    @required ExpenseRequest expenseRequest,
  }) async {
    try {
      final data = await expenseDataSource.create(
          activityId: activityId, expenseRequest: expenseRequest);
      return data.fold(
        (error) => Left(ExpenseFailure(error.message)),
        (data) => Right(data),
      );
    } catch (e) {
      throw NoNetworkConnection();
    }
  }

  Future<Either<ExpenseFailure, NoData>> update({
    @required String activityId,
    @required ExpenseRequest expenseRequest,
    @required String expenseId,
  }) async {
    try {
      final data = await expenseDataSource.update(
        activityId: activityId,
        expenseRequest: expenseRequest,
        expenseId: expenseId,
      );
      return data.fold(
        (error) => Left(ExpenseFailure(error.message)),
        (data) => Right(data),
      );
    } catch (e) {
      throw NoNetworkConnection();
    }
  }

  Future<Either<ExpenseFailure, NoData>> delete({
    @required String activityId,
    @required String expenseId,
  }) async {
    try {
      final data = await expenseDataSource.delete(
        activityId: activityId,
        expenseId: expenseId,
      );
      return data.fold(
        (error) => Left(ExpenseFailure(error.message)),
        (data) => Right(data),
      );
    } catch (e) {
      throw NoNetworkConnection();
    }
  }

  Future<Either<ExpenseFailure, List<Expense>>> gets({
    @required String activityId,
  }) async {
    try {
      final data = await expenseDataSource.gets(activityId: activityId);
      return data.fold(
        (error) => Left(ExpenseFailure(error.message)),
        (expenses) => Right(expenses),
      );
    } catch (e) {
      throw NoNetworkConnection();
    }
  }
}
