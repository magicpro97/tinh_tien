import 'package:json_annotation/json_annotation.dart';
import 'package:tinh_tien/app/data/models/expense/expense.dart';
import 'package:tinh_tien/app/data/models/people/person.dart';

part 'activity.g.dart';

@JsonSerializable()
class Activity {
  @JsonKey(required: true, name: '_id')
  final String id;

  @JsonKey(required: true)
  final String name;

  final List<Person> people;

  final List<Expense> expense;

  Activity({
    this.id,
    this.name,
    this.people,
    this.expense,
  });

  factory Activity.fromJson(Map<String, dynamic> json) =>
      _$ActivityFromJson(json);

  Map<String, dynamic> toJson() => _$ActivityToJson(this);
}
