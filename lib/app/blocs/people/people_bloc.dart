import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:tinh_tien/app/data/repositories/people_repository.dart';
import 'package:tinh_tien/app/network/no_network_connection_exception.dart';
import 'package:tinh_tien/core/errors/exceptions/unknown_exception.dart';
import './bloc.dart';
import 'package:meta/meta.dart';

class PeopleBloc extends Bloc<PeopleEvent, PeopleState> {
  final PeopleRepository peopleRepository;

  PeopleBloc({@required this.peopleRepository});

  @override
  PeopleState get initialState => InitialPeopleState();

  @override
  Stream<PeopleState> mapEventToState(
    PeopleEvent event,
  ) async* {
    if (event is CreatePeopleEvent) {
      yield PeopleLoadingState();
      try {
        final data = await peopleRepository.create(
          name: event.name,
          activityId: event.activityId,
        );
        yield data.fold(
          (error) => PeopleErrorState(error.message),
          (person) => PeopleCreatedState(person),
        );
      } catch (e) {
        if (e is NoNetworkConnection) {
          yield PeopleErrorState(e.message);
        } else {
          yield PeopleErrorState(UnknownException().message);
        }
      }
    } else if (event is EditPeopleEvent) {
      yield PeopleLoadingState();
      try {
        final data = await peopleRepository.update(
          name: event.name,
          activityId: event.activityId,
          personId: event.personId,
        );
        yield data.fold(
          (error) => PeopleErrorState(error.message),
          (person) => PeopleEditedState(),
        );
      } catch (e) {
        if (e is NoNetworkConnection) {
          yield PeopleErrorState(e.message);
        } else {
          yield PeopleErrorState(UnknownException().message);
        }
      }
    } else if (event is DeletePeopleEvent) {
      yield PeopleLoadingState();
      try {
        final data = await peopleRepository.delete(
          activityId: event.activityId,
          personId: event.personId,
        );
        yield data.fold(
          (error) => PeopleErrorState(error.message),
          (person) => PeopleDeletedState(),
        );
      } catch (e) {
        if (e is NoNetworkConnection) {
          yield PeopleErrorState(e.message);
        } else {
          yield PeopleErrorState(UnknownException().message);
        }
      }
    }
  }
}
