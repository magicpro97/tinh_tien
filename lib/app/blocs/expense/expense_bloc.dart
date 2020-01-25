import 'dart:async';
import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:tinh_tien/app/data/repositories/expense_repository.dart';
import 'package:tinh_tien/app/network/no_network_connection_exception.dart';
import 'package:tinh_tien/core/errors/exceptions/unknown_exception.dart';
import './bloc.dart';
import 'package:meta/meta.dart';

class ExpenseBloc extends Bloc<ExpenseEvent, ExpenseState> {
  final ExpenseRepository expenseRepository;

  ExpenseBloc({@required this.expenseRepository});

  @override
  ExpenseState get initialState => InitialExpenseState();

  @override
  Stream<ExpenseState> mapEventToState(
    ExpenseEvent event,
  ) async* {
    log(event.toString());
    if (event is CreateExpense) {
      try {
        final data = await expenseRepository.create(
            activityId: event.activityId, expenseRequest: event.expense);
        yield data.fold(
          (error) => ExpenseErrorState(error.message),
          (data) => ExpenseCreatedState(),
        );
      } catch (e) {
        if (e is NoNetworkConnection) {
          yield ExpenseErrorState(e.message);
        } else {
          yield ExpenseErrorState(UnknownException().message);
        }
      }
    }
  }
}
