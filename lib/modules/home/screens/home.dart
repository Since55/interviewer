import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:interviewer/core/auth/controllers/auth_controller.dart';
import 'package:interviewer/modules/home/controller/home_controller.dart';
import 'package:interviewer/utils/services/calendar_service.dart';
import 'package:interviewer/widgets/empty_page.dart';
import 'package:interviewer/widgets/event_card.dart';

class HomeScreen extends GetView<HomeController> {
  HomeScreen();

  final AuthController _authController = Get.find();

  @override
  Widget build(BuildContext context) {
    Get.put(
      HomeController(
        repository: CalendarService(),
      ),
    );
    return Scaffold(
      appBar: AppBar(
        title: Text('Interviewer'),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () {
              _authController.isSignedIn = false.obs();
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Obx(
            () => controller.eventList.length < 1
                ? EmptyPage(text: 'No events')
                : Expanded(
                    child: RefreshIndicator(
                      onRefresh: () => controller.getEventList(),
                      child: ListView.builder(
                        itemCount: controller.eventList.length,
                        itemBuilder: (context, index) =>
                            EventCard(event: controller.eventList[index]),
                      ),
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}