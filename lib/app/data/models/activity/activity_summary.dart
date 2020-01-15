import 'package:json_annotation/json_annotation.dart';
import 'package:tinh_tien/app/data/models/base.dart';

part 'activity_summary.g.dart';

class ActivitySummary {
  final List<ExpenseSummary> expenseSummary;

  ActivitySummary({this.expenseSummary});

  factory ActivitySummary.fromJson(List json) =>
      ActivitySummary(
        expenseSummary:
            json.map((data) => ExpenseSummary.fromJson(data)).toList(),
      );
}

@JsonSerializable()
class ExpenseSummary extends Base {
  @JsonKey(name: '_id')
  final String id;

  @JsonKey(name: 'created_at')
  final DateTime createdAt;

  @JsonKey(name: 'updated_at')
  final DateTime updatedAt;

  final String name;

  final double spent;

  final double paid;

  final double amount;

  ExpenseSummary({
    this.id,
    this.createdAt,
    this.updatedAt,
    this.spent,
    this.paid,
    this.amount,
    this.name,
  }) : super(id, createdAt, updatedAt);

  factory ExpenseSummary.fromJson(Map<String, dynamic> json) =>
      _$ExpenseSummaryFromJson(json);

  Map<String, dynamic> toJson() => _$ExpenseSummaryToJson(this);
}
