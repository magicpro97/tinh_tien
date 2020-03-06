import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:tinh_tien/app/data/repositories/expense_repository.dart';
import 'package:tinh_tien/app/network/no_network_connection_exception.dart';
import 'package:tinh_tien/core/errors/exceptions/unknown_exception.dart';

import './bloc.dart';

class ExpenseBloc extends Bloc<ExpenseEvent, ExpenseState> {
  final ExpenseRepository expenseRepository;

  ExpenseBloc({@required this.expenseRepository});

  @override
  ExpenseState get initialState => InitialExpenseState();

  @override
  Stream<ExpenseState> mapEventToState(
    ExpenseEvent event,
  ) async* {
    try {
      if (event is CreateExpense) {
        yield* _createEvent(event);
      } else if (event is EditExpense) {
        yield* _editEvent(event);
      } else if (event is DeleteExpense) {
        yield* _deleteEvent(event);
      }
    } catch (e) {
      _handleError(e);
    }
  }

  Stream<ExpenseState> _deleteEvent(DeleteExpense event) async* {
    final data = await expenseRepository.delete(
      activityId: event.activityId,
      expenseId: event.expenseId,
    );
    yield data.fold(
          (error) => ExpenseErrorState(error.message),
          (data) => ExpenseDeletedState(),
    );
  }

  Stream<ExpenseState> _createEvent(CreateExpense event) async* {
    final data = await expenseRepository.create(
      activityId: event.activityId,
      expenseRequest: event.expense,
    );
    yield data.fold(
          (error) => ExpenseErrorState(error.message),
          (data) => ExpenseCreatedState(),
    );
  }

  Stream<ExpenseState> _editEvent(EditExpense event) async* {
    final data = await expenseRepository.update(
      activityId: event.activityId,
      expenseRequest: event.expense,
      expenseId: event.expenseId,
    );
    yield data.fold(
          (error) => ExpenseErrorState(error.message),
          (data) => ExpenseCreatedState(),
    );
  }

  Stream<ExpenseState> _handleError(Exception e) async* {
    if (e is NoNetworkConnection) {
      yield ExpenseErrorState(e.message);
    } else {
      yield ExpenseErrorState(UnknownException().message);
    }
  }
}
