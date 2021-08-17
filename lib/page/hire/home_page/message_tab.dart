import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:kinoverse/app.dart';
import 'package:kinoverse/backend_service/models/chat_model.dart';
import 'package:kinoverse/backend_service/repo/firebase_repo.dart';
import 'package:kinoverse/common/TextStyleRes.dart';
import 'package:kinoverse/core/route_pass.dart';
import 'package:kinoverse/page/hire/chat_page/chat_page.dart';

class HireMessageTab extends StatelessWidget {
  final Query _fetchUserChatRoom = FirebaseRepo.instance.fetchUserChatRoom();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: _fetchUserChatRoom.snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError)
            return Center(
              child: TextStyleRes.textUbuntuStyleFont3(
                  txtColor: txtDescriptionColor,
                  text: "Something went wrong",
                  fontSize: 12,
                  fontWeight: FontWeight.w700),
            );
          else if (!snapshot.hasData)
            return Center(
              child: TextStyleRes.textUbuntuStyleFont3(
                  txtColor: txtDescriptionColor,
                  text: "Alas! No data found",
                  fontSize: 12,
                  fontWeight: FontWeight.w700),
            );
          else if (snapshot.hasData) {
            return _tiles(snapshot.data.docs);
          }
          return Center(
            child: Padding(
                padding: EdgeInsets.all(16),
                child: getCircularProgress(context)),
          );
        });
  }

  Widget _tiles(List<QueryDocumentSnapshot> docs) {
    return ListView.builder(
        itemCount: docs.length,
        itemBuilder: (BuildContext context, int index) {
          var data = ChatModel.fromChatRoomMap(docs[index].data());

          return InkWell(
            onTap: () => Navigator.of(context).pushNamed(HireChatPage.routeName,
                arguments: HireChatPageArgs(
                  uid: data.receiverId,
                  name: data.name,
                  photoUrl: data.photo
                )),
            child: ListTile(
              leading: FutureBuilder<String>(
                  future: FirebaseRepo.instance
                      .downloadAllUserURLs(data.receiverId),
                  builder:
                      (BuildContext context, AsyncSnapshot<String> snapshot) {
                    if (snapshot.connectionState == ConnectionState.done &&
                        snapshot.data != null)
                      return CircleAvatar(
                          radius: 20,
                          backgroundImage: NetworkImage(snapshot.data));

                    return CircleAvatar(
                      child: Icon(
                        Icons.person,
                        color: Colors.blue,
                      ),
                      backgroundColor: Colors.white,
                    );
                  }),
              title: TextStyleRes.textUbuntuStyleFont2(
                  text: data.name, fontSize: 13, fontWeight: FontWeight.w700),
              subtitle: Text(
                data.message,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    fontFamily: App.font2, color: txtDescriptionColor),
              ),
              trailing: TextStyleRes.textUbuntuStyleFont3(
                  txtColor: txtDescriptionColor,
                  text: data.time,
                  fontSize: 10,
                  fontWeight: FontWeight.w400),
            ),
          );
        });
  }
}
