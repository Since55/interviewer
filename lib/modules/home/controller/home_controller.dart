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
  
  @override
  void onInit() async {
    getEventList();
    super.onInit();
  }

  getEventList() async {
    final List<CalendarEventModel> allEventsList = await this.repository.getEvents();
    final DateTime today = DateTime.now();
    List<CalendarEventModel> todayEvents = [];
    allEventsList.forEach( (event) => event.startDate?.day == today.day &&
          event.startDate?.year == today.year ?
          todayEvents.add(event) : null,);
    this.eventList = todayEvents;
  }
}