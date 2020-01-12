import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();
}

class CreatePeopleEvent extends HomeEvent {
  final String activityId;
  final String name;

  CreatePeopleEvent({@required this.name,@required this.activityId});

  @override
  List<Object> get props => [name];
}
