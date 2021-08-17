import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kinoverse/app.dart';
import 'package:kinoverse/common/TextStyleRes.dart';
import 'package:kinoverse/common/common_route.dart';
import 'package:kinoverse/common/common_widget.dart';
import 'package:kinoverse/page/worker/my_jobs/submit_work_page.dart';

class MyJobs extends StatefulWidget {
  @override
  _MyJobsState createState() => _MyJobsState();
}

class _MyJobsState extends State<MyJobs> {
  final jobsTabs = [
    "Milestones & Earnings",
    "Messages & Files",
    "Terms & Settings",
    "Feedback"
  ];
  int _currentPosition = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: btnColor,
        title: TextStyleRes.textStyleFont1(
            text: "My Jobs",
            fontSize: 14,
            fontWeight: FontWeight.w700,
            textColor: Colors.white),
      ),
      body: Column(
        children: [
          Container(
            height: 56,
            width: double.infinity,
            color: btnColor,
            child: Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Center(
                child: ListView.builder(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  itemBuilder: (context, index) {
                    final item = jobsTabs[index];
                    return InkWell(
                      onTap: () {
                        setState(() {
                          _currentPosition = index;
                        });
                      },
                      child: Container(
                        color: _currentPosition == index ? bgColor : btnColor,
                        padding:
                            EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                        child: Center(
                            child: Text(
                          item,
                          style: TextStyle(
                              color: _currentPosition == index
                                  ? Colors.white
                                  : Colors.grey,
                              fontSize: 12),
                        )),
                      ),
                    );
                  },
                  itemCount: jobsTabs.length,
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                ),
              ),
            ),
          ),
          Expanded(
            child: Container(
              color: bgColor,
              width: getDeviceWidth(context),
              child: IndexedStack(
                index: _currentPosition,
                children: [
                  MileStonesEarnings(),
                  MessagesFiles(),
                  TermsSettings(),
                  Feedback()
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

class MileStonesEarnings extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: bgColor,
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
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextStyleRes.textUbuntuStyleFont3(
                    txtColor: txtDescriptionColor,
                    text: "Last 30 Days:\$0.00",
                    fontSize: 12,
                    fontWeight: FontWeight.w600),
                SizedBox(
                  width: 10,
                ),
                Image.asset(
                  App.calendarIcon,
                  height: 20,
                  width: 20,
                  color: txtDescriptionColor,
                )
              ],
            ),
          ),
          JobItem("Budget", App.budgetIcon, "450"),
          JobItem("In Escrow", App.escrowIcon, "450"),
          JobItem("Milestones Paid", App.milestoneIcon, "450"),
          JobItem("Remaining", App.remainingIcon, "450"),
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
            height: 20,
          ),
          JobItem("Milestones Paid", App.milestoneIcon, "450"),
          Spacer(),
          bottomView(context)
        ],
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
        boxShadow: [
          BoxShadow(
            offset: Offset(0.0, -1.0), //(x,y)
            blurRadius: 0.2,
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: InkWell(
              onTap: () {
                ///Add or edit milestones
              },
              child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: txtDescriptionColor, width: 1),
                  ),
                  height: 35.0,
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    child: CommonWidget.squareButton(
                      text: "Add or Edit Milestones",
                      fontSize: 10.0,
                      textColor: txtDescriptionColor,
                    ),
                  )),
            ),
          ),
          SizedBox(
            width: 5,
          ),
          Expanded(
            child: MaterialButton(
              height: 35.0,
              elevation: 5,
              color: btnColor,
              textColor: Colors.white,
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  'Submit For Payment',
                  textScaleFactor: 1.0,
                ),
              ),
              onPressed: () {
                Navigator.of(context).pushNamed(SubmitWorkPage.routeName);
              },
            ),
          ),
        ],
      ),
    );
  }
}

class MileStoneActiveItem extends StatelessWidget {
  final String number;
  final String title;
  final String description;
  final String date;
  final String status;

