import 'package:flutter/material.dart';
import 'package:kinoverse/app.dart';
import 'package:kinoverse/common/TextStyleRes.dart';
import 'package:kinoverse/common/common_route.dart';
import 'package:kinoverse/common/common_widget.dart';
import 'package:kinoverse/page/worker/home_page/home_page.dart';
import 'package:kinoverse/page/worker/my_jobs/get_paid_page.dart';

import 'my_jobs.dart';

class SubmitWorkPage extends StatelessWidget {
  static const String routeName = '/submitWork_page';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: btnColor,
        title: TextStyleRes.textStyleFont1(
            text: "My Jobs",
            fontSize: 14,
            fontWeight: FontWeight.w700,
            textColor: Colors.white),
      ),
      body: Container(
        color: bgColor,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Material(
                elevation: 10,
                color: bgColor,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(0.0),
                    color: bgColor,
                    // boxShadow: [
                    //   BoxShadow(
                    //     offset: Offset(0.0, 1.0), //(x,y)
                    //     blurRadius: 0.2,
                    //   ),
                    // ],
                  ),
                  padding:
                      const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16),
                  child: Row(
                    children: [
                      // InkWell(
                      //   onTap: () {
                      //     CommonRoutePage().navigatorPop(context);
                      //   },
                      //   child: Image.asset(
                      //     App.backIcon,
                      //     height: 24,
                      //     width: 24,
                      //     color: Colors.white,
                      //   ),
                      // ),
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
                      SizedBox(
                        width: 15,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextStyleRes.textUbuntuStyleFont2(
                              text: "Maria Sharapova",
                              fontSize: 16,
                              fontWeight: FontWeight.w600),
                          SizedBox(
                            height: 5,
                          ),
                          TextStyleRes.textUbuntuStyleFont2(
                              text: "Production House need film editor",
                              fontSize: 12,
                              fontWeight: FontWeight.w400),
                          SizedBox(
                            height: 5,
                          ),
                          TextStyleRes.textUbuntuStyleFont3(
                              txtColor: txtDescriptionColor,
                              text: "Active Since April 12, 2021",
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
              ),
              SizedBox(
                height: 10,
              ),
              MileStoneActiveItem(
                  "Editing post-production for production house project",
                  "May 21",
                  "\$450 (Funded)",
                  "Active",
                  "1"),
              SizedBox(
                height: 10,
              ),
              Center(
                child: TextStyleRes.textUbuntuStyleFont2(
                    text: "Submit work or request payment for milestone",
                    fontSize: 16,
                    fontWeight: FontWeight.w600),
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16),
                child: Container(
                  decoration: BoxDecoration(
                      border: Border.all(color: txtDescriptionColor, width: 1)),
                  padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextStyleRes.textUbuntuStyleFont3(
                          txtColor: txtColor,
                          text:
                              "Use this form to request approval for the work you’ve completed. Your payment will be released upon approval.",
                          fontSize: 14,
                          fontWeight: FontWeight.w300),
                      SizedBox(
                        height: 10,
                      ),
                      TextStyleRes.textUbuntuStyleFont2(
                          text: "Milestones",
                          fontSize: 14,
                          fontWeight: FontWeight.w600),
                      SizedBox(
                        height: 5,
                      ),
                      TextStyleRes.textUbuntuStyleFont3(
                          txtColor: txtColor,
                          text:
                              "Editing post-production for production house project",
                          fontSize: 14,
                          fontWeight: FontWeight.w300),
                      SizedBox(
                        height: 5,
                      ),
                      TextStyleRes.textUbuntuStyleFont3(
                          txtColor: txtDescriptionColor,
                          text: "Due May 13",
                          fontSize: 12,
                          fontWeight: FontWeight.w300),
                      SizedBox(
                        height: 10,
                      ),
                      TextStyleRes.textUbuntuStyleFont2(
                          text: "Description",
                          fontSize: 14,
                          fontWeight: FontWeight.w600),
                      SizedBox(
                        height: 5,
                      ),
                      TextStyleRes.textUbuntuStyleFont3(
                          txtColor: txtColor,
                          text:
                              "A production house needs someone with experience in cinema film projects.",
                          fontSize: 14,
                          fontWeight: FontWeight.w300),
                      SizedBox(
                        height: 10,
                      ),
                      TextStyleRes.textUbuntuStyleFont2(
                          text: "Amount",
                          fontSize: 14,
                          fontWeight: FontWeight.w600),
                      SizedBox(
                        height: 5,
                      ),
                      Container(
                        width: 80,
                        decoration: BoxDecoration(
                            border:
                                Border.all(color: txtDescriptionColor, width: 1)),
                        padding: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                        child: Row(
                          children: [
                            TextStyleRes.textUbuntuStyleFont2(
                                text: "\$",
                                fontSize: 14,
                                fontWeight: FontWeight.w600),
                            Spacer(),
                            TextStyleRes.textUbuntuStyleFont2(
                                text: "450",
                                fontSize: 14,
                                fontWeight: FontWeight.w600),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextStyleRes.textUbuntuStyleFont2(
                          text: "Description",
                          fontSize: 14,
                          fontWeight: FontWeight.w600),
                      SizedBox(
                        height: 5,
                      ),
                      Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: btnBorderWhite, width: 1),
                          ),
                          child: TextFormField(
                            cursorColor: txtColor,
                            maxLines: 5,
                            style: TextStyle(
                              fontFamily: App.font2,
                              color: txtColor,
                              fontSize: 13,
                            ),
                            decoration: new InputDecoration(
                                border: InputBorder.none,
                                focusedBorder: InputBorder.none,
                                enabledBorder: InputBorder.none,
                                errorBorder: InputBorder.none,
                                disabledBorder: InputBorder.none,
                                contentPadding: EdgeInsets.only(
                                  left: 10,
                                  bottom: 10,
                                  top: 10,
                                ),
                                hintText:
                                    "Describe the work you have completed for this milestones..",
                                hintStyle: TextStyle(
                                  fontFamily: App.font2,
                                  color: txtColor,
                                  fontSize: 10,
                                )),
                          )),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              InkWell(
                                onTap: () {
                                  ///attach press
                                },
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 8, horizontal: 8),
                                  decoration: BoxDecoration(
                                    border: Border.all(color: btnColor, width: 1),
                                  ),
                                  child: Row(
                                    children: [
                                      Image.asset(
                                        App.attachmentIcon,
                                        height: 20,
                                        width: 20,
                                        color: btnColor,
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      TextStyleRes.textUbuntuStyleFont3(
                                          txtColor: txtDescriptionColor,
                                          text: "Attach File",
                                          fontSize: 14,
                                          fontWeight: FontWeight.w300),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              TextStyleRes.textUbuntuStyleFont3(
                                  txtColor: txtDescriptionColor,
                                  text: "(up to 2GB)",
                                  fontSize: 12,
                                  fontWeight: FontWeight.w300),
                            ],
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Expanded(
                            child: TextStyleRes.textUbuntuStyleFont3(
                                txtColor: txtDescriptionColor,
                                text:
                                    "Attaching work is recommended, but not required if you’ve already delivered work.",
                                fontSize: 12,
                                fontWeight: FontWeight.w300),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
              bottomView(context)
            ],
          ),
        ),
      ),
    );
  }

  ///BottomView
  bottomView(context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(0.0),
        color: bgColor,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ///cancel
          InkWell(
            onTap: () => Navigator.pushNamedAndRemoveUntil<dynamic>(
              context,
              HomePage.routeName,
                  (route) =>
              false, //if you want to disable back feature set to false
            ),
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: txtDescriptionColor, width: 1),
              ),
              height: 35.0,
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: CommonWidget.squareButton(
                text: "Cancel",
                fontSize: 10.0,
                textColor: txtDescriptionColor,
              ),
            ),
          ),
          MaterialButton(
            height: 35.0,
            elevation: 5,
            color: btnColor,
            textColor: Colors.white,
            child: Text(
              'Submit',
              textScaleFactor: 1.0,
            ),
            onPressed: () {
              Navigator.of(context).pushNamed(GetPaidPage.routeName);
            },
          ),
        ],
      ),
    );
  }
}
