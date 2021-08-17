import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:kinoverse/app.dart';
import 'package:kinoverse/backend_service/models/chat_model.dart';
import 'package:kinoverse/backend_service/repo/firebase_repo.dart';
import 'package:kinoverse/common/TextStyleRes.dart';
import 'package:kinoverse/common/common_route.dart';
import 'package:kinoverse/page/worker/chat_page/chat_page.dart';

class HireChatPage extends StatefulWidget {
  static const String routeName = '/hireChat_page';
  final String uid, name, photoUrl;

  HireChatPage({Key key, this.uid, this.name, this.photoUrl}) : super(key: key);

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<HireChatPage> {
  var messageController = TextEditingController();
  ScrollController _listController;
  Query _fetchChat;
  var _currentUser;
  bool _isWriting;
  List<File> files;

  @override
  void initState() {
    super.initState();
    print(widget.uid);
    _fetchChat = FirebaseRepo.instance.fetchUserChat(widget.uid);
    _currentUser = FirebaseRepo.instance.getCurrentUser().uid;
    messageController = TextEditingController();
    _listController = ScrollController();
    _isWriting = false;
  }

  @override
  void dispose() {
    messageController.dispose();
    _listController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: btnColor,
        toolbarHeight: 0.0,
      ),
      body: Container(
        color: bgColor,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(0.0),
                color: btnColor,
                boxShadow: [
                  BoxShadow(
                    offset: Offset(0.0, 1.0), //(x,y)
                    blurRadius: 0.2,
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
                  FutureBuilder<String>(
                      future:
                          FirebaseRepo.instance.downloadAllUserURLs(widget.uid),
                      builder: (BuildContext context,
                          AsyncSnapshot<String> snapshot) {
                        if (snapshot.connectionState == ConnectionState.done &&
                            snapshot.data != null)
                          return CircleAvatar(
                              radius: 20,
                              backgroundImage: NetworkImage(snapshot.data));

                        return Container(
                          width: 30,
                          height: 30,
                          child: CircleAvatar(
                              backgroundColor: Colors.transparent,
                              child: Icon(
                                Icons.account_circle_outlined,
                                color: Colors.white,
                                size: 30,
                              )),
                        );
                      }),
                  Spacer(),
                  Column(
                    children: [
                      TextStyleRes.textUbuntuStyleFont2(
                          text: widget.name,
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

                  SizedBox(
                    height: 24,
                    width: 25,
                  )

                  //TODO: More Icon Modules Here ======= >>>>>>>>

                  // InkWell(
                  //     onTap: () {
                  //       ///more Tap
                  //     },
                  //     child: Image.asset(
                  //       App.moreIcon,
                  //       height: 24,
                  //       width: 25,
                  //       color: Colors.white,
                  //     ))
                ],
              ),
            ),
            StreamBuilder<QuerySnapshot>(
                stream: _fetchChat?.snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasError)
                    return Expanded(
                      child: Center(
                        child: TextStyleRes.textUbuntuStyleFont3(
                            txtColor: txtDescriptionColor,
                            text: "Something went wrong",
                            fontSize: 12,
                            fontWeight: FontWeight.w700),
                      ),
                    );
                  else if (!snapshot.hasData)
                    return Expanded(
                      child: Center(
                        child: TextStyleRes.textUbuntuStyleFont3(
                            txtColor: txtDescriptionColor,
                            text: "Send Your First Message to ${widget.name}",
                            fontSize: 12,
                            fontWeight: FontWeight.w700),
                      ),
                    );
                  else if (snapshot.hasData) {
                    return Expanded(child: chats(snapshot.data.docs));
                  }

                  return Expanded(
                    child: Center(
                      child: Padding(
                          padding: EdgeInsets.all(16),
                          child: getCircularProgress(context)),
                    ),
                  );
                }),
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
            blurRadius: 0.2,
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
                autofocus: false,
                onChanged: (val) {
                  (val.length > 0 && val.trim() != '')
                      ? setState(() {
                          _isWriting = true;
                        })
                      : setState(() {
                          _isWriting = false;
                        });
                },
                style: TextStyle(
                  fontFamily: App.font1,
                  color: txtColor,
                  fontSize: 13,
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
                      fontFamily: App.font1,
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
              if (_isWriting) {
                FirebaseRepo.instance
                    .addMessageToDB(messageController.text, widget.uid);
                messageController.text = '';
                setState(() {
                  _isWriting = false;
                });
              }
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

  Widget chats(List<QueryDocumentSnapshot<Object>> docs) {
    ///This is to get the bottom of list when new message arrives. It will call
    ///every time whenever the setState calls / UI change
    SchedulerBinding.instance.addPostFrameCallback((_) {
      _listController.animateTo(_listController.position.maxScrollExtent,
          duration: Duration(microseconds: 250), curve: Curves.easeInOut);
    });
    return ListView.builder(
        controller: _listController,
        itemCount: docs.length,
        shrinkWrap: true,
        itemBuilder: (BuildContext context, int index) {
          var data = ChatModel.fromMap(docs[index].data());

          return data.senderId == _currentUser
              ? SenderMessage(data.time, "", data.message)
              : ReceiverMessage(data.time, "", data.message);
        });
  }
}

// return Column(
//   children: [
//     DateHeader("Today"),
// SenderMessage("10:15 Am", "Read",
// "Hello there! skdjsd kasjd asjd kajsd askd kasjd aksd asdhkas das"),
//     ReceiverMessage("10:15 Am", "Read", "Hello there!"),
//     SenderMessage("10:15 Am", "Read",
//         "Hello there! skdjsd kasjd asjd kajsd askd kasjd aksd asdhkas das"),
//     ReceiverMessage("10:15 Am", "Read", "Hello there!"),
//     SenderMessage("10:15 Am", "Read",
//         "Hello there! skdjsd kasjd asjd kajsd askd kasjd aksd asdhkas das"),
//     ReceiverMessage("10:15 Am", "Read", "Hello there!"),
//     SenderMessage("10:15 Am", "Read",
//         "Hello there! skdjsd kasjd asjd kajsd askd kasjd aksd asdhkas das"),
//     ReceiverMessage("10:15 Am", "Read", "Hello there!"),
//     ReceiverMessage("10:15 Am", "Read", "Hello there!"),
//   ],
// );
