import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:tinh_tien/app/data/models/activity/activity.dart';
import 'package:tinh_tien/app/data/models/activity/activity_shared_expenses.dart';
import 'package:tinh_tien/app/data/models/activity/activity_summary.dart';

abstract class ActivityState extends Equatable {
  const ActivityState();
}

class InitialActivityState extends ActivityState {
  @override
  List<Object> get props => [];
}

class ActivityLoadingState extends ActivityState {
  @override
  List<Object> get props => [];
}

class ActivityLoadedState extends ActivityState {
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

class DeletedActivityState extends ActivityState {
  DeletedActivityState();

  @override
  List<Object> get props => [];
}

class CreatedActivityState extends ActivityState {
  final Activity activity;

  CreatedActivityState(this.activity);

  @override
  List<Object> get props => [activity];
}

class ActivityErrorState extends ActivityState {
  final String message;

  ActivityErrorState(this.message);

  @override
  List<Object> get props => [message];
}

class HasLastActivityState extends ActivityState {
  @override
  List<Object> get props => null;
}
