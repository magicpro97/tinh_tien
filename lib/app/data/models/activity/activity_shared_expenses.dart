import 'package:json_annotation/json_annotation.dart';
import 'package:tinh_tien/app/data/models/people/person.dart';

part 'activity_shared_expenses.g.dart';

class ActivitySharedExpenses {
  final List<SharedExpenses> sharedExpenses;

  ActivitySharedExpenses({this.sharedExpenses});

  factory ActivitySharedExpenses.fromJson(List json) => ActivitySharedExpenses(
        sharedExpenses:
            json.map((data) => SharedExpenses.fromJson(data)).toList(),
      );
}

@JsonSerializable()
class SharedExpenses {
  final List<Person> paidBy;

  final List<Person> paidFor;

  final double amount;

  SharedExpenses({this.paidBy, this.paidFor, this.amount});

  factory SharedExpenses.fromJson(Map<String, dynamic> json) =>
      _$SharedExpensesFromJson(json);
}
