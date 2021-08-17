import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:kinoverse/app.dart';
import 'package:kinoverse/common/TextStyleRes.dart';
import 'package:kinoverse/common/common_route.dart';

class ChatPage extends StatefulWidget {
  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  var messageController = TextEditingController();

@override
  void dispose() {
    super.dispose();
    messageController.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: btnColor,
        title: TextStyleRes.textStyleFont1(
            text: "Messages",
            fontSize: 14,
            fontWeight: FontWeight.w700,
            textColor: Colors.white),
      ),
      body: Container(
        color: bgColor,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(0.0),
                color: bgColor,
                boxShadow: [
                  BoxShadow(
                    offset: Offset(0.0, 1.0), //(x,y)
                    blurRadius: 0.8,
                  ),
                ],
              ),
              padding:
                  const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16),
              child: Row(
                children: [
                  InkWell(
                    onTap: () {
                      CommonRoutePage().navigatorPop(context);
                    },
                    child: Image.asset(
                      App.backIcon,
                      height: 24,
                      width: 24,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  Container(
                    width: 30,
                    height: 30,
                    child: CircleAvatar(
                        backgroundColor: Colors.transparent,
                        child: Icon(
                          Icons.account_circle_outlined,
                          color: Colors.white,
                          size: 30,
                        )),
                  ),
                  Spacer(),
                  Column(
                    children: [
                      TextStyleRes.textUbuntuStyleFont2(
                          text: "Maria Sharapova",
                          fontSize: 12,
                          fontWeight: FontWeight.w700),
                      SizedBox(
                        height: 5,
                      ),
                      TextStyleRes.textUbuntuStyleFont2(
                          text: "Online",
                          fontSize: 10,
                          fontWeight: FontWeight.w400),
                    ],
                  ),
                  Spacer(),
                  InkWell(
                      onTap: () {
                        ///more Tap
                      },
                      child: Image.asset(
                        App.moreIcon,
                        height: 24,
                        width: 25,
                        color: Colors.white,
                      ))
                ],
              ),
            ),
            Expanded(
              child: ListView(
                children: [
                  DateHeader("Today"),
                  SenderMessage("10:15 Am", "Read", "Hello there!"),
                  ReceiverMessage("10:15 Am", "Read", "Hello there!"),
                  SenderMessage("10:15 Am", "Read",
                      "Hello there! skdjsd kasjd asjd kajsd askd kasjd aksd asdhkas das"),
                  ReceiverMessage("10:15 Am", "Read", "Hello there!"),
                  SenderMessage("10:15 Am", "Read",
                      "Hello there! skdjsd kasjd asjd kajsd askd kasjd aksd asdhkas das"),
                  ReceiverMessage("10:15 Am", "Read", "Hello there!"),
                  SenderMessage("10:15 Am", "Read",
                      "Hello there! skdjsd kasjd asjd kajsd askd kasjd aksd asdhkas das"),
                  ReceiverMessage("10:15 Am", "Read",
                      "Hello there! sjd kajsd askd kasjd aksd asdhkas dasasjd kajsd askd kasjd aksd asdhkas "),
                  ReceiverMessage("10:15 Am", "Read", "Hello there!"),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            bottomView()
          ],
        ),
      ),
    );
  }

  ///BottomView
  bottomView() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(0.0),
        color: bgColor,
        boxShadow: [
          BoxShadow(
            offset: Offset(0.0, -1.0), //(x,y)
            blurRadius: 0.8,
          ),
        ],
      ),
      child: Row(
        children: [
          InkWell(
            onTap: () {
              ///Microphone Tap
            },
            child: Image.asset(
              App.microphoneIcon,
              height: 24,
              width: 24,
              color: txtDescriptionColor,
            ),
          ),
          SizedBox(
            width: 5,
          ),
          InkWell(
            onTap: () {
              ///attachment Tap
            },
            child: Image.asset(
              App.attachmentIcon,
              height: 24,
              width: 24,
              color: txtDescriptionColor,
            ),
          ),
          SizedBox(
            width: 5,
          ),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: txtDescriptionColor, width: 1),
              ),
              child: TextFormField(
                cursorColor: txtColor,
                controller: messageController,
                style: TextStyle(
                  fontFamily: App.font2,
                  color: txtColor,
                  fontSize: 12,
                ),
                decoration: new InputDecoration(
                    isDense: true,
                    border: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    errorBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                    contentPadding: EdgeInsets.only(
                        left: 10, bottom: 10, top: 10, right: 10),
                    hintText: "Start typing messages here...",
                    hintStyle: TextStyle(
                      fontFamily: App.font2,
                      color: btnBorderWhite,
                      fontSize: 10,
                    )),
              ),
            ),
          ),
          SizedBox(
            width: 5,
          ),
          InkWell(
            onTap: () {
              ///send Tap
            },
            child: Image.asset(
              App.sendIcon,
              height: 24,
              width: 24,
              color: btnColor,
            ),
          ),
        ],
      ),
    );
  }
}

