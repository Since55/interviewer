import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';

class FirebaseService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Stream competenciesStream(role) {
    return _firestore
        .collection("competencies")
        .snapshots()
        .map((QuerySnapshot query) {
      return query.docs.first[role];
    });
  }

  Future<void> sendInterviewRating({
    @required String candidateName,
    @required String role,
    @required Map<String, double> rating,
    String comment = '',
  }) async {
    await _firestore
        .collection("candidates")
        .doc('results')
        .collection(candidateName)
        .add(
      {
        'name': candidateName,
        'role': role,
        'rating': rating,
        'comment': comment,
      },
    );
  }
}
