import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:google_sign_in/google_sign_in.dart';
import 'package:intl/intl.dart';
import 'package:kinoverse/backend_service/models/chat_model.dart';
import 'package:kinoverse/backend_service/models/job_post_model.dart';
import 'package:kinoverse/backend_service/models/user_info.dart';
import 'package:kinoverse/model/hire_talent_fav_model.dart';
import 'package:path_provider/path_provider.dart';

class FirebaseMethod {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  //==============================Authentication State====================

  Future<bool> isSignedIn() async => _firebaseAuth.currentUser != null;

  User getCurrentUser() => _firebaseAuth.currentUser;

  //TODO: Implement Reset Password
  void resetPassword(String email) =>
      _firebaseAuth.sendPasswordResetEmail(email: email);

  //===========================Registration ================================
  Future<User> createUser(String email, String password) async {
    var result = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email, password: password);
    return result.user;
  }

  Future<UserCredential> signInWithGoogle() async {
    GoogleSignIn _googleSignIn = GoogleSignIn();
    GoogleSignInAccount googleSignInAccount = await _googleSignIn.signIn();
    GoogleSignInAuthentication authentication =
        await googleSignInAccount.authentication;

    final AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: authentication.accessToken,
      idToken: authentication.idToken,
    );
    return await _firebaseAuth.signInWithCredential(credential);
  }

  //==========================Sign In========================================
  Future<User> signInUser(String email, String password) async {
    var result = await _firebaseAuth.signInWithEmailAndPassword(
        email: email, password: password);
    return result.user;
  }

  //==========================Sign out=======================================
  Future<void> signOutUser() async {
    await FirebaseAuth.instance.signOut();
  }

  //================Add Authenticated Data To DB=============================

  Future<bool> authenticateUser(User user) async {
    QuerySnapshot result = await _firestore
        .collection('users')
        .where('email', isEqualTo: user.email)
        .get();

    List<DocumentSnapshot> docs = result.docs;

    return docs.length == 0 ? true : false;
  }

  Future<bool> authenticateUniqueUserName(String userName) async {
    final result = await Future.value(_firestore
        .collection('users')
        .where('userName', isEqualTo: userName)
        .get());

    return result.docs.isEmpty ? true : false;
  }

  Future<void> addAuthenticatedDataToDB(UserInfoModel userInfoModel) async {
    _firestore
        .collection('users')
        .doc(getCurrentUser().uid)
        .set(userInfoModel.toMap(userInfoModel));
  }

  //=====================Add User Data In Db=================================

  Future<void> uploadProfileWithMetadata(
      {File file, Map<String, dynamic> hireData}) async {
    // ignore: null_aware_in_condition
    if (hireData != null) {
      await _firestore
          .collection('users')
          .doc(getCurrentUser().uid)
          .update({'companyContacts': hireData});
    }

    // Create your custom metadata.
    firebase_storage.SettableMetadata metadata =
        firebase_storage.SettableMetadata(
      customMetadata: <String, String>{
        'userId': getCurrentUser().uid,
      },
    );

    // ignore: null_aware_in_condition
    if (file == null) {
      var url = getCurrentUser()?.photoURL;

      // await firebase_storage.FirebaseStorage.instance
      //     ?.ref()
      //     ?.child('uploads/${getCurrentUser().uid}')
      //     ?.p(url);

      await _firestore
          .collection('users')
          .doc(getCurrentUser().uid)
          .update({'profilePhoto': url});
    } else {
      // Pass metadata to any file upload method e.g putFile.

      await firebase_storage.FirebaseStorage.instance
          ?.ref()
          ?.child('uploads/${getCurrentUser().uid}')
          ?.putFile(file, metadata);

      await _firestore
          .collection('users')
          .doc(getCurrentUser().uid)
          .update({'profilePhoto': file.toString()});
    }
  }

  Future<void> addNameAndCountryDataInDB(String name, String country) async {
    await _firestore
        .collection('users')
        .doc(getCurrentUser().uid)
        .update({'name': name});
    await _firestore
        .collection('users')
        .doc(getCurrentUser().uid)
        .update({'country': country});
  }

  Future<void> submitWorkerFieldsData(var data) async {
    /// =====     ADD MORE WORKER FIELD DATA BY MANIPULATING QUERY.  ======

    await _firestore
        .collection('workerField')
        .doc(getCurrentUser().uid)
        .set(data);

    await _firestore
        .collection('users')
        .doc(getCurrentUser().uid)
        .get()
        .then((DocumentSnapshot snapshot) async {
      if (snapshot.exists) {
        Map userData = snapshot.data();

        await _firestore
            .collection('workerField')
            .doc(getCurrentUser().uid)
            .update({
          'name': userData['name'],
          'country': userData['country'],
          'profilePhoto': userData['profilePhoto']
        });
      }
    });

    // await _firestore
    //     .collection('users')
    //     .doc(getCurrentUser().uid)
    //     .collection('workerField')
    //     .doc('form')
    //     .set(data);
  }


  /// ===============  Add & Remove HIRE Favourites =============

  Future<void> addHireFavTalentInDB(TalentHireFavModel userData) async {
    await _firestore
        .collection('workerField')
        .doc(getCurrentUser().uid)
        .collection('favourites')
        .doc(userData.uid)
        .set(userData.toMap(userData));

    // await _firestore
    //     .collection('workerField')
    //     .doc(uid)
    //     .update({'favourite': true});
    //
    // await _firestore
    //     .collection('workerField')
    //     .doc(uid)
    //     .get()
    //     .then((DocumentSnapshot value) {
    //   _firestore
    //       .collection('workerField')
    //       .doc(getCurrentUser().uid)
    //       .collection('favourites')
    //       .doc(uid)
    //       .set(value.data());
    // });
  }

  Future<void> removeHireFavTalentInDB(var uid) async {
    await _firestore
        .collection('workerField')
        .doc(getCurrentUser().uid)
        .collection('favourites')
        .doc(uid)
        .delete();
  }


  /// ===============  Add & Remove HIRE Invites =============

  Future<void> addHireTalentInvitesInDB(TalentHireFavModel userData) async {
    await _firestore
        .collection('workerField')
        .doc(getCurrentUser().uid)
        .collection('invites')
        .doc(userData.uid)
        .set(userData.toMap(userData));

    //TODO: REMOVE THIS DUMMY LATER
    await addMessageToDB('This is Invite', userData.uid);
  }

  Future<void> removeHireTalentInvitesInDB(var uid) async {
    await _firestore
        .collection('workerField')
        .doc(getCurrentUser().uid)
        .collection('invites')
        .doc(uid)
        .delete();
  }

  /// ===============  Add & Remove Worker Favourites =========

  Future<void> addWorkerJobFav(JobPostModel userData) async {
    await _firestore
        .collection('users')
        .doc(getCurrentUser().uid)
        .collection('favouriteJob')
        .doc(userData.uid)
        .set(userData.toMap(userData));
  }

  Future<void> removeWorkerJobFav(var uid) async {
    await _firestore
        .collection('users')
        .doc(getCurrentUser().uid)
        .collection('favouriteJob')
        .doc(uid)
        .delete();
  }

  /// ===============  Add & Remove Worker Submits =============
  Future<void> addWorkerJobSubmits(JobPostModel userData) async {
    await _firestore
        .collection('users')
        .doc(getCurrentUser().uid)
        .collection('submitJobs')
        .doc(userData.uid)
        .set(userData.toMap(userData));

    //TODO: REMOVE THIS DUMMY LATER
    await addMessageToDB('This is Invite', userData.uid);
  }

  Future<void> removeWorkerJobSubmits(var uid) async {
    await _firestore
        .collection('users')
        .doc(getCurrentUser().uid)
        .collection('submitJobs')
        .doc(uid)
        .delete();
  }


  /// ============= Message and File Quires =====================
  Future<void> addMessageToDB(
      [String message, String receiverId, bool messageText]) async {
    //TODO: Just a dummy text message remove later
    //TODO: Add the screen to invite button and submit button
    //TODO: and let the user send message

    String _currentUser = getCurrentUser().uid;
    Timestamp _timestamp = Timestamp.now();
    String _time = DateFormat('h:mm a').format(DateTime.now());
    bool _messageText = messageText ?? true;
    DocumentSnapshot result;
    result = await _firestore.collection('users').doc(receiverId).get();

    await _addMessageDataOfCurrentUser(message, _currentUser, receiverId,
            _messageText, _time, _timestamp, result)
        .whenComplete(() => _addMessageDataOfReceiver(message, _currentUser,
            receiverId, _messageText, _time, _timestamp, result));

    ///Adding Messages to db for the current user;
    // ChatModel chatModel1 = ChatModel(
    //     senderId: _currentUser,
    //     receiverId: receiverId,
    //     message: message,
    //     time: _time,
    //     timestamp: _timestamp,
    //     messageText: _messageText);
    //
    // await _firestore
    //     .collection('chats')
    //     .doc(_currentUser)
    //     .collection(receiverId)
    //     .add(chatModel1.toMap(chatModel1))
    //     .whenComplete(() => _firestore
    //         .collection('chats')
    //         .doc(receiverId)
    //         .collection(_currentUser)
    //         .add(chatModel1.toMap(chatModel1)));

    ///Adding user to chat room

    // ChatModel chatModel2 = ChatModel.chatRoom(
    //     senderId: _currentUser,
    //     receiverId: receiverId,
    //     message: message,
    //     timestamp: _timestamp,
    //     time: _time,
    //     name: result.data()['name'],
    //     photo: result.data()['profilePhoto']);
    //
    // await _firestore
    //     .collection('chats')
    //     .doc(_currentUser)
    //     .collection('chatUsers')
    //     .doc(receiverId)
    //     .set(chatModel2.toChatRoomMap(chatModel2))
    //     .whenComplete(() => _firestore
    //         .collection('chats')
    //         .doc(receiverId)
    //         .collection('chatUsers')
    //         .doc(_currentUser)
    //         .set(chatModel2.toChatRoomMap(chatModel2)));
  }

  Future<void> uploadFiles(
      [String fileName,
      String filePath,
      String receiverId,
      bool isCanceled]) async {
    print('fileName: $fileName \n filePath: $filePath');

    firebase_storage.UploadTask task;

    // if (isCanceled != null || isCanceled == true) {
    //   print('CANCELED BUTTON PRESSED? ');
    //
    //   bool canceled = await task.cancel();
    //   print('canceled? $canceled');
    //   return canceled;
    // }
    //
    // print('CANCELED BUTTON NOOOOT PRESSED? ');

    String _currentUser = getCurrentUser().uid;
    Timestamp _timestamp = Timestamp.now();
    String _time = DateFormat('h:mm a').format(DateTime.now());
    DocumentSnapshot result;
    result = await _firestore.collection('users').doc(receiverId).get();
    String _extension = fileName.split('.').last;
    bool fileReceivedStatus = false;

    firebase_storage.SettableMetadata metadata =
        firebase_storage.SettableMetadata(contentType: '$_extension');

//TODO: SEE THE SKYPE CLONE VIDEO AND SEE THE STRUCTURE AND ALSO CLOSE THE provider

    String docRef = await _addMessageDataOfCurrentUser(fileName, _currentUser,
        receiverId, false, _time, _timestamp, result, fileReceivedStatus);

    await firebase_storage.FirebaseStorage.instance
        .ref('chats/${getCurrentUser().uid}')
        .child(fileName)
        .putFile(File(filePath), metadata)
        .whenComplete(() async => await _addMessageDataOfReceiver(
              fileName,
              _currentUser,
              receiverId,
              false,
              _time,
              _timestamp,
              result,
              fileReceivedStatus = true,
              docRef,
            ));
  }

  //TODO: Implement Cancelling Later
  Future<bool> cancelFileUpload(String fileName) async =>
      await firebase_storage.FirebaseStorage.instance
          .ref()
          .child(fileName)
          .putFile(File('...'))
          .cancel();

  Future<void> downloadFile(String message) async {
    final firebase_storage.Reference ref = firebase_storage
        .FirebaseStorage.instance
        .ref('chats/${getCurrentUser().uid}')
        .child(message);

    final String url = await ref.getDownloadURL();

    print('This is url: $url');

    // final http.Response downloadData = await http.get(Uri.parse(url));
    // print('This is Body: ${downloadData.body}');
    final Directory systemTempDir = await getApplicationDocumentsDirectory();
    final File tempFile = File('${systemTempDir.path}/${ref.name}.download');
    if (tempFile.existsSync()) {
      await tempFile.delete();
    }
    await tempFile.create();
    final firebase_storage.DownloadTask task = ref.writeToFile(tempFile);

    final int byteCount = await task.then((TaskSnapshot e) => e.totalBytes);
    //var bodyBytes = downloadData.bodyBytes;
    final String name = ref.name;
    final String path = ref.fullPath;
    print(
      'Success!\nDownloaded $name \nUrl: $url'
      '\npath: $path \nBytes Count :: $byteCount',
    );
  }

  Future<String> _addMessageDataOfCurrentUser(
      String message,
      String currentUser,
      String receiverId,
      bool messageText,
      String time,
      Timestamp timestamp,
      DocumentSnapshot result,
      [bool fileReceivedStatus]) async {
    ChatModel chatModel1;

    chatModel1 = ChatModel(
        senderId: currentUser,
        receiverId: receiverId,
        message: message,
        time: time,
        timestamp: timestamp,
        messageText: messageText,
        fileReceivedStatus: fileReceivedStatus);

    ChatModel chatModel2 = ChatModel.chatRoom(
      senderId: currentUser,
      receiverId: receiverId,
      message: message,
      timestamp: timestamp,
      time: time,
      //TODO: ERROR
      name: result.get('name'),
      photo: result.get('profilePhoto'),
    );

    String docRef;
    await _firestore
        .collection('chats')
        .doc(currentUser)
        .collection(receiverId)
        .add(chatModel1.toMap(chatModel1))
        .then((value) => docRef = value.id)
        .whenComplete(() => _firestore
            .collection('chats')
            .doc(currentUser)
            .collection('chatUsers')
            .doc(receiverId)
            .set(chatModel2.toChatRoomMap(chatModel2)));

    return docRef;
  }

  Future<void> _addMessageDataOfReceiver(
      String message,
      String currentUser,
      String receiverId,
      bool messageText,
      String time,
      Timestamp timestamp,
      DocumentSnapshot result,
      [bool fileReceivedStatus,
      String docRef]) async {
    ChatModel chatModel1 = ChatModel(
        senderId: currentUser,
        receiverId: receiverId,
        message: message,
        time: time,
        timestamp: timestamp,
        messageText: messageText,
        fileReceivedStatus: fileReceivedStatus);

    ChatModel chatModel2 = ChatModel.chatRoom(
      senderId: currentUser,
      receiverId: receiverId,
      message: message,
      timestamp: timestamp,
      time: time,
      //TODO: ERROR
      name: result.get('name'),
      photo: result.get('profilePhoto'),
    );

    await _firestore
        .collection('chats')
        .doc(receiverId)
        .collection(currentUser)
        .add(chatModel1.toMap(chatModel1))
        .whenComplete(() => _firestore
            .collection('chats')
            .doc(receiverId)
            .collection('chatUsers')
            .doc(currentUser)
            .set(chatModel2.toChatRoomMap(chatModel2)))
        .whenComplete(() => _firestore
            .collection('chats')
            .doc(currentUser)
            .collection(receiverId)
            .doc(docRef)
            .update({'fileReceivedStatus': fileReceivedStatus}));
  }
}
