import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class PeopleEvent extends Equatable {
  const PeopleEvent();
}

class CreatePeople extends PeopleEvent {
  final String activityId;
  final String name;

  CreatePeople({
    @required this.name,
    @required this.activityId,
  });

  @override
  List<Object> get props => [name];
}

class EditPeople extends PeopleEvent {
  final String activityId;
  final String personId;
  final String name;

  EditPeople({
    @required this.personId,
    @required this.name,
    @required this.activityId,
  });

  @override
  List<Object> get props => [name];
}

class DeletePeople extends PeopleEvent {
  final String activityId;
  final String personId;

  DeletePeople({
    @required this.personId,
    @required this.activityId,
  });

  @override
  List<Object> get props => [personId, activityId];
}

class GetPeopleEvent extends PeopleEvent {
  final String activityId;

  GetPeopleEvent({
    @required this.activityId,
  });

  @override
  List<Object> get props => [activityId];
}
