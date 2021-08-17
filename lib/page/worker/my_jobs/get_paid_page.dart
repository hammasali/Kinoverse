import 'package:flutter/material.dart';
import 'package:kinoverse/app.dart';
import 'package:kinoverse/common/TextStyleRes.dart';
import 'package:kinoverse/common/common_route.dart';
import 'package:kinoverse/common/common_widget.dart';

import 'my_jobs.dart';

class GetPaidPage extends StatelessWidget {
  static const String routeName = '/getPaid_page';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: btnColor,
        title: TextStyleRes.textStyleFont1(
            text: "My Jobs",
            fontSize: 17,
            fontWeight: FontWeight.bold,
            textColor: Colors.white),
      ),
      body: Container(
        color: bgColor,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Material(
              elevation: 10,
              color: bgColor,
              child: Container(
                // decoration: BoxDecoration(
                //   borderRadius: BorderRadius.circular(0.0),
                //   color: bgColor,
                //   boxShadow: [
                //     BoxShadow(
                //       offset: Offset(0.0, 1.0), //(x,y)
                //       blurRadius: 0.2,
                //     ),
                //   ],
                // ),
                padding:
                    const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16),
                child: Column(
                  children: [
                    Row(
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
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TextStyleRes.textUbuntuStyleFont3(
                                txtColor: txtDescriptionColor,
                                text: "Earnings Available",
                                fontSize: 16,
                                fontWeight: FontWeight.w600),
                            SizedBox(
                              height: 5,
                            ),
                            TextStyleRes.textUbuntuStyleFont3(
                                txtColor: txtColor,
                                text: "\$1200",
                                fontSize: 14,
                                fontWeight: FontWeight.w600),
                          ],
                        ),
                        Spacer(),
                        TextStyleRes.textUbuntuStyleFont3(
                            txtColor: txtDescriptionColor,
                            text: "Last 30 Days:\$12.00",
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
                    SizedBox(
                      height: 20,
                    ),
                    JobItem("Work in progress", App.workProgressIcon, "450"),
                    JobItem("In Review", App.reviewIcon, "720"),
                    JobItem("Pending", App.pendingIcon, "150"),
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        InkWell(
                          onTap: () {
                            ///upbotton tap
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                  color: txtDescriptionColor, width: 1),
                            ),
                            child: Icon(
                              Icons.keyboard_arrow_up_outlined,
                              size: 16,
                              color: txtDescriptionColor,
                            ),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            MileStoneCompleteItem(
                "Editing post-production for production house project",
                "May 21",
                "\$450 (Funded)",
                "Active"),
            MileStoneCompleteItem(
                "Editing post-production for production house project",
                "May 21",
                "\$450 (Funded)",
                "Active"),
            MileStoneCompleteItem(
                "Editing post-production for production house project",
                "May 21",
                "\$450 (Funded)",
                "Active"),
          ],
        ),
      ),
    );
  }
}
