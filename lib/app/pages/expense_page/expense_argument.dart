import 'package:json_annotation/json_annotation.dart';
import 'package:tinh_tien/app/data/models/activity/activity.dart';
import 'package:tinh_tien/app/data/models/expense/expense.dart';

part 'expense_argument.g.dart';

@JsonSerializable()
class ExpenseArgument {
  final Activity activity;
  final Expense expense;

  ExpenseArgument(this.activity, this.expense);

  factory ExpenseArgument.fromJson(Map<String, dynamic> json) => _$ExpenseArgumentFromJson(json);

  Map<String, dynamic> toJson() => _$ExpenseArgumentToJson(this);
}