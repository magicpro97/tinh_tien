// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'activity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Activity _$ActivityFromJson(Map<String, dynamic> json) {
  $checkKeys(json, requiredKeys: const ['_id', 'name']);
  return Activity(
    json['_id'] as String,
    json['name'] as String,
  );
}

Map<String, dynamic> _$ActivityToJson(Activity instance) => <String, dynamic>{
      '_id': instance.id,
      'name': instance.name,
    };
