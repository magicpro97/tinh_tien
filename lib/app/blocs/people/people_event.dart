import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class PeopleEvent extends Equatable {
  const PeopleEvent();
}

class CreatePeopleEvent extends PeopleEvent {
  final String activityId;
  final String name;

  CreatePeopleEvent({@required this.name, @required this.activityId});

  @override
  List<Object> get props => [name];
}

class CreateActivityEvent extends PeopleEvent {
  final String name;

  CreateActivityEvent(this.name);

  @override
  List<Object> get props => [name];
}