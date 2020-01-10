// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'activity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Activity _$ActivityFromJson(Map<String, dynamic> json) {
  return Activity(
    id: json['id'] as String,
    createdAt: json['createdAt'] == null
        ? null
        : DateTime.parse(json['createdAt'] as String),
    updatedAt: json['updatedAt'] == null
        ? null
        : DateTime.parse(json['updatedAt'] as String),
    name: json['name'] as String,
    people: (json['people'] as List)
        ?.map((e) =>
    e == null ? null : Person.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    expenses: (json['expenses'] as List)
        ?.map((e) =>
    e == null ? null : Expense.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$ActivityToJson(Activity instance) => <String, dynamic>{
  'id': instance.id,
  'createdAt': instance.createdAt?.toIso8601String(),
  'updatedAt': instance.updatedAt?.toIso8601String(),
      'name': instance.name,
  'people': instance.people,
  'expenses': instance.expenses,
    };
