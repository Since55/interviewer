import 'dart:developer';
import 'dart:io';
import 'package:googleapis/calendar/v3.dart';
import 'package:googleapis/sheets/v4.dart';
import 'package:googleapis_auth/auth.dart';
import 'package:googleapis_auth/auth_io.dart';
import 'package:interviewer/constants/google.dart';
import 'package:interviewer/modules/home/models/calendar_event_model.dart';
import 'package:interviewer/utils/helpers/text_helpers.dart';
import 'package:url_launcher/url_launcher.dart';

class GoogleApiService {
  static const scope = const [
    CalendarApi.CalendarReadonlyScope,
    // DocsApi.DocumentsScope,
    SheetsApi.SpreadsheetsScope,
  ];
  AutoRefreshingAuthClient _client;
  String _selectedCalendarId;

  final _credentials = ClientId(
      Platform.isAndroid
          ? GoogleApiConstants.CLIENT_ID_ANDROID
          : GoogleApiConstants.CLIENT_ID_IOS,
      "");

  //TODO: Realize check credentials if user already gave permission

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

  CellData _createDateCell(DateTime date) {
    CellData cell = CellData();
    cell.userEnteredValue = ExtendedValue();
    cell.userEnteredValue.formulaValue =
        '=DATE(${date.year};${date.month};${date.day})';
    return cell;
  }

  CellData _createCell(String text) {
    CellData cell = CellData();
    cell.userEnteredValue = ExtendedValue();
    cell.userEnteredValue.stringValue = text;
    return cell;
  }

  // creates row with with given parameters and inserts current date
  RowData _createRow(List parameters) {
    RowData row = RowData();
    row.values = List<CellData>();
    row.values.add(_createDateCell(DateTime.now()));
    parameters.forEach(
      (element) => row.values.add(
        _createCell(element.toString()),
      ),
    );
    return row;
  }

  // Creates batch request that insert 1 row with data from list (1 cell for 1 list element)
  BatchUpdateSpreadsheetRequest _createBatchRequest(List parameters) {
    Request req = Request();
    req.appendCells = AppendCellsRequest();
    req.appendCells.fields = '*';
    req.appendCells.rows = [_createRow(parameters)];

    BatchUpdateSpreadsheetRequest _request = BatchUpdateSpreadsheetRequest();
    _request.requests = [req];
    return _request;
  }

  Future writeResultToSheets(
      String candidateName, String role, Map rating, String comment) async {
    // check if we have permission to add data to table
    if (_client == null) await getClient();
    SheetsApi _sheetsApi = SheetsApi(_client);
    // getting Interviewer sheet
    Spreadsheet _sheet =
        await _sheetsApi.spreadsheets.get(GoogleApiConstants.SHEET_ID);

    await _sheetsApi.spreadsheets.batchUpdate(
        _createBatchRequest([
          candidateName,
          role,
          comment,
          mapToTable(rating)
        ]),
        _sheet.spreadsheetId);
  }

  // get permission for google api (opens given url in browser);
  void prompt(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}

/*
  //Creates new empty document in google docs with given title
  // Future<Document> _createNewDoc(String title, DocsApi docsApi) async {
  //   Document doc = Document();
  //   doc.title = title;
  //   return await docsApi.documents.create(doc);
  // }

  // BatchUpdateDocumentRequest _createBatchRequest(candidateName, role, Map<String, double> rating) {
  //   Request req = Request();
  //   final text = InsertTextRequest();
  //   text.location = Location();
  //   text.location.index = 1;
  //   text.text = '$candidateName\nposition: $role\nRATING\n${mapToTable(rating)}';
  //   req.insertText = text;
  //   var _requestList = [
  //     req,
  //   ];

  //   BatchUpdateDocumentRequest _request = BatchUpdateDocumentRequest();
  //   _request.requests = _requestList;
  //   return _request;
  // }

  // writeResultsToDocs(String candidateName, String role, Map<String, double> rating,) async {
  //   if (_client == null) await getClient();

  //   var _docsApi = DocsApi(_client);
  //   final _doc = await _createNewDoc(candidateName, _docsApi);

  //   BatchUpdateDocumentRequest _request = _createBatchRequest(candidateName, role, rating);
  //   await _docsApi.documents.batchUpdate(_request, _doc.documentId);
  // }
  */