import 'package:intl/intl.dart';

isNotNullOrEmpty(String text) {
  return text?.isNotEmpty ?? false;
}

dateTimeToHoursMinutes(DateTime date) {
  DateFormat format = DateFormat.Hm();
  return '${format.format(date)}';
}

mapToTable(Map<String, double> map) {
  String res = "";
  map.forEach((key, value) => res += '$key: $value\n');
  return res;
}

dateTimeToddMMyy(DateTime date) => '${date.day}.${date.month}.${date.year}';

dateTimeToReadable(DateTime date) => '${dateTimeToddMMyy(date)} ${dateTimeToHoursMinutes(date)}';