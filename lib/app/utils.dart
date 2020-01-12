class DateUtils {
  static isTheSameDate(DateTime dateTime1, DateTime dateTime2) =>
      dateTime1.difference(dateTime2).inDays == 0;
}
