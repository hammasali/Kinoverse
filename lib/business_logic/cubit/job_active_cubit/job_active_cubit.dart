import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:kinoverse/backend_service/repo/firebase_repo.dart';
import 'package:meta/meta.dart';

part 'job_active_state.dart';

class JobActiveCubit extends Cubit<JobActiveState> {
  JobActiveCubit() : super(JobActiveInitial());

  void jobActiveBtn(String uid, bool jobActiveStatus) async {
    try {
      print('Call ho rha hai');
      FirebaseRepo.instance.jobActiveStatus(uid, !jobActiveStatus);
    } on PlatformException catch (e) {
      print(e.toString());
    } on FirebaseAuthException catch (e) {
      print(e.toString());
    } on FirebaseException catch (e) {
      print(e.toString());
    }
  }
}
