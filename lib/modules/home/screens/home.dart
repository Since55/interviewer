import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:interviewer/constants/google.dart';
import 'package:interviewer/core/auth/controllers/auth_controller.dart';
import 'package:interviewer/modules/home/controller/home_controller.dart';
import 'package:interviewer/modules/login/controllers/login_controller.dart';
import 'package:interviewer/utils/services/google_api_service.dart';
import 'package:interviewer/widgets/empty_page.dart';
import 'package:interviewer/widgets/event_card.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeScreen extends GetView<HomeController> {
  HomeScreen();

  final AuthController _authController = Get.find();
  final LoginController _loginController = Get.find();

  @override
  Widget build(BuildContext context) {
    Get.put(
      HomeController(
        repository: GoogleApiService(),
      ),
    );
    return Scaffold(
      drawer: Drawer(
        child: Column(
          // padding: EdgeInsets.all(0),
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.purple,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    child: Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          fit: BoxFit.fill,
                          image: NetworkImage('https://picsum.photos/seed/picsum/200/300'),
                        ),
                      ),
                    ),
                  ),
                  ListTile(
                    contentPadding: EdgeInsets.all(0),
                    title: Text(
                      'Sign out',
                      style: TextStyle(color: Colors.grey[200]),
                    ),
                    onTap: () {
                      controller.clearEvents();
                      _loginController.signOut();
                    },
                  )
                ],
              ),
            ),
            Obx(
              () => controller.calendarList.length < 1
                  ? Column(children: [
                      Text('No calendars'),
                      FlatButton(
                        child: Text('Refresh'),
                        onPressed: () => controller.getCalendarList(),
                      )
                    ])
                  : Expanded(
                      child: RefreshIndicator(
                        onRefresh: () async =>
                            await controller.getCalendarList(),
                        child: ListView.builder(
                          itemCount: controller.calendarList.length,
                          itemBuilder: (context, index) => ListTile(
                            onTap: () => controller.selectedCalendar =
                                controller.calendarList[index],
                            title: Text(controller.calendarList[index].summary),
                          ),
                        ),
                      ),
                    ),
            )
          ],
        ),
      ),
      appBar: AppBar(
        title: Text('Interviewer'),
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 40.0),
            child: Column(
              children: [
                Obx(
                  () => controller.filteredEventList.length < 1 &&
                              !controller.showOther ||
                          controller.eventList.length < 1
                      ? Column(
                          children: [
                            EmptyPage(text: 'No events'),
                            FlatButton(
                              onPressed: () => controller.getEventList(),
                              child: Text('Refresh'),
                            ),
                          ],
                        )
                      : Expanded(
                          child: RefreshIndicator(
                            onRefresh: () => controller.getEventList(),
                            child: ListView.builder(
                              itemCount: controller.showOther
                                  ? controller.eventList.length
                                  : controller.filteredEventList.length,
                              itemBuilder: (context, index) => EventCard(
                                event: controller.showOther
                                    ? controller.eventList[index]
                                    : controller.filteredEventList[index],
                              ),
                            ),
                          ),
                        ),
                ),
              ],
            ),
          ),
          SafeArea(
            child: Align(
              alignment: Alignment.bottomRight,
              child: Container(
                margin: EdgeInsets.only(bottom: 15),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(50),
                    topLeft: Radius.circular(50),
                  ),
                  color: Colors.grey[200],
                ),
                height: 50,
                child: IconButton(
                  icon: Icon(Icons.insert_chart),
                  onPressed: () async {
                    await launch(GoogleApiConstants.DOCUMENT_LINK);
                  },
                ),
              ),
            ),
          ),
          Obx(
            () => Container(
              padding: EdgeInsets.only(
                left: 8,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Show other events: '),
                  Switch(
                    value: controller.showOther,
                    onChanged: (value) {
                      controller.showOther = value;
                    },
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
