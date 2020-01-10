import 'package:equatable/equatable.dart';
import 'package:tinh_tien/app/data/models/activity/activity.dart';

abstract class WelcomeState extends Equatable {
  const WelcomeState();
}

class InitialWelcomeState extends WelcomeState {
  @override
  List<Object> get props => [];
}

class CreateActivityFail extends WelcomeState {
  final String message;

  CreateActivityFail(this.message);

  @override
  List<Object> get props => [message];
}

class CreateActivityLoading extends WelcomeState {
  @override
  List<Object> get props => [];
}

class CreateActivitySuccess extends WelcomeState {
  final Activity activity;

  CreateActivitySuccess(this.activity);

  @override
  List<Object> get props => [activity];
}
