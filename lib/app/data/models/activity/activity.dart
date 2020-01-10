import 'package:json_annotation/json_annotation.dart';
import 'package:tinh_tien/app/data/models/expense/expense.dart';
import 'package:tinh_tien/app/data/models/people/person.dart';

import '../base.dart';

part 'activity.g.dart';

@JsonSerializable()
class Activity extends Base {
  final String name;

  final List<Person> people;

  final List<Expense> expenses;

  Activity({
    @JsonKey(name: '_id') String id,
    @JsonKey(name: 'created_at') DateTime createdAt,
    @JsonKey(name: 'updated_at') DateTime updatedAt,
    this.name,
    this.people,
    this.expenses,
  }) : super(id, createdAt, updatedAt);

  factory Activity.fromJson(Map<String, dynamic> json) =>
      _$ActivityFromJson(json);

  Map<String, dynamic> toJson() => _$ActivityToJson(this);
}
