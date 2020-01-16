// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'activity_summary.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ExpenseSummary _$ExpenseSummaryFromJson(Map<String, dynamic> json) {
  return ExpenseSummary(
    id: json['_id'] as String,
    createdAt: json['created_at'] == null
        ? null
        : DateTime.parse(json['created_at'] as String),
    updatedAt: json['updated_at'] == null
        ? null
        : DateTime.parse(json['updated_at'] as String),
    spent: (json['spent'] as num)?.toDouble(),
    paid: (json['paid'] as num)?.toDouble(),
    amount: (json['amount'] as num)?.toDouble(),
  );
}

Map<String, dynamic> _$ExpenseSummaryToJson(ExpenseSummary instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'created_at': instance.createdAt?.toIso8601String(),
      'updated_at': instance.updatedAt?.toIso8601String(),
      'spent': instance.spent,
      'paid': instance.paid,
      'amount': instance.amount,
    };
