// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'expense_argument.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ExpenseArgument _$ExpenseArgumentFromJson(Map<String, dynamic> json) {
  return ExpenseArgument(
    json['activity'] == null
        ? null
        : Activity.fromJson(json['activity'] as Map<String, dynamic>),
    json['expense'] == null
        ? null
        : Expense.fromJson(json['expense'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$ExpenseArgumentToJson(ExpenseArgument instance) =>
    <String, dynamic>{
      'activity': instance.activity.toJson(),
      'expense': instance?.expense?.toJson() ?? null,
    };
