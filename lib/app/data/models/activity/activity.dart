import 'package:json_annotation/json_annotation.dart';

part 'activity.g.dart';

@JsonSerializable()
class Activity {
  @JsonKey(required: true, name: '_id')
  final String id;

  @JsonKey(required: true)
  final String name;

  Activity(this.id, this.name);

  factory Activity.fromJson(Map<String, dynamic> json) => _$ActivityFromJson(json);

  Map<String, dynamic> toJson() => _$ActivityToJson(this);
}