  const MileStoneActiveItem(
      this.title, this.date, this.description, this.status, this.number);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 16),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
        decoration: BoxDecoration(
            border: Border.all(color: txtDescriptionColor, width: 1)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextStyleRes.textUbuntuStyleFont3(
                    txtColor: txtColor,
                    text: number,
                    fontSize: 14,
                    fontWeight: FontWeight.w600),
                SizedBox(
                  width: 10,
                ),
                Container(
                  width: getDeviceWidth(context) * 0.5,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextStyleRes.textUbuntuStyleFont3(
                          txtColor: txtColor,
                          text: title,
                          fontSize: 14,
                          fontWeight: FontWeight.w600),
                      SizedBox(
                        height: 5,
                      ),
                      TextStyleRes.textUbuntuStyleFont3(
                          txtColor: txtDescriptionColor,
                          text: description,
                          fontSize: 14,
                          fontWeight: FontWeight.w400),
                    ],
                  ),
                ),
                Spacer(),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    TextStyleRes.textUbuntuStyleFont3(
                        txtColor: txtColor,
                        text: "Due $date",
                        fontSize: 14,
                        fontWeight: FontWeight.w600),
                    SizedBox(
                      height: 5,
                    ),
                    Container(
                      decoration: BoxDecoration(
                          border: Border.all(color: btnColor, width: 1)),
                      padding: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                      child: TextStyleRes.textUbuntuStyleFont3(
                          txtColor: txtColor,
                          text: status,
                          fontSize: 14,
                          fontWeight: FontWeight.w600),
                    ),
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}

class MileStoneCompleteItem extends StatelessWidget {
  final String title;
  final String description;
  final String date;
  final String status;

  const MileStoneCompleteItem(
      this.title, this.date, this.description, this.status);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 16),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
        decoration: BoxDecoration(
            border: Border.all(color: txtDescriptionColor, width: 1)),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: getDeviceWidth(context) * 0.5,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextStyleRes.textUbuntuStyleFont3(
                          txtColor: txtColor,
                          text: title,
                          fontSize: 14,
                          fontWeight: FontWeight.w600),
                      SizedBox(
                        height: 5,
                      ),
                      TextStyleRes.textUbuntuStyleFont3(
                          txtColor: txtDescriptionColor,
                          text: description,
                          fontSize: 14,
                          fontWeight: FontWeight.w400),
                    ],
                  ),
                ),
                Spacer(),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    TextStyleRes.textUbuntuStyleFont3(
                        txtColor: txtColor,
                        text: "Due $date",
                        fontSize: 14,
                        fontWeight: FontWeight.w600),
                    SizedBox(
                      height: 5,
                    ),
                    Container(
                      decoration: BoxDecoration(
                          border: Border.all(color: btnColor, width: 1)),
                      padding: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                      child: TextStyleRes.textUbuntuStyleFont3(
                          txtColor: txtColor,
                          text: status,
                          fontSize: 14,
                          fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
                SizedBox(
                  width: 15,
                ),
                InkWell(
                  onTap: () {
                    ///Details tap
                  },
                  child: TextStyleRes.textUbuntuStyleFont3(
                      txtColor: txtDescriptionColor,
                      text: "Details",
                      fontSize: 12,
                      fontWeight: FontWeight.w300),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class JobItem extends StatelessWidget {
  final String title;
  final String iconName;
  final String price;

  const JobItem(this.title, this.iconName, this.price);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 16),
      child: Container(
        color: backContainerColor,
        padding: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
        child: Row(
          children: [
            Container(
              color: btnColor,
              padding: EdgeInsets.all(3),
              child: Image.asset(
                iconName,
                color: Colors.black,
                height: 15,
                width: 15,
              ),
            ),
            SizedBox(
              width: 10,
            ),
            TextStyleRes.textUbuntuStyleFont3(
                txtColor: txtDescriptionColor,
                text: title,
                fontSize: 14,
                fontWeight: FontWeight.w600),
            Spacer(),
            TextStyleRes.textUbuntuStyleFont3(
                txtColor: txtColor,
                text: "\$$price",
                fontSize: 14,
                fontWeight: FontWeight.w600),
          ],
        ),
      ),
    );
  }
}

class MessagesFiles extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: TextStyleRes.textUbuntuStyleFont2(text: "Messages and Files"),
    );
  }
}

class TermsSettings extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: TextStyleRes.textUbuntuStyleFont2(text: "Terms and Settings"),
    );
  }
}

class Feedback extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: TextStyleRes.textUbuntuStyleFont2(text: "Feedback"),
    );
  }
}
