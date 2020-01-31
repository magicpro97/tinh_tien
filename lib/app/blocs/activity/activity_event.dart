import 'package:equatable/equatable.dart';

abstract class ActivityEvent extends Equatable {
  const ActivityEvent();
}

class GetActivityEvent extends ActivityEvent {
  final String activityId;

  GetActivityEvent({this.activityId});

  @override
  List<Object> get props => [activityId];
}

class GetLastActivityEvent extends ActivityEvent {
  @override
  List<Object> get props => [];
}

class DeleteActivityEvent extends ActivityEvent {
  final String activityId;

  DeleteActivityEvent(this.activityId);

  @override
  List<Object> get props => [];
}

class CreateActivityEvent extends ActivityEvent {
  final String name;

  CreateActivityEvent(this.name);

  @override
  List<Object> get props => [name];
}
