import 'package:googleapis/calendar/v3.dart';
import 'package:interviewer/constants/roles.dart';

class CalendarEventModel {
  String id;
  String name;
  DateTime startDate;
  String creatorEmail;
  String description;
  List<EventAttendee> participants;

  CalendarEventModel({id, name});

  CalendarEventModel.fromApi(Event event) {
    try {
      this.id = event.id;
      this.name = event.summary;
      this.description = mapRolesToString(mapRolesFromString(event.description));
      this.creatorEmail = event.creator.email;
      this.participants = event.attendees;
      this.startDate = event.start.dateTime.add(
        Duration(hours: 2),
      );
    } catch (e) {
      print(e);
    }
  }
}
