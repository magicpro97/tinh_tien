import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

abstract class ActivityEvent extends Equatable {
  const ActivityEvent();
}

class GetActivity extends ActivityEvent {
  final String activityId;

  GetActivity({@required this.activityId});

  @override
  List<Object> get props => [activityId];
}

class GetLastActivityEvent extends ActivityEvent {
  @override
  List<Object> get props => [];
}

class DeleteActivity extends ActivityEvent {
  final String activityId;

  DeleteActivity(this.activityId);

  @override
  List<Object> get props => [];
}

class CreateActivity extends ActivityEvent {
  final String name;

  CreateActivity(this.name);

  @override
  List<Object> get props => [name];
}
