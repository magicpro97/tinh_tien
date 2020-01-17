import 'package:equatable/equatable.dart';

abstract class WelcomeEvent extends Equatable {
  const WelcomeEvent();
}

class CreateActivityEvent extends WelcomeEvent {
  final String name;

  CreateActivityEvent(this.name);

  @override
  List<Object> get props => [name];
}

class GetActivityEvent extends WelcomeEvent {
  final String id;

  GetActivityEvent(this.id);

  @override
  List<Object> get props => [id];
}
