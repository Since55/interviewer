import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:interviewer/modules/home/controller/home_controller.dart';
import 'package:interviewer/utils/services/firebase_service.dart';
import 'package:interviewer/widgets/snackbar.dart';

class CandidateController extends GetxController {
  final String role;
  final String candidateName;
  final FirebaseService _firestore = FirebaseService();
  HomeController home = Get.find();
  TextEditingController commentController = TextEditingController();
  CandidateController({
    this.role,
    this.candidateName,
  });

  @override
  void onInit() {
    _competenciesList.bindStream(_firestore.competenciesStream(role));
    super.onInit();
  }

  var _isBusy = false.obs;
  set isBusy(value) => this._isBusy.value = value;
  get isBusy => this._isBusy.value;

  final _competenciesList = Rx();
  set competenciesList(value) => this._competenciesList.value = value;
  get competenciesList => this._competenciesList.value;

  Map<String, double> rating = {};

  Future<void> sendRating() async {
    isBusy = true;
    try {
      print('sending data to firestore...');
      await _firestore.sendInterviewRating(
        candidateName: candidateName,
        role: role,
        rating: rating,
        comment: commentController.text,
      );
      print('creating document...');
      await this.home.repository.writeResultToSheets(
          candidateName, role, rating, commentController.text);
      print('successfuly rated!');
      Get.back();
      showSnackbar(
        '$candidateName was rated successfuly',
        '',
      );
    } catch (e) {
      print(e);
      isBusy = false;
      showSnackbar(
        'Error',
        e.message,
        icon: Icon(Icons.error),
      );
    }
    isBusy = false;
  }
}
