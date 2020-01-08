import 'package:json_annotation/json_annotation.dart';
import 'package:tinh_tien/app/data/models/people/person.dart';

part 'expense.g.dart';

@JsonSerializable()
class Expense {
  @JsonKey(required: true, name: '_id')
  final String id;

  @JsonKey(required: true)
  final double amount;

  @JsonKey(defaultValue: [])
  final List<Person> people;

  @JsonKey(defaultValue: [])
  final List<Person> paidBy;

  Expense({this.id, this.amount, this.people, this.paidBy});

  factory Expense.fromJson(Map<String, dynamic> json) =>
      _$ExpenseFromJson(json);

  Map<String, dynamic> toJson() => _$ExpenseToJson(this);
}
