import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:interviewer/utils/services/firebase_service.dart';
import 'package:interviewer/widgets/snackbar.dart';

class CandidateController extends GetxController {
  final String role;
  final String candidateName;
  final FirebaseService _firestore = FirebaseService();
  CandidateController({
    this.role,
    this.candidateName,
  });

  @override
  void onInit() {
    _competenciesList.bindStream(_firestore.competenciesStream(role));
    super.onInit();
  }

  final _competenciesList = Rx();
  set competenciesList(value) => this._competenciesList.value = value;
  get competenciesList => this._competenciesList.value;

  Map<String, double> rating = {};

  Future<void> sendRating() async {
    try {
      await _firestore.sendInterviewRating(
        candidateName: candidateName,
        role: role,
        rating: rating,
      );
      Get.back();
      showSnackbar(
        '$candidateName was rated successfuly',
        '',
      );
    } catch (e) {
      showSnackbar(
        'Error',
        e.message,
        icon: Icon(Icons.error),
      );
    }
  }
}
