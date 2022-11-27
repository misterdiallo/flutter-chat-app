import 'package:intl/intl.dart';

String reformatDate(DateTime datesent) {
  DateTime date = DateTime.utc(datesent.year, datesent.month, datesent.day,
      datesent.hour, datesent.minute, datesent.second);
  DateTime now = DateTime.now();
  final difference = date.difference(now);
  if (difference.inDays > 7) {
    return '${date.month}/${date.day}';
  } else {
    String name = DateFormat('EEEE').format(date);
    return '$name ${date.hour}:${date.minute}';
  }
}
