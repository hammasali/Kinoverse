import 'package:flutter/material.dart';
import 'package:kinoverse/app.dart';
import 'package:kinoverse/common/TextStyleRes.dart';
import 'package:kinoverse/page/worker/home_page/alert_tab.dart';

class HireAlertTab extends StatelessWidget {
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
