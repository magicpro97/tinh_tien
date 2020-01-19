import 'package:json_annotation/json_annotation.dart';
import 'package:tinh_tien/app/data/models/people/person.dart';

part 'expense_request.g.dart';

@JsonSerializable()
class ExpenseRequest {
  @JsonKey(required: true)
  final double amount;

  @JsonKey(defaultValue: [])
  final List<Person> people;

  @JsonKey(defaultValue: [], name: 'paid_by')
  final List<Person> paidBy;

  final DateTime date;

  @JsonKey(name: 'paid_for')
  final String paidFor;

  const ExpenseRequest({this.amount, this.people, this.paidBy, this.date, this.paidFor});

  factory ExpenseRequest.fromJson(Map<String, dynamic> json) => _$ExpenseRequestFromJson(json);

  Map<String, dynamic> toJson() => _$ExpenseRequestToJson(this);
}
