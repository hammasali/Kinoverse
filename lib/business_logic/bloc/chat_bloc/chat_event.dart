part of 'chat_bloc.dart';

@immutable
abstract class ChatEvent {}

class SelectFileEvent extends ChatEvent {
  final String uid;

  SelectFileEvent(this.uid);
}

class DownloadFileEvent extends ChatEvent {
  final String message;

  DownloadFileEvent(this.message);
}
class CancelButtonPressedEvent extends ChatEvent{
  final String message;

  CancelButtonPressedEvent(this.message);
}
