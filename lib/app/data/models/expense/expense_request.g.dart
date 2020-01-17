// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'expense_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ExpenseRequest _$ExpenseRequestFromJson(Map<String, dynamic> json) {
  $checkKeys(json, requiredKeys: const ['amount']);
  return ExpenseRequest(
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
    date: json['date'] == null ? null : DateTime.parse(json['date'] as String),
    paidFor: json['paid_for'] as String,
  );
}

Map<String, dynamic> _$ExpenseRequestToJson(ExpenseRequest instance) =>
    <String, dynamic>{
      'amount': instance.amount,
      'people': instance.people,
      'paid_by': instance.paidBy,
      'date': instance.date?.toIso8601String(),
      'paid_for': instance.paidFor,
    };
