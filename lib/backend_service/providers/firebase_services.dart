import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class FirebaseServices {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  User getCurrentUser() => _firebaseAuth.currentUser;

  Future<DocumentSnapshot> fetchWorkerDataFromDb() async {
    var user =
        await _firestore.collection('users').doc(getCurrentUser().uid).get();

    return user;
    // var data = UserInfoModel.fromMap(user.data());
    //
    // return data;
  }

  Future<String> downloadURL() async {
    var downloadURL = await firebase_storage.FirebaseStorage.instance
        ?.ref()
        ?.child('uploads/${getCurrentUser().uid}')
        ?.getDownloadURL()
        ?.catchError((onError) {
      print(onError);
    });

    return downloadURL;
  }

  Future<String> downloadAllUserURLs(String uid) async {
    var downloadURL = await firebase_storage.FirebaseStorage.instance
        ?.ref()
        ?.child('uploads/$uid')
        ?.getDownloadURL()
        ?.catchError((onError) {
      print('On FirebaseStorage Exception $onError');
    });

    return downloadURL;
  }

  //=======================HIRE PANEL QUERIES===================================
  Query fetchWorkerFormFieldsData() {
    var data = _firestore
        .collection('workerField')
        //   .where('uid', isNotEqualTo: getCurrentUser().uid)
        .orderBy('orderBy', descending: true);
    return data;
  }

  Query fetchFavUsers() {
    var data = _firestore
        .collection('workerField')
        .doc(getCurrentUser().uid)
        .collection('favourites')
        //   .where('uid', isNotEqualTo: getCurrentUser().uid)
        .orderBy('orderBy', descending: true);

    return data;
  }

  Query fetchInvitedUsers() {
    var data = _firestore
        .collection('workerField')
        .doc(getCurrentUser().uid)
        .collection('invites')
        //.where('uid', isNotEqualTo: getCurrentUser().uid)
        .orderBy('orderBy', descending: true);

    return data;
  }

  Query fetchSearchData(String text) {
    var data = _firestore
        .collection('workerField')
        .where('skills', arrayContains: text);

    return data;
  }

  Query fetchHireTabSearchData(String text) {
    var data = _firestore
        .collection('workerField')
        .doc(getCurrentUser().uid)
        .collection('invites')
        .where('skills', arrayContains: text);

    return data;
  }

  Query fetchFavTabSearchData(String text) {
    var data = _firestore
        .collection('workerField')
        .doc(getCurrentUser().uid)
        .collection('favourites')
        .where('skills', arrayContains: text);

    return data;
  }

  Future<DocumentSnapshot> fetchWorkerUserData(var uid) async {
    var docs = await _firestore.collection('users').doc(uid).get();
    return docs;
  }

  Future<bool> fetchCurrentUserInvited(var uid) async => await _firestore
          .collection('workerField')
          .doc(getCurrentUser().uid)
          .collection('invites')
          .doc(uid)
          .get()
          .then((DocumentSnapshot documentSnapshot) {
        if (documentSnapshot.exists) return true;

        return false;
      });

  Future<bool> fetchCurrentUserFavourites(var uid) async => await _firestore
          .collection('workerField')
          .doc(getCurrentUser().uid)
          .collection('favourites')
          .doc(uid)
          .get()
          .then((DocumentSnapshot documentSnapshot) {
        if (documentSnapshot.exists) return true;
        return false;
      });

  Future<bool> fetchCurrentUserJobPostFavourites(var uid) async =>
      await _firestore
          .collection('users')
          .doc(getCurrentUser().uid)
          .collection('favouriteJob')
          .doc(uid)
          .get()
          .then((DocumentSnapshot documentSnapshot) {
        if (documentSnapshot.exists) return true;
        return false;
      });

  Future<bool> fetchCurrentUserJobPostSubmits(var uid) async =>
      await _firestore
          .collection('users')
          .doc(getCurrentUser().uid)
          .collection('submitJobs')
          .doc(uid)
          .get()
          .then((DocumentSnapshot documentSnapshot) {
        if (documentSnapshot.exists) return true;
        return false;
      });

  Query fetchCurrentUserJobPost() => _firestore
      .collection('users')
      .doc(getCurrentUser().uid)
      .collection('jobPost')
      .orderBy('postTime', descending: true);

  Query fetchCurrentUserContracts() => _firestore
      .collection('users')
      .doc(getCurrentUser().uid)
      .collection('contracts')
      .orderBy('postTime', descending: true);

  Future<int> fetchCurrentUserJobPostLength() async {
    QuerySnapshot _myDoc = await _firestore
        .collection('users')
        .doc(getCurrentUser().uid)
        .collection('jobPost')
        .get();
    List<DocumentSnapshot> _myDocCount = _myDoc.docs;
    return _myDocCount.length;
  }

  Future<int> fetchCurrentUserContractsLength() async {
    QuerySnapshot _myDoc = await _firestore
        .collection('users')
        .doc(getCurrentUser().uid)
        .collection('contracts')
        .get();
    List<DocumentSnapshot> _myDocCount = _myDoc.docs;
    return _myDocCount.length;
  }

  //==============================WORKER PANEL QUERIES==========================

  //TODO: Remove Bugs After Dinner
  Query fetchJobPostsOfHirePanel() {
    var data = _firestore.collectionGroup('jobPost');
    // .where('uid', isNotEqualTo: getCurrentUser().uid);
    return data;
  }

  Query fetchFavJobs() {
    var data = _firestore
        .collection('users')
        .doc(getCurrentUser().uid)
        .collection('favouriteJob');
    //   .where('uid', isNotEqualTo: getCurrentUser().uid)
    // .orderBy('orderBy', descending: true);

    return data;
  }

  Query fetchSubmitJobs() {
    var data = _firestore
        .collection('users')
        .doc(getCurrentUser().uid)
        .collection('submitJobs');
    //   .where('uid', isNotEqualTo: getCurrentUser().uid)
    // .orderBy('orderBy', descending: true);

    return data;
  }

  //======================MESSAGES QUIRES====================================
  Query fetchUserChatRoom() => _firestore
      .collection('chats')
      .doc(getCurrentUser().uid)
      .collection('chatUsers')
      .orderBy('timestamp', descending: true);

  DocumentReference fetchUserChatRoomData(String uid) =>
      _firestore.collection('users').doc(uid);

  Query fetchUserChat(String uid) => _firestore
      .collection('chats')
      .doc(getCurrentUser().uid)
      .collection(uid)
      .orderBy('timestamp');
}
