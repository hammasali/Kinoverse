import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:kinoverse/app.dart';
import 'package:kinoverse/common/TextStyleRes.dart';
import 'package:kinoverse/page/hire/home_page/jobs_tab.dart';

class HirePayNow extends StatelessWidget {
  static const String routeName = '/hirePay_now';
  var descriptionController = TextEditingController();
  var bonusController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: btnColor,
        title: TextStyleRes.textStyleFont1(
            text: "Pay Now",
            fontSize: 14,
            fontWeight: FontWeight.w700,
            textColor: Colors.white),
      ),
      backgroundColor: bgColor,
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.all(16),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    InkWell(
                      onTap: () {
                        ///Edit Tap
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                        decoration: BoxDecoration(
                            border:
                                Border.all(color: txtDescriptionColor, width: 1)),
                        child: Row(
                          children: [
                            TextStyleRes.textUbuntuStyleFont3(
                                text: "Edit",
                                fontSize: 12,
                                fontWeight: FontWeight.w700,
                                txtColor: txtDescriptionColor),
                            SizedBox(
                              width: 5,
                            ),
                            Image.asset(
                              App.edit,
                              height: 16,
                              width: 16,
                              color: txtDescriptionColor,
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  color: backContainerColor,
                  padding: EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      jobItem(context),
                      SizedBox(
                        height: 10,
                      ),
                      TextStyleRes.textUbuntuStyleFont2(
                          text: "Will be paid to:",
                          fontSize: 14,
                          fontWeight: FontWeight.w700),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          CircleAvatar(
                            radius: 20,
                            child: Icon(
                              Icons.account_circle_outlined,
                              color: Colors.white,
                              size: 40,
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          CircleAvatar(
                            radius: 20,
                            child: Icon(
                              Icons.account_circle_outlined,
                              color: Colors.white,
                              size: 40,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextStyleRes.textUbuntuStyleFont2(
                          text: "Payment Method:",
                          fontSize: 14,
                          fontWeight: FontWeight.w700),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            height: 35,
                            color: Colors.white,
                            padding:
                                EdgeInsets.symmetric(vertical: 2, horizontal: 30),
                            child: Center(
                              child: TextStyleRes.textUbuntuStyleFont3(
                                  txtColor: Colors.black,
                                  text: "Milestones",
                                  fontSize: 12,
                                  fontWeight: FontWeight.w700),
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Container(
                            height: 35,
                            color: Colors.white,
                            padding: EdgeInsets.symmetric(horizontal: 30),
                            child: Image.asset(
                              App.paypalLogo,
                              height: 35,
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                    color: Colors.white,
                    child: TextFormField(
                      cursorColor: txtColor,
                      controller: descriptionController,
                      maxLines: 5,
                      style: TextStyle(
                        fontFamily: App.font2,
                        color: txtDescriptionColor,
                        fontSize: 12,
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
                              "Add Reviews and Stars to Filmmakers while working with you...",
                          hintStyle: TextStyle(
                            fontFamily: App.font2,
                            color: txtDescriptionColor,
                            fontSize: 12,
                          )),
                    )),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    TextStyleRes.textUbuntuStyleFont3(
                        txtColor: txtDescriptionColor,
                        text: "(5 star is perfect work)",
                        fontSize: 12,
                        fontWeight: FontWeight.w400),
                    Spacer(),
                    RatingBar.builder(
                      itemSize: 24,
                      unratedColor: txtDescriptionColor,
                      initialRating: 5,
                      minRating: 0,
                      direction: Axis.horizontal,
                      allowHalfRating: true,
                      itemCount: 5,
                      itemBuilder: (context, _) => Icon(
                        Icons.star,
                        color: btnColor,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  color: backContainerColor,
                  padding: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                  child: Row(
                    children: [
                      Container(
                        color: btnColor,
                        padding: EdgeInsets.all(3),
                        child: Image.asset(
                          App.bonusIcon,
                          color: Colors.black,
                          height: 15,
                          width: 15,
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: TextStyleRes.textUbuntuStyleFont3(
                            txtColor: txtColor,
                            text: "Add Bonus",
                            fontSize: 14,
                            fontWeight: FontWeight.w700),
                      ),
                      TextStyleRes.textUbuntuStyleFont3(
                          txtColor: txtColor,
                          text: "\$",
                          fontSize: 14,
                          fontWeight: FontWeight.w700),
                      SizedBox(
                        width: 15,
                      ),
                      Container(
                        width: 60,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.white, width: 1),
                        ),
                        child: TextFormField(
                          cursorColor: txtColor,
                          controller: bonusController,
                          textAlign: TextAlign.end,
                          style: TextStyle(
                            fontFamily: App.font2,
                            color: txtColor,
                            fontWeight: FontWeight.w700,
                            fontSize: 12,
                          ),
                          decoration: new InputDecoration(
                              isDense: true,
                              border: InputBorder.none,
                              focusedBorder: InputBorder.none,
                              enabledBorder: InputBorder.none,
                              errorBorder: InputBorder.none,
                              disabledBorder: InputBorder.none,
                              contentPadding:
                                  EdgeInsets.only(left: 4, bottom: 4, top: 4),
                              hintText: "",
                              hintStyle: TextStyle(
                                fontFamily: App.font2,
                                color: txtColor,
                                fontSize: 12,
                              )),
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  color: backContainerColor,
                  padding: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                  child: Row(
                    children: [
                      Container(
                        color: btnColor,
                        padding: EdgeInsets.all(3),
                        child: Image.asset(
                          App.chargeIcon,
                          color: Colors.black,
                          height: 15,
                          width: 15,
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: Row(
                          children: [
                            TextStyleRes.textUbuntuStyleFont3(
                                txtColor: txtColor,
                                text: "Charge 10%",
                                fontSize: 14,
                                fontWeight: FontWeight.w700),
                            SizedBox(
                              width: 10,
                            ),
                            TextStyleRes.textUbuntuStyleFont3(
                                txtColor: txtDescriptionColor,
                                text: "(As a kinoverse service)",
                                fontSize: 10,
                                fontWeight: FontWeight.w400),
                          ],
                        ),
                      ),
                      TextStyleRes.textUbuntuStyleFont3(
                          txtColor: txtDescriptionColor,
                          text: "\$",
                          fontSize: 14,
                          fontWeight: FontWeight.w700),
                      SizedBox(
                        width: 15,
                      ),
                      SizedBox(
                          width: 60,
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: TextStyleRes.textUbuntuStyleFont3(
                                txtColor: txtDescriptionColor,
                                text: "300",
                                fontSize: 14,
                                fontWeight: FontWeight.w700),
                          )),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  color: backContainerColor,
                  padding: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                  child: Row(
                    children: [
                      Container(
                        color: btnColor,
                        padding: EdgeInsets.all(3),
                        child: Image.asset(
                          App.budgetIcon,
                          color: Colors.black,
                          height: 15,
                          width: 15,
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: TextStyleRes.textUbuntuStyleFont3(
                            txtColor: txtColor,
                            text: "Total",
                            fontSize: 14,
                            fontWeight: FontWeight.w700),
                      ),
                      TextStyleRes.textUbuntuStyleFont3(
                          txtColor: txtColor,
                          text: "\$",
                          fontSize: 14,
                          fontWeight: FontWeight.w700),
                      SizedBox(
                        width: 15,
                      ),
                      SizedBox(
                          width: 60,
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: TextStyleRes.textUbuntuStyleFont3(
                                txtColor: txtColor,
                                text: "300",
                                fontSize: 14,
                                fontWeight: FontWeight.w700),
                          )),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Center(
                  child: MaterialButton(
                    height: 35.0,
                    elevation: 5,
                    color: btnColor,
                    textColor: Colors.white,
                    child: Text(
                      'Pay Now',
                      textScaleFactor: 1.0,
                    ),
                    onPressed: () {
                      ///PayNow Press
                    },
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  ///job item
  jobItem(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: getDeviceWidth(context) * 0.55,
                    child: TextStyleRes.textUbuntuStyleFont2(
                        text: "Job title",
                        fontSize: 14,
                        fontWeight: FontWeight.w700),
                  ),
                  Spacer(),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 4, horizontal: 16),
                    decoration: BoxDecoration(
                        border: Border.all(color: btnColor, width: 1),
                        color: bgColor),
                    child: TextStyleRes.textUbuntuStyleFont3(
                        txtColor: txtColor,
                        text: "Active",
                        fontSize: 12,
                        fontWeight: FontWeight.w400),
                  ),
                ],
              ),
              TextStyleRes.textUbuntuStyleFont3(
                  txtColor: txtDescriptionColor,
                  text: "Due 21 March, 2021",
                  fontSize: 12,
                  fontWeight: FontWeight.w400),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          InkWell(
            onTap: () {
              ///View more Tap
            },
            child: Row(
              children: [
                TextStyleRes.textUbuntuStyleFont3(
                    text: "View More",
                    txtColor: txtDescriptionColor,
                    fontSize: 14,
                    fontWeight: FontWeight.w600),
                Icon(
                  Icons.expand_more,
                  color: txtDescriptionColor,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
