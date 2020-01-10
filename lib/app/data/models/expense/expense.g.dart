// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'expense.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Expense _$ExpenseFromJson(Map<String, dynamic> json) {
  $checkKeys(json, requiredKeys: const ['amount']);
  return Expense(
    id: json['id'] as String,
    createdAt: json['createdAt'] == null
        ? null
        : DateTime.parse(json['createdAt'] as String),
    updatedAt: json['updatedAt'] == null
        ? null
        : DateTime.parse(json['updatedAt'] as String),
    amount: (json['amount'] as num)?.toDouble(),
    people: (json['people'] as List)
            ?.map((e) =>
                e == null ? null : Person.fromJson(e as Map<String, dynamic>))
            ?.toList() ??
        [],
    paidBy: (json['paid_by'] as List)
            ?.map((e) =>
                e == null ? null : Person.fromJson(e as Map<String, dynamic>))
            ?.toList() ??
        [],
  );
}

Map<String, dynamic> _$ExpenseToJson(Expense instance) => <String, dynamic>{
  'id': instance.id,
  'createdAt': instance.createdAt?.toIso8601String(),
  'updatedAt': instance.updatedAt?.toIso8601String(),
      'amount': instance.amount,
      'people': instance.people,
  'paid_by': instance.paidBy,
    };
