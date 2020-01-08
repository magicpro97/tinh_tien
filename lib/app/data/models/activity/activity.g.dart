// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'activity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Activity _$ActivityFromJson(Map<String, dynamic> json) {
  $checkKeys(json, requiredKeys: const ['_id', 'name']);
  return Activity(
    id: json['_id'] as String,
    name: json['name'] as String,
    people: (json['people'] as List)
        ?.map((e) =>
    e == null ? null : Person.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    expense: (json['expense'] as List)
        ?.map((e) =>
    e == null ? null : Expense.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$ActivityToJson(Activity instance) => <String, dynamic>{
      '_id': instance.id,
      'name': instance.name,
  'people': instance.people,
  'expense': instance.expense,
    };
