import 'package:dartz/dartz.dart';
import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:tinh_tien/app/data/datasources/expense_datasource.dart';
import 'package:tinh_tien/app/data/models/expense/expense_request.dart';
import 'package:tinh_tien/app/data/models/no_data.dart';
import 'package:tinh_tien/app/data/repositories/base_repository.dart';
import 'package:tinh_tien/app/network/no_network_connection_exception.dart';
import 'package:tinh_tien/core/errors/failures/activity_failure.dart';
import 'package:meta/meta.dart';

class ExpenseRepository extends BaseRepository {
  final DataConnectionChecker dataConnectionChecker;
  final ExpenseDatasource expenseDatasource;

  ExpenseRepository(
      {@required this.expenseDatasource, @required this.dataConnectionChecker})
      : super(dataConnectionChecker);

  Future<Either<ActivityFailure, NoData>> create(
      {String activityId, ExpenseRequest expenseRequest}) async {
    if (await hasNetworkConnection()) {
      final data = await expenseDatasource.createExpense(
          activityId: activityId, expenseRequest: expenseRequest);
      return data.fold(
        (error) => Left(ActivityFailure(error.message)),
        (data) => Right(data),
      );
    } else {
      throw NoNetworkConnection();
    }
  }
}
