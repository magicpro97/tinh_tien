import 'package:json_annotation/json_annotation.dart';
import 'package:tinh_tien/app/data/models/people/person.dart';

import '../base.dart';

part 'expense.g.dart';

@JsonSerializable()
class Expense extends Base {
  @JsonKey(name: '_id')
  final String id;
  @JsonKey(name: 'created_at')
  final DateTime createdAt;
  @JsonKey(name: 'updated_at')
  final DateTime updatedAt;

  @JsonKey(required: true)
  final double amount;

  @JsonKey(defaultValue: [])
  final List<Person> people;

  @JsonKey(defaultValue: [], name: 'paid_by')
  final List<Person> paidBy;

  Expense({
    this.id,
    this.createdAt,
    this.updatedAt,
    this.amount,
    this.people,
    this.paidBy,
  }) : super(id, createdAt, updatedAt);

  factory Expense.fromJson(Map<String, dynamic> json) =>
      _$ExpenseFromJson(json);

  Map<String, dynamic> toJson() => _$ExpenseToJson(this);
}
