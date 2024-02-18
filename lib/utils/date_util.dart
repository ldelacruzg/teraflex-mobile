import 'package:intl/intl.dart';

class DateUtil {
  static List<DateTime> thisWeek() {
    final today = DateTime.now();
    final monday = today.subtract(Duration(days: today.weekday - 1));
    List<DateTime> thisWeek = [];

    for (int i = 0; i < 7; i++) {
      thisWeek.add(monday.add(Duration(days: i)));
    }

    return thisWeek;
  }

  static String getShortDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }

  static String convertDate(String date) {
    DateTime parsedDate = DateTime.parse(date);
    String formattedDate = DateFormat('dd/MM/yyyy').format(parsedDate);
    return formattedDate;
  }
}
