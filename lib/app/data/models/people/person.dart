import 'package:json_annotation/json_annotation.dart';

import '../base.dart';

part 'person.g.dart';

@JsonSerializable()
class Person extends Base {
  @JsonKey(name: '_id')
  final String id;

  @JsonKey(name: 'created_at')
  final DateTime createdAt;

  @JsonKey(name: 'updated_at')
  final DateTime updatedAt;

  @JsonKey()
  final String name;

  Person({
    this.id,
    this.createdAt,
    this.updatedAt,
    this.name,
  }) : super(id, createdAt, updatedAt);

  factory Person.fromJson(Map<String, dynamic> json) => _$PersonFromJson(json);

  Map<String, dynamic> toJson() => _$PersonToJson(this);

  @override
  String toString() {
    return name;
  }
}
