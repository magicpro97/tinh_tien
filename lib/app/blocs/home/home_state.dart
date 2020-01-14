import 'package:equatable/equatable.dart';
import 'package:tinh_tien/app/data/models/activity/activity.dart';
import 'package:tinh_tien/app/data/models/activity/activity_summary.dart';
import 'package:tinh_tien/app/data/models/people/person.dart';

abstract class HomeState extends Equatable {
  const HomeState();
}

class InitialHomeState extends HomeState {
  @override
  List<Object> get props => [];
}

class LoadingState extends HomeState {
  @override
  List<Object> get props => [];
}

class ActivityLoadedState extends HomeState {
  final Activity activity;

  ActivityLoadedState(this.activity);

  @override
  List<Activity> get props => [activity];
}

class SummaryLoadedState extends HomeState {
  final ActivitySummary activitySummary;

  SummaryLoadedState(this.activitySummary);

  @override
  List<Object> get props => [activitySummary];
}

class PeopleCreatedState extends HomeState {
  final Person person;

  PeopleCreatedState(this.person);

  @override
  List<Object> get props => [person];
}

class ErrorState extends HomeState {
  final String message;

  ErrorState(this.message);

  @override
  List<Object> get props => [message];
}
