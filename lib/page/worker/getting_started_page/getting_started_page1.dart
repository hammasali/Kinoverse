import 'dart:async';

import 'package:flutter/material.dart';
import 'package:kinoverse/app.dart';
import 'package:kinoverse/backend_service/repo/firebase_repo.dart';
import 'package:kinoverse/common/StringRes.dart';
import 'package:kinoverse/common/TextStyleRes.dart';
import 'package:kinoverse/common/common_widget.dart';
import 'package:kinoverse/page/worker/getting_started_page/getting_started_page2.dart';

class GettingStartedPage1 extends StatefulWidget {
  static const String routeName = '/getting_StartedPage1';

  @override
  _GettingStartedPageState createState() => _GettingStartedPageState();
}

class _GettingStartedPageState extends State<GettingStartedPage1> {
  bool _isUserEmailVerified = false;
  Timer _timer;

  @override
  void initState() {
    Future(() async {
      _timer = Timer.periodic(Duration(seconds: 5), (timer) async {
        FirebaseRepo.instance.getCurrentUser().reload();
        var user = FirebaseRepo.instance.getCurrentUser();
        if (user.emailVerified) {
          setState(() {
            _isUserEmailVerified = user.emailVerified;
          });

          timer.cancel();
        }
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    if (_timer != null) {
      _timer?.cancel();
    }
  }

  @override
  Widget build(BuildContext context) {
    print("runtimeType -> " + runtimeType.toString());
    return Scaffold(
      backgroundColor: bgColor,
      body: SafeArea(
        child: !_isUserEmailVerified
            ? Container(
                padding: EdgeInsets.only(top: 60),
                child: Column(
                  children: [
                    gettingStartBtn(),
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 55, left: 20, right: 10),
                      child: Text(
                          'We have sent link to your account. Please verify it.',
                          style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w700,
                              color: txtColor)),
                    ),
                    SizedBox(
                      height: 5.0,
                    ),
                    CircularProgressIndicator.adaptive(
                      strokeWidth: 1.1,
                      backgroundColor: Color(0x00ffA60000),
                      valueColor: new AlwaysStoppedAnimation<Color>(
                          Color(0x00ffffffff)),
                    )
                  ],
                ),
              )
            :
        Container(
                padding: EdgeInsets.only(top: 60),
                child: SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      gettingStartBtn(),
                      txtOnly(),
                      myProfile(),
                    ],
                  ),
                ),
              ),
      ),
    );
  }

  ///gettingStartBtn
  gettingStartBtn() {
    return Center(
      child: Container(
        margin: EdgeInsets.all(5),
        height: 50.0,
        width: MediaQuery.of(context).size.width / 1.7,
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(width: 5.0, color: btnColor),
          ),
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: bgColor,
              blurRadius: 3,
              offset: Offset(1, 3),
            ),
          ],
        ),
        child: RaisedButton(
          elevation: 25,
          onPressed: () {},
          padding: EdgeInsets.all(10.0),
          color: bgColor,
          textColor: Colors.white,
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Image.asset(
                  App.download,
                  color: txtColor,
                  height: 20,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 12),
                child: Text("Getting Started",
                    style:
                        TextStyle(fontSize: 15, fontWeight: FontWeight.w400)),
              ),
            ],
          ),
        ),
      ),
    );
  }

  ///txt
  txtOnly() {
    return Padding(
      padding: const EdgeInsets.only(top: 55, left: 20, right: 10),
      child: Text(
          "To provide a hight quality experience to all customers, admission to Kinoverse is highly competitive.",
          style: TextStyle(
              fontSize: 12, fontWeight: FontWeight.w700, color: txtColor)),
    );
  }

  ///myProfile
  myProfile() {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20, top: 30),
      child: Container(
        padding: const EdgeInsets.only(left: 30, right: 20, top: 10),
        color: backContainerColor,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextStyleRes.textUbuntuStyleFont2(
                text: StringRes.howItWork,
                fontSize: 10,
                fontWeight: FontWeight.w400),
            SizedBox(
              height: 25,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 30),
              child: TextStyleRes.textUbuntuStyleFont2(
                  text: StringRes.questions,
                  fontSize: 10,
                  fontWeight: FontWeight.w400),
            ),
            SizedBox(
              height: 25,
            ),
            TextStyleRes.textUbuntuStyleFont2(
                text: StringRes.gettingApproved,
                fontSize: 10,
                fontWeight: FontWeight.w400),
            SizedBox(
              height: 50,
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: CommonWidget.squareButton(
                text: StringRes.startMyProfile,
                fontSize: 12.0,
                height: 40.0,
                width: 150.0,
                fontWeight: FontWeight.w700,
                containerColor: btnColor,
                textColor: txtColor,
                onTap: () {
                  //CommonRoutePage().gotoGettingStartedPage2(context);
                  Navigator.of(context)
                      .pushNamed(GettingStartedPage2.routeName);
                },
              ),
            ),
            SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}
