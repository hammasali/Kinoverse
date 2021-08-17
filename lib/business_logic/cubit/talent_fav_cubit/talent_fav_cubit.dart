import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:kinoverse/backend_service/models/job_post_model.dart';
import 'package:kinoverse/backend_service/repo/firebase_repo.dart';
import 'package:kinoverse/model/hire_talent_fav_model.dart';

import 'package:meta/meta.dart';

part 'talent_fav_state.dart';

class TalentFavCubit extends Cubit<TalentFavState> {
  TalentFavCubit() : super(TalentFavInitial());

  //====================== ADD AND REMOVE TALENT FAVOURITE HIRE PANEL===========
  void addTalentFav(TalentHireFavModel talentHireFavModel) async {
    try {
      await FirebaseRepo.instance
          .addHireFavTalentInDB(talentHireFavModel)
          .whenComplete(() => emit(TalentFavSuccessfulState()));
    } on FirebaseException catch (e) {
      emit(TalentFavUnSuccessfulState(message: e.message));
    }
  }

  void removeTalentFav(var uid) async {
    try {
      await FirebaseRepo.instance
          .removeHireFavTalentInDB(uid)
          .whenComplete(() => emit(TalentFavSuccessfulState()));
    } on FirebaseException catch (e) {
      emit(TalentFavUnSuccessfulState(message: e.message));
    }
  }
  //====================== ADD AND REMOVE TALENT INVITE HIRE PANEL==============
  void addTalentInvite(TalentHireFavModel talentHireFavModel) async {
    try {
      await FirebaseRepo.instance
          .addHireTalentInvitesInDB(talentHireFavModel)
          .whenComplete(() => emit(TalentFavSuccessfulState()));
    } on FirebaseException catch (e) {
      emit(TalentFavUnSuccessfulState(message: e.message));
    }
  }
  void removeTalentInvite(var uid) async {
    try {
      await FirebaseRepo.instance
          .removeHireTalentInvitesInDB(uid)
          .whenComplete(() => emit(TalentFavSuccessfulState()));
    } on FirebaseException catch (e) {
      emit(TalentFavUnSuccessfulState(message: e.message));
    }
  }

  //====================== ADD AND REMOVE FAVOURITES WORKER PANEL===============

  void addWorkerJobFav(JobPostModel jobPostModel) async {
    try {
      await FirebaseRepo.instance
          .addWorkerJobFav(jobPostModel)
          .whenComplete(() => emit(TalentFavSuccessfulState()));
    } on FirebaseException catch (e) {
      emit(TalentFavUnSuccessfulState(message: e.message));
    }
  }

  void removeWorkerJobFav(var uid) async {
    try {
      await FirebaseRepo.instance
          .removeWorkerJobFav(uid)
          .whenComplete(() => emit(TalentFavSuccessfulState()));
    } on FirebaseException catch (e) {
      emit(TalentFavUnSuccessfulState(message: e.message));
    }
  }

  //====================== ADD AND REMOVE SUBMIT WORKER PANEL===============

  void addWorkerJobSubmits(JobPostModel jobPostModel) async {
    try {
      await FirebaseRepo.instance
          .addWorkerJobSubmits(jobPostModel)
          .whenComplete(() => emit(TalentFavSuccessfulState()));
    } on FirebaseException catch (e) {
      emit(TalentFavUnSuccessfulState(message: e.message));
    }
  }

  void removeWorkerJobSubmits(var uid) async {
    try {
      await FirebaseRepo.instance
          .removeWorkerJobSubmits(uid)
          .whenComplete(() => emit(TalentFavSuccessfulState()));
    } on FirebaseException catch (e) {
      emit(TalentFavUnSuccessfulState(message: e.message));
    }
  }
}
