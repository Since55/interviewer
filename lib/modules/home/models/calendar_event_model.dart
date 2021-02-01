import 'package:googleapis/calendar/v3.dart';

class CalendarEventModel {
  String id;
  String name;
  DateTime startDate;
  String creatorEmail;
  String description;

  CalendarEventModel({id, name});

  CalendarEventModel.fromApi(Event event) {
    try {
      this.id = event.id;
      this.name = event.summary;
      this.description = event.description;
      this.creatorEmail = event.creator.email;
      this.startDate = event.start.dateTime.add(
        Duration(hours: 2),
      );
    } catch (e) {
      print(e);
    }
  }
}
