import 'package:tinh_tien/app/data/models/activity/activity.dart';
import 'package:tinh_tien/app/data/models/expense/expense.dart';

class ExpenseArgument {
  final Activity activity;
  final Expense expense;

  ExpenseArgument(this.activity, this.expense);
}