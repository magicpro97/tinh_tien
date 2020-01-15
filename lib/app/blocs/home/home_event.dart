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

class CreateExpenseEvent extends HomeEvent {
  final String activityId;
  final String paidFor;
  final List<Person> participants;
  final List<Person> paidBy;
  final double amount;

  CreateExpenseEvent(
      {@required this.activityId,
      @required this.paidBy,
      @required this.participants,
      @required this.amount,
      @required this.paidFor,});

  @override
  List<Object> get props => [activityId, paidBy, participants, amount, paidFor];
}

