import 'package:equatable/equatable.dart';
import 'package:tinh_tien/app/data/models/activity/activity.dart';

abstract class WelcomeState extends Equatable {
  const WelcomeState();
}

class InitialWelcomeState extends WelcomeState {
  @override
  List<Object> get props => [];
}

class ErrorState extends WelcomeState {
  final String message;

  ErrorState(this.message);

  @override
  List<Object> get props => [message];
}

class ActivityLoading extends WelcomeState {
  @override
  List<Object> get props => [];
}

class ActivityLoaded extends WelcomeState {
  final Activity activity;

  ActivityLoaded(this.activity);

  @override
  List<Object> get props => [activity];
}
