import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:tinh_tien/app/data/models/activity/activity.dart';
import 'package:tinh_tien/app/data/models/activity/activity_shared_expenses.dart';
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
  final ActivitySummary activitySummary;
  final ActivitySharedExpenses activitySharedExpenses;

  ActivityLoadedState({
    @required this.activity,
    @required this.activitySummary,
    @required this.activitySharedExpenses,
  });

  @override
  List<Object> get props => [activity, activitySummary, activitySharedExpenses];
}

class PeopleCreatedState extends HomeState {
  final Person person;

  PeopleCreatedState(this.person);

  @override
  List<Object> get props => [person];
}

class ExpenseCreatedState extends HomeState {
  @override
  List<Object> get props => [];
}

class DeleteActivityState extends HomeState {
  final Activity activity;

  DeleteActivityState(this.activity);

  @override
  List<Object> get props => [activity];
}

class DeletedPeopleState extends HomeState {
  final Person people;

  DeletedPeopleState(this.people);

  @override
  List<Object> get props => [people];
}

class EditedPeopleState extends HomeState {
  final Person people;

  EditedPeopleState(this.people);

  @override
  List<Object> get props => [people];
}

class ErrorState extends HomeState {
  final String message;

  ErrorState(this.message);

  @override
  List<Object> get props => [message];
}
