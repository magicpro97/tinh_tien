import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:tinh_tien/app/data/models/people/person.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();
}

class CreatePeopleEvent extends HomeEvent {
  final String activityId;
  final String name;

  CreatePeopleEvent({@required this.name, @required this.activityId});

  @override
  List<Object> get props => [name];
}

class GetActivity extends HomeEvent {
  @override
  List<Object> get props => [];
}

class DisplayData extends HomeEvent {
  @override
  List<Object> get props => [];
}
class CreateExpenseEvent extends HomeEvent {
  final String activityId;
  final List<Person> paidBy;
  final List<Person> participants;
  final String paidFor;
  final double amount;

  CreateExpenseEvent(
      {@required this.activityId,
      @required this.paidBy,
      @required this.participants,
      @required this.paidFor,
      @required this.amount});

  @override
  List<Object> get props => [activityId, paidBy, participants, paidFor, amount];
}

