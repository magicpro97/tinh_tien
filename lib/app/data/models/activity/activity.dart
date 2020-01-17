import 'dart:math';

import 'package:json_annotation/json_annotation.dart';
import 'package:tinh_tien/app/data/models/expense/expense.dart';
import 'package:tinh_tien/app/data/models/people/person.dart';
import 'package:tinh_tien/app/utils.dart';

import '../base.dart';

part 'activity.g.dart';

@JsonSerializable()
class Activity extends Base {
  @JsonKey(name: '_id')
  final String id;

  @JsonKey(name: 'created_at')
  final DateTime createdAt;

  @JsonKey(name: 'updated_at')
  final DateTime updatedAt;

  final String name;

  final List<Person> people;

  final List<Expense> expenses;

  Activity({
    this.id,
    this.createdAt,
    this.updatedAt,
    this.name,
    this.people,
    this.expenses,
  }) : super(id, createdAt, updatedAt);

  factory Activity.fromJson(Map<String, dynamic> json) =>
      _$ActivityFromJson(json);

  Map<String, dynamic> toJson() => _$ActivityToJson(this);

  List<ActivityExpenseInDay> get expenseADay =>
      expenses.fold([], (previous, expense) {
        if (previous.isNotEmpty) {
          final lastExpense = previous.last;
          final isSameDay =
          DateUtils.isTheSameDate(lastExpense.createdAt, expense.createdAt);
          if (isSameDay) {
            previous.last.expenses.add(expense);
          } else {
            previous.add(ActivityExpenseInDay(
                createdAt: expense.createdAt, expenses: [expense]));
          }
        } else {
          previous.add(ActivityExpenseInDay(
              createdAt: expense.createdAt, expenses: [expense]));
        }
        return previous;
      });

  double get maxExpenseADay => expenseADay.fold(0, (previous, expense) {
    previous = max(previous, expense.total);
    return previous;
  });

  double get totalExpense =>
      expenses.fold(0, (previous, element) => previous + element.amount);

  double get averageExpense =>
      people.length > 0 ? totalExpense / people.length : 0;
}

class ActivityExpenseInDay {
  final DateTime createdAt;
  final List<Expense> expenses;

  ActivityExpenseInDay({this.createdAt, this.expenses});

  double get total =>
      expenses.fold(0, (previous, expense) => previous += expense.amount);
}
