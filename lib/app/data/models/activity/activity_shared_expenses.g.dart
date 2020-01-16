// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'activity_shared_expenses.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SharedExpenses _$SharedExpensesFromJson(Map<String, dynamic> json) {
  return SharedExpenses(
    paidBy: json['paid_by'] == null
        ? null
        : Person.fromJson(json['paid_by'] as Map<String, dynamic>),
    paidFor: json['paid_for'] == null
        ? null
        : Person.fromJson(json['paid_for'] as Map<String, dynamic>),
    amount: (json['amount'] as num)?.toDouble(),
  );
}

Map<String, dynamic> _$SharedExpensesToJson(SharedExpenses instance) =>
    <String, dynamic>{
      'paid_by': instance.paidBy,
      'paid_for': instance.paidFor,
      'amount': instance.amount,
    };
