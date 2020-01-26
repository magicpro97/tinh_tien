import 'package:equatable/equatable.dart';

abstract class ExpenseState extends Equatable {
  const ExpenseState();
}

class InitialExpenseState extends ExpenseState {
  @override
  List<Object> get props => [];
}

class ExpenseCreatedState extends ExpenseState {
  @override
  List<Object> get props => [];
}

class ExpenseEditedState extends ExpenseState {
  @override
  List<Object> get props => [];
}


class ExpenseErrorState extends ExpenseState {
  final String message;

  ExpenseErrorState(this.message);

  @override
  List<Object> get props => [message];
}