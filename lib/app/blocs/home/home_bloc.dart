import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:tinh_tien/app/data/repositories/activity_repository.dart';
import 'package:tinh_tien/app/data/repositories/people_repository.dart';
import 'package:tinh_tien/app/network/no_network_connection_exception.dart';
import 'package:tinh_tien/core/errors/exceptions/unknown_exception.dart';

import './bloc.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final PeopleRepository peopleRepository;
  final ActivityRepository activityRepository;

  HomeBloc({
    @required this.peopleRepository,
    @required this.activityRepository,
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
    } else if (event is GetActivitySummary) {
      try {
        final data = await activityRepository.getSummary(event.id);
        yield data.fold(
              (error) => ErrorState(error.message),
              (summary) => SummaryLoadedState(summary),
        );
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
