import 'package:equatable/equatable.dart';

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
  @override
  List<Object> get props => [];
}
