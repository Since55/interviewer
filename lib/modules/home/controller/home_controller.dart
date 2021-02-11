import 'package:get/get.dart';
import 'package:googleapis/calendar/v3.dart';
import 'package:interviewer/modules/home/models/calendar_event_model.dart';
import 'package:interviewer/utils/services/google_api_service.dart';
import 'package:meta/meta.dart';

class HomeController extends GetxController {
  GoogleApiService repository;
  HomeController({@required this.repository}) : assert(repository != null);

  CalendarListEntry _selectedCalendar;
  set selectedCalendar(value) {
    _selectedCalendar = value;
    getEventList();
  }

  var _calendarList = List<CalendarListEntry>().obs;
  set calendarList(value) => this._calendarList.value = value;
  List<CalendarListEntry> get calendarList => this._calendarList.value;

  var _eventList = List<CalendarEventModel>().obs;
  set eventList(value) => this._eventList.value = value;
  get eventList => this._eventList.value;

  // List without 'other' role;
  var _filteredEventList = List<CalendarEventModel>().obs;
  get filteredEventList => this._filteredEventList.value;

  // Should show events with description 'other' or not
  RxBool _showOther = false.obs;
  set showOther(value) => this._showOther.value = value;
  get showOther => this._showOther.value;

  void sortEvents() {
    this._eventList.sort((a, b) => a.startDate.compareTo(b.startDate));
  }

  void filterEventList() {
    final temp = <CalendarEventModel>[...eventList];
    _filteredEventList
        .assignAll(temp.where((element) => element.description != 'other'));
  }

  @override
  void onInit() async {
    await getEventList();
    await getCalendarList();
    super.onInit();
  }

  void clearEvents() {
    repository.clearClient();
    this.eventList = <CalendarEventModel>[];
  }

  Future<void> getCalendarList() async {
    final calendars = await repository.getCalendarList();
    if (calendars != null) {
      this.calendarList = [...calendars];
    }
  }

  Future<void> getEventList() async {
    final List<CalendarEventModel> allEventsList =
        await this.repository.getEvents(calendarId: _selectedCalendar?.id ?? 'primary');
    final DateTime today = DateTime.now();
    final DateTime lastDate = today.add(Duration(days: 8));
    List<CalendarEventModel> weekEvents = [];
    allEventsList.forEach(
      (event) =>
          event.startDate.isAfter(today) && event.startDate.isBefore(lastDate)
              ? weekEvents.add(event)
              : null,
    );
    this.eventList = weekEvents;
    sortEvents();
    filterEventList();
  }
}