class DateHeader extends StatelessWidget {
  final String title;
  const DateHeader(this.title);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Divider(
              thickness: 1.2,
              color: txtDescriptionColor,
            ),
          ),
          SizedBox(
            width: 10,
          ),
          TextStyleRes.textUbuntuStyleFont3(
              text: title,
              fontSize: 12,
              fontWeight: FontWeight.w400,
              txtColor: txtDescriptionColor),
          SizedBox(
            width: 10,
          ),
          Expanded(
            child: Divider(
              thickness: 1.2,
              color: txtDescriptionColor,
            ),
          ),
        ],
      ),
    );
  }
}

class SenderMessage extends StatelessWidget {
  final String date;
  final String read;
  final String message;
  const SenderMessage(this.date, this.read, this.message);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          SizedBox(
            width: 40,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              TextStyleRes.textUbuntuStyleFont3(
                  text: read,
                  fontSize: 8,
                  fontWeight: FontWeight.w400,
                  txtColor: txtDescriptionColor),
              TextStyleRes.textUbuntuStyleFont3(
                  text: date,
                  fontSize: 8,
                  fontWeight: FontWeight.w400,
                  txtColor: txtDescriptionColor),
            ],
          ),
          SizedBox(
            width: 10,
          ),
          Flexible(
            child: Container(
              // width: getDeviceWidth(context) * 0.7,
              color: backContainerColor,
              padding: EdgeInsets.all(8),
              child: TextStyleRes.textUbuntuStyleFont3(
                  text: message,
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  txtColor: txtColor),
            ),
          ),
        ],
      ),
    );
  }
}

class ReceiverMessage extends StatelessWidget {
  final String date;
  final String read;
  final String message;
  const ReceiverMessage(this.date, this.read, this.message);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Flexible(
            child: Container(
              // width: getDeviceWidth(context) * 0.7,
              color: txtDescriptionColor,
              padding: EdgeInsets.all(8),
              child: TextStyleRes.textUbuntuStyleFont3(
                  text: message,
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  txtColor: Colors.black),
            ),
          ),
          SizedBox(
            width: 10,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              TextStyleRes.textUbuntuStyleFont3(
                  text: read,
                  fontSize: 8,
                  fontWeight: FontWeight.w400,
                  txtColor: txtDescriptionColor),
              TextStyleRes.textUbuntuStyleFont3(
                  text: date,
                  fontSize: 8,
                  fontWeight: FontWeight.w400,
                  txtColor: txtDescriptionColor),
            ],
          ),
          SizedBox(
            width: 40,
          ),
        ],
      ),
    );
  }
}

class AttachmentView extends StatelessWidget {
  final String numberOfFiles;
  const AttachmentView(this.numberOfFiles);
  @override
  Widget build(BuildContext context) {
    return Container(
      color: btnColor,
      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 20),
      child: Row(
        children: [
          Image.asset(
            App.attachedIcon,
            height: 20,
            width: 20,
            color: Colors.white,
          ),
          SizedBox(
            width: 10,
          ),
          TextStyleRes.textUbuntuStyleFont3(
              text: "$numberOfFiles files attached",
              fontSize: 14,
              fontWeight: FontWeight.w400,
              txtColor: txtColor),
        ],
      ),
    );
  }
}
