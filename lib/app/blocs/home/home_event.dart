import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:tinh_tien/app/data/models/expense/expense_request.dart';

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

class CreateExpense extends HomeEvent {
  final ExpenseRequest expense;

  CreateExpense(this.expense);

  @override
  List<Object> get props => [];
}

class DeleteActivityEvent extends HomeEvent {
  final String activityId;

  DeleteActivityEvent(this.activityId);

  @override
  List<Object> get props => [];
}
