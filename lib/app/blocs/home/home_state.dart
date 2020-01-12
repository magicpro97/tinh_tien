import 'package:equatable/equatable.dart';

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

class LoadedState extends HomeState {
  final Object object;

  LoadedState(this.object);

  @override
  List<Object> get props => [];
}

class ErrorState extends HomeState {
  final String message;

  ErrorState(this.message);

  @override
  List<Object> get props => [message];
}
