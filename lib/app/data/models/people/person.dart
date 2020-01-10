import 'package:json_annotation/json_annotation.dart';

import '../base.dart';

part 'person.g.dart';

@JsonSerializable()
class Person extends Base {
  @JsonKey(required: true)
  final String name;

  Person({
    @JsonKey(name: '_id') String id,
    @JsonKey(name: 'created_at') DateTime createdAt,
    @JsonKey(name: 'updated_at') DateTime updatedAt,
    this.name,
  }) : super(id, createdAt, updatedAt);

  factory Person.fromJson(Map<String, dynamic> json) => _$PersonFromJson(json);

  Map<String, dynamic> toJson() => _$PersonToJson(this);
}
