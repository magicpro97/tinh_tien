import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:tinh_tien/app/data/repositories/people_repository.dart';
import 'package:tinh_tien/app/network/no_network_connection_exception.dart';
import 'package:tinh_tien/core/errors/exceptions/unknown_exception.dart';

import './bloc.dart';

class PeopleBloc extends Bloc<PeopleEvent, PeopleState> {
  final PeopleRepository peopleRepository;

  PeopleBloc({@required this.peopleRepository});

  @override
  PeopleState get initialState => PeopleLoadingState();

  @override
  Stream<PeopleState> mapEventToState(
    PeopleEvent event,
  ) async* {
    yield PeopleLoadingState();
    try {
      if (event is CreatePeople) {
        yield* _createEvent(event);
      } else if (event is EditPeople) {
        yield* _editEvent(event);
      } else if (event is DeletePeople) {
        yield* _deleteEvent(event);
      }
    } catch (e) {
      yield* _handleError(e);
    }
  }

  Stream<PeopleState> _handleError(Exception e) async* {
    if (e is NoNetworkConnection) {
      yield PeopleErrorState(e.message);
    } else {
      yield PeopleErrorState(UnknownException().message);
    }
  }

  Stream<PeopleState> _createEvent(CreatePeople event) async* {
    final data = await peopleRepository.create(
      name: event.name,
      activityId: event.activityId,
    );
    yield data.fold(
          (error) => PeopleErrorState(error.message),
          (person) => PeopleCreatedState(person),
    );
  }

  Stream<PeopleState> _editEvent(EditPeople event) async* {
    final data = await peopleRepository.update(
      name: event.name,
      activityId: event.activityId,
      personId: event.personId,
    );
    yield data.fold(
          (error) => PeopleErrorState(error.message),
          (person) => PeopleEditedState(),
    );
  }

  Stream<PeopleState> _deleteEvent(DeletePeople event) async* {
    final data = await peopleRepository.delete(
      activityId: event.activityId,
      personId: event.personId,
    );
    yield data.fold(
          (error) => PeopleErrorState(error.message),
          (person) => PeopleDeletedState(),
    );
  }
}
