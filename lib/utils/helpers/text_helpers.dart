isNotNullOrEmpty(String text) {
  return text?.isNotEmpty ?? false;
}

dateTimeToHoursMinutes(DateTime date) {
  return '${date.hour}:${date.minute}';
}