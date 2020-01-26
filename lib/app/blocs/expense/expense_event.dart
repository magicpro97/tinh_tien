import 'package:equatable/equatable.dart';
import 'package:tinh_tien/app/data/models/expense/expense_request.dart';
import 'package:meta/meta.dart';

abstract class ExpenseEvent extends Equatable {
  const ExpenseEvent();
}

class CreateExpense extends ExpenseEvent {
  final String activityId;
  final ExpenseRequest expense;

  CreateExpense({
    @required this.expense,
    @required this.activityId,
  });

  @override
  List<Object> get props => [expense, activityId];
}

class EditExpense extends ExpenseEvent {
  final String activityId;
  final ExpenseRequest expense;
  final String expenseId;

  EditExpense({
    @required this.expense,
    @required this.activityId,
    @required this.expenseId,
  });

  @override
  List<Object> get props => [expense, activityId, expenseId];
}

class DeleteExpense extends ExpenseEvent {
  final String activityId;
  final String expenseId;

  DeleteExpense({
    @required this.activityId,
    @required this.expenseId,
  });

  @override
  List<Object> get props => [activityId, expenseId];
}
