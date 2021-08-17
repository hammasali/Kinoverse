import 'package:flutter/cupertino.dart';

class ChatModel {
  var senderId,
      receiverId,
      message,
      timestamp,
      name,
      photo,
      time,
      fileReceivedStatus;
  bool messageText;

  /// =====================Message DATA MODEL=================================

  ChatModel({
    @required this.senderId,
    @required this.receiverId,
    @required this.message,
    @required this.timestamp,
    @required this.time,
    @required this.messageText,
    this.fileReceivedStatus,
  });

  // ChatModel.fileReceivedStatus({
  //   @required this.senderId,
  //   @required this.receiverId,
  //   @required this.message,
  //   @required this.timestamp,
  //   @required this.time,
  //   @required this.messageText,
  //   @required this.fileReceivedStatus,
  // });

  Map toMap(ChatModel info) {
    var data = Map<String, dynamic>();

    data['senderId'] = info.senderId;
    data['receiverId'] = info.receiverId;
    data['message'] = info.message;
    data['timestamp'] = info.timestamp;
    data['time'] = info.time;
    data['messageText'] = info.messageText;
    data['fileReceivedStatus'] = info.fileReceivedStatus;
    return data;
  }

  factory ChatModel.fromMap(Map<String, dynamic> data) {
    return ChatModel(
        senderId: data['senderId'],
        receiverId: data['receiverId'],
        timestamp: data['timestamp'],
        message: data['message'],
        time: data['time'],
        messageText: data['messageText'],
        fileReceivedStatus: data['fileReceivedStatus']);
  }

  ///=============================Chat Room Data MODEL==========================

  ChatModel.chatRoom(
      {@required this.senderId,
      @required this.receiverId,
      @required this.message,
      @required this.timestamp,
      this.name,
      this.photo,
      this.time});

  Map toChatRoomMap(ChatModel info) {
    var data = Map<String, dynamic>();

    data['senderId'] = info.senderId;
    data['receiverId'] = info.receiverId;
    data['message'] = info.message;
    data['timestamp'] = info.timestamp;
    data['name'] = info.name;
    data['photo'] = info.photo;
    data['time'] = info.time;

    return data;
  }

  factory ChatModel.fromChatRoomMap(Map<String, dynamic> data) {
    return ChatModel.chatRoom(
        senderId: data['senderId'],
        receiverId: data['receiverId'],
        timestamp: data['timestamp'],
        message: data['message'],
        photo: data['photo'],
        time: data['time'],
        name: data['name']);
  }
}
