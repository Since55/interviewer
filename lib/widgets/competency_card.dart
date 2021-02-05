import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:interviewer/modules/candidate/controller/candidate_controller.dart';

class CompetencyCard extends StatelessWidget {
  final String competency;
  const CompetencyCard(
    this.competency, {
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    CandidateController _controller = Get.find();
    _controller.rating[competency] = 0.0;
    return Card(
      child: Padding(
        padding: EdgeInsets.all(5.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(competency),
            RatingBar.builder(
              glow: false,
              initialRating: 0,
              minRating: 0,
              direction: Axis.horizontal,
              allowHalfRating: true,
              itemCount: 3,
              itemBuilder: (context, _) => Icon(
                Icons.star,
                color: Colors.amber,
              ),
              onRatingUpdate: (rating) {
                _controller.rating[competency] = rating;
              },
            ),
          ],
        ),
      ),
    );
  }
}