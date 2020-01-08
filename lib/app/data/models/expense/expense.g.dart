// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'expense.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Expense _$ExpenseFromJson(Map<String, dynamic> json) {
  $checkKeys(json, requiredKeys: const ['_id', 'amount']);
  return Expense(
    id: json['_id'] as String,
    amount: (json['amount'] as num)?.toDouble(),
    people: (json['people'] as List)
            ?.map((e) =>
                e == null ? null : Person.fromJson(e as Map<String, dynamic>))
            ?.toList() ??
        [],
    paidBy: (json['paidBy'] as List)
            ?.map((e) =>
                e == null ? null : Person.fromJson(e as Map<String, dynamic>))
            ?.toList() ??
        [],
  );
}

Map<String, dynamic> _$ExpenseToJson(Expense instance) => <String, dynamic>{
      '_id': instance.id,
      'amount': instance.amount,
      'people': instance.people,
      'paidBy': instance.paidBy,
    };
