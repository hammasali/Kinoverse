import 'package:flutter/material.dart';

import '../app.dart';


class StartScreen extends StatefulWidget {
  @override
  SignUpState createState() => SignUpState();
}

class SignUpState extends State<StartScreen> {

  @override
  Widget build(BuildContext context) {
    print("runtimeType -> " + runtimeType.toString());

    return Scaffold(
     // backgroundColor: bgColor,
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.only(top: 60),
          child: ListView(
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Center(
                    child: Image.asset(
                      App.logo,
                      width: MediaQuery.of(context).size.height * 0.4,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

}
