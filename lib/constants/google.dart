import 'package:googleapis/calendar/v3.dart';
import 'package:googleapis/sheets/v4.dart';
import 'package:interviewer/modules/home/models/calendar_event_model.dart';

abstract class GoogleApiConstants {
  static const CLIENT_ID_ANDROID =
      "487567944310-ii76hmqji3tm60pdb4ak6d32ng79m3fc.apps.googleusercontent.com"; // Android Client id taken from google cloud console
  static const CLIENT_SECRET_ANDROID = "6iRUl-xZXS-d1mBdXHeB5IWw";
  static const CLIENT_ID_IOS =
      "487567944310-bfaurqnrmo31r1oetog6jovg0r45tr6k.apps.googleusercontent.com"; // iOS Client id taken from google cloud console
  static const SHEET_ID = "19WJztt_8lfgGWMXCizxAk0kUyGKElAx3ovnbXXP7gW4";

  static const API_SCOPES = const [
    CalendarApi.CalendarReadonlyScope,
    // DocsApi.DocumentsScope,
    SheetsApi.SpreadsheetsScope,
  ];
  static const DOCUMENT_LINK = 'https://docs.google.com/spreadsheets/u/2/d/19WJztt_8lfgGWMXCizxAk0kUyGKElAx3ovnbXXP7gW4/edit#gid=0';
}
