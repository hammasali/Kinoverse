import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:kinoverse/backend_service/repo/firebase_repo.dart';
import 'package:meta/meta.dart';

part 'fields_photo_state.dart';

class FieldsPhotoCubit extends Cubit<FieldsPhotoState> {
  FieldsPhotoCubit() : super(FieldsPhotoInitial());

  void NextButtonEventScreen11(File file) async {
    try {
      emit(FieldsPhotoLoading());
      await FirebaseRepo.instance
          .uploadProfileWithMetadata(filePath: file)
          .whenComplete(() => emit(FieldsPhotoSuccessfulState()));
    } on PlatformException catch (e) {
      print(e.toString());
      emit(FieldsPhotoUnsuccessfulState(message: e.message));
    } on FirebaseAuthException catch (e) {
      emit(FieldsPhotoUnsuccessfulState(message: e.message));
    }
  }
}
