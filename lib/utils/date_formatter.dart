import 'package:intl/intl.dart';

class DateFormatter {
  static String get todayDate {
    final today = DateTime.now();
    return '${DateFormat.EEEE().format(today)}, ${DateFormat.MMMMd().format(today)}'
        .toUpperCase();
  }
}
