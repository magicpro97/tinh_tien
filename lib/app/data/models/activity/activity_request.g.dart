// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'activity_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ActivityRequest _$ActivityRequestFromJson(Map<String, dynamic> json) {
  $checkKeys(json, requiredKeys: const ['name']);
  return ActivityRequest(
    json['name'] as String,
  );
}

Map<String, dynamic> _$ActivityRequestToJson(ActivityRequest instance) =>
    <String, dynamic>{
      'name': instance.name,
    };
