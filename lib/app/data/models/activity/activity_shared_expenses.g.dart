// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'activity_shared_expenses.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SharedExpenses _$SharedExpensesFromJson(Map<String, dynamic> json) {
  return SharedExpenses(
    paidBy: (json['paidBy'] as List)
        ?.map((e) =>
            e == null ? null : Person.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    paidFor: (json['paidFor'] as List)
        ?.map((e) =>
            e == null ? null : Person.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    amount: (json['amount'] as num)?.toDouble(),
  );
}

Map<String, dynamic> _$SharedExpensesToJson(SharedExpenses instance) =>
    <String, dynamic>{
      'paidBy': instance.paidBy,
      'paidFor': instance.paidFor,
      'amount': instance.amount,
    };
