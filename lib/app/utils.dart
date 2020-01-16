import 'package:intl/intl.dart';

class DateUtils {
  static bool isTheSameDate(DateTime dateTime1, DateTime dateTime2) =>
      dateTime1.difference(dateTime2).inDays == 0;

  static String toDate(DateTime dateTime) => DateFormat("dd/MM/yyy").format(dateTime);

  static String toDate2(DateTime dateTime) => DateFormat("dd/MM").format(dateTime);

  static String toTime(DateTime dateTime) => DateFormat("hh:mm").format(dateTime);
}
