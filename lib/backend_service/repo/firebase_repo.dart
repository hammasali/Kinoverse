import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:kinoverse/backend_service/models/job_post_model.dart';
import 'package:kinoverse/backend_service/models/user_info.dart';
import 'package:kinoverse/backend_service/providers/firebase_job.dart';
import 'package:kinoverse/backend_service/providers/firebase_method.dart';
import 'package:kinoverse/backend_service/providers/firebase_services.dart';

class FirebaseRepo {
  static final FirebaseRepo instance = FirebaseRepo._instance();

  FirebaseRepo._instance();

  FirebaseMethod _firebaseMethod = FirebaseMethod();
  FirebaseServices _firebaseServices = FirebaseServices();
  FirebaseJob _firebaseJob = FirebaseJob();

  Future<bool> authSignIn() async => await _firebaseMethod.isSignedIn();

  void resetPassword(String email) => _firebaseMethod.resetPassword(email);

  User getCurrentUser() => _firebaseMethod.getCurrentUser();

  Future<User> createUser(String email, String password) async =>
      await _firebaseMethod.createUser(email, password);

  Future<UserCredential> signInWithGoogle() async =>
      await _firebaseMethod.signInWithGoogle();

  Future<User> signInUser(String email, String password) async =>
      await _firebaseMethod.signInUser(email, password);

  Future<void> signOutUser() async => await _firebaseMethod.signOutUser();

  Future<bool> authenticateUser(User user) async =>
      await _firebaseMethod.authenticateUser(user);

  Future<bool> authenticateUniqueUserName(String userName) async =>
      await _firebaseMethod.authenticateUniqueUserName(userName);

  Future<void> addAuthenticatedDataToDB({UserInfoModel userInfoModel}) async =>
      await _firebaseMethod.addAuthenticatedDataToDB(userInfoModel);

  Future<void> uploadProfileWithMetadata(
          {File filePath, Map<String, dynamic> hireData}) async =>
      await _firebaseMethod.uploadProfileWithMetadata(
          file: filePath, hireData: hireData);

  Future<DocumentSnapshot> fetchWorkerDataFromDb() async =>
      await _firebaseServices.fetchWorkerDataFromDb();

  Future<String> downloadURL() async => await _firebaseServices.downloadURL();

  Future<String> downloadAllUserURLs(String uid) async =>
      _firebaseServices.downloadAllUserURLs(uid);

  Future<void> addNameAndCountryDataInDB(String name, String country) async =>
      _firebaseMethod.addNameAndCountryDataInDB(name, country);

  Future<void> submitWorkerFieldsData(var data) async =>
      await _firebaseMethod.submitWorkerFieldsData(data);

  Future<void> previewJobPostData(Map<String, dynamic> data) async =>
      await _firebaseJob.previewJobPostData(data);

  Future<void> jobActiveStatus(String uid, bool status) async =>
      await _firebaseJob.jobActiveStatus(uid, status);

  Query fetchWorkerFormFieldsData() =>
      _firebaseServices.fetchWorkerFormFieldsData();

  ///   ==== Search queries ===== ( 74 - 80 )
  Query fetchSearchData(String text) => _firebaseServices.fetchSearchData(text);

  Query fetchHireTabSearchData(String text) =>
      _firebaseServices.fetchHireTabSearchData(text);

  Query fetchFavTabSearchData(String text) =>
      _firebaseServices.fetchFavTabSearchData(text);

  Query fetchFavUsers() => _firebaseServices.fetchFavUsers();

  Query fetchFavJobs() => _firebaseServices.fetchFavJobs();

  Query fetchSubmitJobs() => _firebaseServices.fetchSubmitJobs();

  Query fetchInvitedUsers() => _firebaseServices.fetchInvitedUsers();

  Query fetchCurrentUserJobPost() =>
      _firebaseServices.fetchCurrentUserJobPost();

  Query fetchCurrentUserContracts() =>
      _firebaseServices.fetchCurrentUserContracts();

  Query fetchJobPostsOfHirePanel() =>
      _firebaseServices.fetchJobPostsOfHirePanel();

  Future<int> fetchCurrentUserJobPostLength() async =>
      await _firebaseServices.fetchCurrentUserJobPostLength();

  Future<int> fetchCurrentUserContractsLength() async =>
      await _firebaseServices.fetchCurrentUserContractsLength();

  Future<DocumentSnapshot> fetchWorkerUserData(var uid) async =>
      await _firebaseServices.fetchWorkerUserData(uid);

  Future<void> addHireFavTalentInDB(var userData) async =>
      await _firebaseMethod.addHireFavTalentInDB(userData);

  Future<void> removeHireFavTalentInDB(var uid) async =>
      await _firebaseMethod.removeHireFavTalentInDB(uid);

  Future<void> addHireTalentInvitesInDB(var userData) async =>
      await _firebaseMethod.addHireTalentInvitesInDB(userData);

  Future<void> removeHireTalentInvitesInDB(var uid) async =>
      await _firebaseMethod.removeHireTalentInvitesInDB(uid);

  Future<void> addWorkerJobFav(var userData) async =>
      await _firebaseMethod.addWorkerJobFav(userData);

  Future<void> removeWorkerJobFav(var uid) async =>
      await _firebaseMethod.removeWorkerJobFav(uid);

  Future<void> addWorkerJobSubmits(JobPostModel userData) async =>
      await _firebaseMethod.addWorkerJobSubmits(userData);

  Future<void> removeWorkerJobSubmits(var uid) async =>
      await _firebaseMethod.removeWorkerJobSubmits(uid);

  Future<bool> fetchCurrentUserFavourites(var uid) async =>
      await _firebaseServices.fetchCurrentUserFavourites(uid);

  Future<bool> fetchCurrentUserInvited(var uid) async =>
      await _firebaseServices.fetchCurrentUserInvited(uid);

  Future<bool> fetchCurrentUserJobPostFavourites(var uid) async =>
      await _firebaseServices.fetchCurrentUserJobPostFavourites(uid);

  Future<bool> fetchCurrentUserJobPostSubmits(var uid) async =>
      await _firebaseServices.fetchCurrentUserJobPostSubmits(uid);

  //==========================MESSAGES QUIRES==================================
  Query fetchUserChatRoom() => _firebaseServices.fetchUserChatRoom();

  DocumentReference fetchUserChatRoomData(String uid) =>
      _firebaseServices.fetchUserChatRoomData(uid);

  Query fetchUserChat(String uid) => _firebaseServices.fetchUserChat(uid);

  Future<void> addMessageToDB(String message, String receiverId) async =>
      await _firebaseMethod.addMessageToDB(message, receiverId);

  Future<void> uploadFiles(
          {String fileName,
          String filePath,
          String uid,
          bool canceled}) async =>
      await _firebaseMethod.uploadFiles(fileName, filePath, uid, canceled);

  Future<bool> cancelFileUpload(String fileName) async =>
      await _firebaseMethod.cancelFileUpload(fileName);

  Future<void> downloadFile(String message) async =>
      await _firebaseMethod.downloadFile(message);
}
