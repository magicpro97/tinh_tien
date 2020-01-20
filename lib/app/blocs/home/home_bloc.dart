import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tinh_tien/app/data/repositories/activity_repository.dart';
import 'package:tinh_tien/app/data/repositories/people_repository.dart';
import 'package:tinh_tien/app/network/no_network_connection_exception.dart';
import 'package:tinh_tien/common/constants.dart';
import 'package:tinh_tien/core/errors/exceptions/unknown_exception.dart';

import './bloc.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final SharedPreferences sharedPreferences;
  final PeopleRepository peopleRepository;
  final ActivityRepository activityRepository;

  HomeBloc({
    @required this.peopleRepository,
    @required this.activityRepository,
    @required this.sharedPreferences,
  });

  @override
  HomeState get initialState => InitialHomeState();

  @override
  Stream<HomeState> mapEventToState(
    HomeEvent event,
  ) async* {
    log(event.toString());
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
          yield ErrorState(UnknownException().message);
        }
      }
    } else if (event is GetActivity) {
      yield LoadingState();
      try {
        final activityId = sharedPreferences.getString(ACTIVITY_ID);
        final data = await Future.wait([
          activityRepository.getById(activityId),
          activityRepository.getSummary(activityId),
          activityRepository.getSharedExpenses(activityId),
        ]);
        final error = data.firstWhere((e) => e.isLeft(), orElse: () => null);
        if (error != null) {
          yield ErrorState(error.fold((error) => error.message, null));
        } else {
          yield ActivityLoadedState(
              activity: data[0].fold(null, (data) => data),
              activitySummary: data[1].fold(null, (data) => data),
              activitySharedExpenses: data[2].fold(null, (data) => data));
        }
      } catch (e) {
        if (e is NoNetworkConnection) {
          yield ErrorState(e.message);
        } else {
          yield ErrorState(UnknownException().message);
        }
      }
    } else if (event is CreateExpense) {
      try {
        final activityId = sharedPreferences.getString(ACTIVITY_ID);
        final data = await activityRepository.createExpense(
            activityId: activityId, expenseRequest: event.expense);
        yield data.fold(
          (error) => ErrorState(error.message),
          (data) => ExpenseCreatedState(),
        );
      } catch (e) {
        if (e is NoNetworkConnection) {
          yield ErrorState(e.message);
        } else {
          yield ErrorState(UnknownException().message);
        }
      }
    } else if (event is DeleteActivityEvent) {
      try {
        final activityId = event.activityId;
        final data =
            await activityRepository.deleteActivity(activityId: activityId);
        yield data.fold((error) => ErrorState(error.message),
            (activity) => DeleteActivityState(activity));
      } catch (e) {
        if (e is NoNetworkConnection) {
          yield ErrorState(e.message);
        } else {
          yield ErrorState(UnknownException().message);
        }
      }
    }
  }
}
