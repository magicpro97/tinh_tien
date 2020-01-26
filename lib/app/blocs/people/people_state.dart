import 'package:equatable/equatable.dart';
import 'package:tinh_tien/app/data/models/people/person.dart';

abstract class PeopleState extends Equatable {
  const PeopleState();
}

class InitialPeopleState extends PeopleState {
  @override
  List<Object> get props => [];
}

class PeopleErrorState extends PeopleState {
  final String message;

  PeopleErrorState(this.message);

  @override
  List<Object> get props => [message];
}

class PeopleCreatedState extends PeopleState {
  final Person person;

  PeopleCreatedState(this.person);

  @override
  List<Object> get props => [person];
}

class PeopleDeletedState extends PeopleState {
  @override
  List<Object> get props => [];
}

class PeopleEditedState extends PeopleState {
  @override
  List<Object> get props => [];
}

class PeopleLoadingState extends PeopleState {
  @override
  List<Object> get props => [];
}
