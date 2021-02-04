isNotNullOrEmpty(String text) {
  return text?.isNotEmpty ?? false;
}

dateTimeToHoursMinutes(DateTime date) {
  return '${date.hour}:${date.minute}';
}

mapToTable(Map<String, double> map) {
  String res = "";
  map.forEach((key, value) => res += '$key: $value\n');
  return res;
}

dateTimeToddMMyy(DateTime date) => '${date.day}.${date.month}.${date.year}';

dateTimeToReadable(DateTime date) => '${dateTimeToddMMyy(date)} ${dateTimeToHoursMinutes(date)}';