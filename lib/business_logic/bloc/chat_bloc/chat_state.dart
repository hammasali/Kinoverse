part of 'chat_bloc.dart';

@immutable
abstract class ChatState {}

class ChatInitialState extends ChatState {}

class ChatLoadingState extends ChatState {}

class ChatDownLoadingState extends ChatState {}

// class ChatUploadCancelState extends ChatState{}

class ChatSuccessfulState extends ChatState {
  final List<File> files;

  ChatSuccessfulState({this.files});
}

class ChatDownloadSuccessfulState extends ChatState {
  final String message;
  ChatDownloadSuccessfulState(this.message);
}

class ChatUnsuccessfulState extends ChatState {
  final String message;

  ChatUnsuccessfulState(this.message);
}
