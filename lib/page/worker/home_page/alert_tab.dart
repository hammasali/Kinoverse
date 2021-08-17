import 'package:flutter/material.dart';
import 'package:kinoverse/app.dart';
import 'package:kinoverse/common/TextStyleRes.dart';

class AlertTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            color: btnColor,
            padding: EdgeInsets.only(bottom: 10),
            child: Center(
              child: TextStyleRes.textUbuntuStyleFont2(
                  text: "Your Notifications",
                  fontSize: 12,
                  fontWeight: FontWeight.w700),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  App.calendarIcon,
                  color: txtDescriptionColor,
                  height: 18,
                ),
                SizedBox(
                  width: 10,
                ),
                TextStyleRes.textUbuntuStyleFont3(
                    text: "March 20, 2021",
                    txtColor: txtDescriptionColor,
                    fontSize: 12,
                    fontWeight: FontWeight.w700),
                Spacer(),
                TextStyleRes.textUbuntuStyleFont2(
                    text: "3 New Notifications",
                    fontSize: 10,
                    fontWeight: FontWeight.w400),
                SizedBox(
                  width: 10,
                ),
                Image.asset(
                  App.mailIcon,
                  color: txtDescriptionColor,
                  height: 18,
                ),
              ],
            ),
          ),
          Divider(
            color: txtDescriptionColor,
          ),
          Container(
            padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                BasicAlert(
                  title:
                      "This is test notification from user for testing purpose to handle testing",
                  from: "Test User",
                ),
                SizedBox(
                  height: 10,
                ),
                AchivementAlert(
                  title:
                      "This is test notification from user for testing purpose to handle testing",
                  from: "Text User",
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class BasicAlert extends StatelessWidget {
  final String title;
  final String from;

  const BasicAlert({this.title, this.from});
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: btnColor, width: 1),
      ),
      padding: EdgeInsets.all(16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: getDeviceWidth(context) * 0.7,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextStyleRes.textUbuntuStyleFont2(
                    text: title, fontSize: 10, fontWeight: FontWeight.w700),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    TextStyleRes.textUbuntuStyleFont3(
                        text: "from",
                        fontSize: 10,
                        fontWeight: FontWeight.w400,
                        txtColor: txtDescriptionColor),
                    SizedBox(
                      width: 10,
                    ),
                    TextStyleRes.textUbuntuStyleFont3(
                        text: from,
                        fontSize: 10,
                        fontWeight: FontWeight.w400,
                        txtColor: btnColor),
                  ],
                )
              ],
            ),
          ),
          Spacer(),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InkWell(
                  onTap: () {
                    ///mail tapped
                  },
                  child: Image.asset(
                    App.mailIcon,
                    color: txtDescriptionColor,
                    height: 18,
                  )),
              SizedBox(
                height: 10,
              ),
              InkWell(
                  onTap: () {
                    ///delete tapped
                  },
                  child: Image.asset(
                    App.deleteIcon,
                    color: txtDescriptionColor,
                    height: 18,
                  )),
            ],
          )
        ],
      ),
    );
  }
}

class AchivementAlert extends StatelessWidget {
  final String title;
  final String from;

  const AchivementAlert({this.title, this.from});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Divider(
          color: txtDescriptionColor,
        ),
        Container(
          padding: EdgeInsets.symmetric(vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: getDeviceWidth(context) * 0.7,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextStyleRes.textUbuntuStyleFont2(
                        text: title, fontSize: 10, fontWeight: FontWeight.w700),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        TextStyleRes.textUbuntuStyleFont3(
                            text: "from",
                            fontSize: 10,
                            fontWeight: FontWeight.w400,
                            txtColor: txtDescriptionColor),
                        SizedBox(
                          width: 10,
                        ),
                        TextStyleRes.textUbuntuStyleFont3(
                            text: from,
                            fontSize: 10,
                            fontWeight: FontWeight.w400,
                            txtColor: btnColor),
                      ],
                    )
                  ],
                ),
              ),
              Spacer(),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                      onTap: () {
                        ///mail tapped
                      },
                      child: Image.asset(
                        App.mailIcon,
                        color: txtDescriptionColor,
                        height: 18,
                      )),
                  SizedBox(
                    height: 10,
                  ),
                  InkWell(
                      onTap: () {
                        ///delete tapped
                      },
                      child: Image.asset(
                        App.deleteIcon,
                        color: txtDescriptionColor,
                        height: 18,
                      )),
                ],
              )
            ],
          ),
        ),
      ],
    );
  }
}
