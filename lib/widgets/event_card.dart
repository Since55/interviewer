import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:interviewer/modules/candidate/screens/candidate_screen.dart';
import 'package:interviewer/modules/home/models/calendar_event_model.dart';
import 'package:interviewer/utils/helpers/text_helpers.dart';

class EventCard extends StatelessWidget {
  final CalendarEventModel event;
  const EventCard({Key key, this.event}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: () {
          Get.to(CandidateScreen(this.event));
        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                this.event.name,
                style: Theme.of(context).textTheme.headline6,
              ),
              Text(
                "position: ${this.event.description.capitalizeFirst ?? 'unknown'}",
              ),
              Text('Date: ${dateTimeToddMMyy(event.startDate)}'),
              Text('Time: ${dateTimeToHoursMinutes(event.startDate)}'),
            ],
          ),
        ),
      ),
    );
  }
}
