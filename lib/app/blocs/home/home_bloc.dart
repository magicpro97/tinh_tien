import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tinh_tien/app/data/repositories/activity_repository.dart';
import 'package:tinh_tien/app/data/repositories/expense_repository.dart';
import 'package:tinh_tien/app/data/repositories/people_repository.dart';
import 'package:tinh_tien/app/network/no_network_connection_exception.dart';
import 'package:tinh_tien/common/constants.dart';
import 'package:tinh_tien/core/errors/exceptions/unknown_exception.dart';

import './bloc.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final SharedPreferences sharedPreferences;
  final PeopleRepository peopleRepository;
  final ActivityRepository activityRepository;
  final ExpenseRepository expenseRepository;

  HomeBloc({
    @required this.activityRepository,
    @required this.peopleRepository,
    @required this.sharedPreferences,
    @required this.expenseRepository,
  });

  @override
  HomeState get initialState => InitialHomeState();

  @override
  Stream<HomeState> mapEventToState(
    HomeEvent event,
  ) async* {
    log(event.toString(), name: 'HomeBloc');
    if (event is CreatePeopleEvent) {
      yield LoadingState();
      try {
        final data = await peopleRepository.create(
          name: event.name,
          activityId: event.activityId,
        );
        yield data.fold(
          (error) => ErrorState(error.message),
          (person) => PeopleCreatedState(person),
        );
      } catch (e) {
        if (e is NoNetworkConnection) {
          yield ErrorState(e.message);
        } else {
          yield ErrorState((e as UnknownException).message);
        }
      }
    } else if (event is GetActivity) {
      yield LoadingState();
      try {
        final activityId = sharedPreferences.getString(ACTIVITY_ID);
        final activityData = await activityRepository.getById(activityId);
        final summaryData = await activityRepository.getSummary(activityId);
        yield activityData.fold(
          (error) => ErrorState(error.message),
              (activity) =>
              summaryData.fold(
                      (error) => ErrorState(error.message),
                      (summary) =>
                      ActivityLoadedState(
                          activity: activity, activitySummary: summary)),
        );
      } catch (e) {
        if (e is NoNetworkConnection) {
          yield ErrorState(e.message);
        } else {
          yield ErrorState(UnknownException().message);
        }
      }
    } else if (event is CreateExpenseEvent) {
        yield LoadingState();
        try {
          final data = await expenseRepository.create(
              activityId: event.activityId,
              paidBy: event.paidBy,
              participants: event.participants,
              paidFor: event.paidFor,
              amount: event.amount
            );
          yield data.fold((error) => ErrorState(error.message),
              (expense) => ExpenseCreatedState(expense));
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
