import 'package:get/get.dart';
import 'package:interviewer/modules/home/models/calendar_event_model.dart';
import 'package:interviewer/utils/services/google_api_service.dart';
import 'package:meta/meta.dart';

class HomeController extends GetxController {
  GoogleApiService repository;
  HomeController({@required this.repository}) : assert(repository != null);

  var _eventList = List<CalendarEventModel>().obs;
  set eventList(value) => this._eventList.value = value;
  get eventList => this._eventList.value;
  
  int compareDate(DateTime a, DateTime b) {
    if (a.isAfter(b)) return 1;
    if (b.isAfter(a)) return -1;
    return 0;
  }

  sortEvents() {
    this._eventList.sort((a, b) => compareDate(a.startDate, b.startDate));
  }

  @override
  void onInit() async {
    getEventList();
    super.onInit();
  }

  getEventList() async {
    final List<CalendarEventModel> allEventsList =
        await this.repository.getEvents();
    final DateTime today = DateTime.now();
    final DateTime lastDate = today.add(Duration(days: 7));
    List<CalendarEventModel> weekEvents = [];
    allEventsList.forEach(
      (event) =>
          event.startDate.isAfter(today) && event.startDate.isBefore(lastDate)
              ? weekEvents.add(event)
              : null,
    );
    this.eventList = weekEvents;
    sortEvents();
  }
}
