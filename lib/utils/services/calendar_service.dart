import 'dart:developer';

import 'package:googleapis/calendar/v3.dart';
import 'package:googleapis_auth/auth.dart';
import 'package:googleapis_auth/auth_io.dart';
import 'package:interviewer/constants/google.dart';
import 'package:interviewer/modules/home/models/calendar_event_model.dart';
import 'package:url_launcher/url_launcher.dart';

class CalendarService {
  static const scope = const [CalendarApi.CalendarReadonlyScope];
  AuthClient _client;
  String _selectedCalendarId;
  final _credentials = ClientId(
      GoogleApiConstants.CLIENT_ID,
      "");
      
  getClient() async {
    this._client = await clientViaUserConsent(_credentials, scope, prompt);
  }

  getEvents() async {
    try {
      if (_client == null) {
        await getClient();
      }
      var calendar = CalendarApi(_client);
      String calendarId = "primary";
      CalendarListEntry selectedCalendar =
          await calendar.calendarList.get(calendarId);
      this._selectedCalendarId = selectedCalendar.id;
      final events = await calendar.events.list(calendarId);
      // events.items.forEach((Event event) => print(
      // 'Created: ${event.created}, creator: ${event.creator.email}, status: ${event.status}, DESC: ${event.description}, name: ${event.summary}, org: ${event.organizer}, time: ${event.originalStartTime.dateTime} "" ${event.originalStartTime.date}'));
      return events.items
          .map((event) => CalendarEventModel.fromApi(event))
          .toList();
    } catch (e) {
      log('Error creating event $e');
      return [];
    }
  }

  void prompt(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
