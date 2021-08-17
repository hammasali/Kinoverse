import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:file_picker/file_picker.dart';
import 'package:kinoverse/backend_service/repo/firebase_repo.dart';
import 'package:meta/meta.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:http/http.dart' as http;

part 'chat_event.dart';

part 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  ChatBloc() : super(ChatInitialState());

  @override
  Stream<ChatState> mapEventToState(
    ChatEvent event,
  ) async* {
    try {
      if (event is SelectFileEvent) {
        FilePickerResult result =
            await FilePicker.platform.pickFiles(allowMultiple: true);

        if (result == null) return;

        yield ChatLoadingState();
        result.files.map((e) async {
          return await upload(e.name, e.path, event.uid)
              .whenComplete(() => emit(ChatSuccessfulState()));
        }).toList();
      } else if (event is DownloadFileEvent) {
        yield ChatDownLoadingState();

        await FirebaseRepo.instance.downloadFile(event.message).whenComplete(
            () => emit(ChatDownloadSuccessfulState(event.message)));
      } else if (event is CancelButtonPressedEvent) {
        // var isCanceled =
        //     await FirebaseRepo.instance.cancelFileUpload(event.message);
        //
        // print('Checking in BLOC:$isCanceled');
        // if (isCanceled) yield ChatUploadCancelState();
      }
    } on PlatformException catch (e) {
      yield ChatUnsuccessfulState("Unsupported operation" + e.toString());
    } on FirebaseException catch (e) {
      if (e.code == 'permission-denied') {
        yield ChatUnsuccessfulState(
            'User does not have permission to upload to this reference.');
      }
      if (e.code == 'canceled') {
        yield ChatUnsuccessfulState('The task has been canceled');
      }

      yield ChatUnsuccessfulState(e.code.toString());
    } catch (ex) {
      yield ChatUnsuccessfulState(ex.toString());
    }
  }

  Future<void> upload(String fileName, String filePath, String uid) async {
    await FirebaseRepo.instance
        .uploadFiles(fileName: fileName, filePath: filePath, uid: uid);
  }
}

