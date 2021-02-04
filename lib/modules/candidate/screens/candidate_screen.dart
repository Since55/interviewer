import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:interviewer/constants/roles.dart';
import 'package:interviewer/modules/candidate/controller/candidate_controller.dart';
import 'package:interviewer/modules/home/models/calendar_event_model.dart';
import 'package:interviewer/widgets/competency_card.dart';
import 'package:interviewer/widgets/empty_page.dart';

class CandidateScreen extends GetView<CandidateController> {
  final CalendarEventModel event;
  FocusNode commentFocus = FocusNode();
  String role;
  CandidateScreen(this.event) {
    this.role = mapRolesToString(
        mapRolesFromString(this.event.description.toLowerCase()));
  }
  @override
  Widget build(BuildContext context) {
    Get.put(CandidateController(
      candidateName: event.name,
      role: role,
    ));
    return Obx(
      () => Scaffold(
        appBar: AppBar(
          title: Text(
            this.event.name,
          ),
        ),
        body: controller.competenciesList == null
            ? EmptyPage(text: 'Loading')
            : Column(
                children: [
                  // TODO: hide keyboard
                  TextField(
                    maxLines: 2,
                    controller: controller.commentController,
                    focusNode: commentFocus,
                    decoration: InputDecoration(
                      hintText: 'Comment',
                      suffixIcon: IconButton(
                        onPressed: () => controller.commentController.clear(),
                        icon: Icon(Icons.close),
                      ),
                    ),
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () => commentFocus.unfocus(),
                      child: ListView.builder(
                        itemCount: controller.competenciesList.length,
                        itemBuilder: (context, index) =>
                            CompetencyCard(controller.competenciesList[index]),
                      ),
                    ),
                  ),
                ],
              ),
        floatingActionButton: FloatingActionButton(
          child: controller.isBusy
              ? CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation(Colors.white),
                )
              : Padding(
                  padding: const EdgeInsets.only(left: 3.0),
                  child: Icon(Icons.send),
                ),
          onPressed: controller.isBusy
              ? () {}
              : () {
                  controller.sendRating();
                },
        ),
      ),
    );
  }
}
