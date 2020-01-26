import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class PeopleEvent extends Equatable {
  const PeopleEvent();
}

class CreatePeopleEvent extends PeopleEvent {
  final String activityId;
  final String name;

  CreatePeopleEvent({
    @required this.name,
    @required this.activityId,
  });

  @override
  List<Object> get props => [name];
}

class EditPeopleEvent extends PeopleEvent {
  final String activityId;
  final String personId;
  final String name;

  EditPeopleEvent({
    @required this.personId,
    @required this.name,
    @required this.activityId,
  });

  @override
  List<Object> get props => [name];
}

class DeletePeopleEvent extends PeopleEvent {
  final String activityId;
  final String personId;

  DeletePeopleEvent({
    @required this.personId,
    @required this.activityId,
  });

  @override
  List<Object> get props => [personId, activityId];
}
