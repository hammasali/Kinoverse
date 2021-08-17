import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseJob {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  User getCurrentUser() => _firebaseAuth.currentUser;

  Future<void> previewJobPostData(Map<String, dynamic> data) async {
    await _firestore
        .collection('users')
        .doc(getCurrentUser().uid)
        .collection('jobPost')
        .add(data)
        .then((DocumentReference snapshot) => _firestore
            .collection('users')
            .doc(getCurrentUser().uid)
            .collection('jobPost')
            .doc(snapshot.id)
            .update({'uid': snapshot.id}));
  }

  Future<void> jobActiveStatus(String uid, bool status) async {
    print('Yahan b call ho rha hai');
    await _firestore
        .collection('users')
        .doc(getCurrentUser().uid)
        .collection('jobPost')
        .doc(uid)
        .update({'jobActiveStatus': status});
  }
}
