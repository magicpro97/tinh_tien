import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:tinh_tien/app/data/repositories/activity_repository.dart';
import 'package:tinh_tien/app/data/repositories/expense_repository.dart';
import 'package:tinh_tien/app/data/repositories/people_repository.dart';
import 'package:meta/meta.dart';
import 'package:tinh_tien/app/network/no_network_connection_exception.dart';
import 'package:tinh_tien/core/errors/exceptions/unknown_exception.dart';
import './bloc.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final ExpenseRepository expenseRepository;
  final PeopleRepository peopleRepository;

  HomeBloc({
    @required this.peopleRepository,
    @required this.expenseRepository,
  });

  @override
  HomeState get initialState => InitialHomeState();

  @override
  Stream<HomeState> mapEventToState(
    HomeEvent event,
  ) async* {
    if (event is CreatePeopleEvent) {
      yield LoadingState();
      try {
        final data = await peopleRepository.create(
          name: event.name,
          activityId: event.activityId,
        );
        yield data.fold((error) => ErrorState(error.message),
            (person) => LoadedState(person));
      } catch (e) {
        if (e is NoNetworkConnection) {
          yield ErrorState(e.message);
        } else {
          yield ErrorState((e as UnknownException).message);
        }
      }
    }
    if (event is CreateExpenseEvent) {
      yield LoadingState();
      try {
        final data = await expenseRepository.createExpense(
            activityId: event.activityId,
            paidBy: event.paidBy,
            participants: event.participants,
            amount: event.amount,
            paidFor: event.paidFor
          );
        yield data.fold((error) => ErrorState(error.message),
            (expense) => LoadedState(expense));
      } catch (e) {
        if (e is NoNetworkConnection) {
          yield ErrorState(e.message);
        } else {
          yield ErrorState((e as UnknownException).message);
        }
      }
    }
  }
}
