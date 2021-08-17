import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kinoverse/business_logic/bloc/job_bloc/job_bloc.dart';
import 'package:kinoverse/common/TextStyleRes.dart';
import 'package:kinoverse/common/common_widget.dart';
import 'package:kinoverse/page/hire/post_job/post_job_1.dart';
import 'package:kinoverse/page/hire/post_job/post_job_6.dart';
import 'package:kinoverse/page/hire/post_job/preview_job_1.dart';

import '../../../app.dart';

class PostJobPage5 extends StatefulWidget {
  static const String routeName = '/postJob_page5';
  final bool edit;

  PostJobPage5([this.edit]);

  @override
  _PostJobPage5State createState() => _PostJobPage5State();
}

class _PostJobPage5State extends State<PostJobPage5> {
  var isJobAnyone = true;
  var isJobTalent = false;
  var isJobInviteOnly = false;

  var isPersonOne = true;
  var talentData = ["No Preference", "Freelancer", "Agency"];
  var selectedIndex = 0;
  var isListEnabled = false;
  var talentController = TextEditingController();

  String jobState = 'Anyone', freelancerQuantity = "One Freelancer";

  @override
  void initState() {
    super.initState();
    talentController.text = 'No Preference';
  }

  @override
  void dispose() {
    super.dispose();
    talentController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<JobBloc, JobState>(
      listener: (context, state) {

        if (state is JobSuccessfulState && widget.edit == true)
          return Navigator.pushNamedAndRemoveUntil<dynamic>(
              context, PreviewJobPage1.routeName, (route) => false,
              //if you want to disable back feature set to false
              arguments: state.data);
      },
      child: Scaffold(
        backgroundColor: bgColor,
        body: GestureDetector(
          onTap: () {
            setState(() {
              isListEnabled = false;
            });
          },
          child: SafeArea(
            child: Container(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                      child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextStyleRes.textUbuntuStyleFont3(
                            text: "Who can see your job?",
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                            txtColor: txtColor),
                        SizedBox(
                          height: 10,
                        ),
                        IntrinsicHeight(
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              InkWell(
                                onTap: () {
                                  setState(() {
                                    isJobAnyone = true;
                                    isJobTalent = false;
                                    isJobInviteOnly = false;
                                  });
                                  jobState = 'Anyone';
                                },
                                child: Expanded(
                                  child: Container(
                                    width: (getDeviceWidth(context) - 52) / 3,
                                    padding: EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                      border:
                                          Border.all(color: btnColor, width: 1),
                                    ),
                                    child: Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            Image.asset(
                                              isJobAnyone
                                                  ? App.selectedIcon
                                                  : App.unselectedIcon,
                                              height: 14,
                                              width: 14,
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        TextStyleRes.textUbuntuStyleFont3(
                                            text: "Anyone",
                                            fontSize: 12,
                                            fontWeight: FontWeight.w400,
                                            txtColor: txtColor),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        TextStyleRes.textUbuntuStyleFont3(
                                            text:
                                                "Freelancers or Agencies using Kinoverse and public search engine can find this job.",
                                            fontSize: 10,
                                            fontWeight: FontWeight.w400,
                                            txtColor: txtDescriptionColor),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              InkWell(
                                onTap: () {
                                  setState(() {
                                    isJobAnyone = false;
                                    isJobTalent = true;
                                    isJobInviteOnly = false;
                                  });
                                  jobState = 'Only-Kinoverse Talent';
                                },
                                child: Expanded(
                                  child: Container(
                                    width: (getDeviceWidth(context) - 52) / 3,
                                    padding: EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                      border:
                                          Border.all(color: btnColor, width: 1),
                                    ),
                                    child: Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            Image.asset(
                                              isJobTalent
                                                  ? App.selectedIcon
                                                  : App.unselectedIcon,
                                              height: 14,
                                              width: 14,
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        TextStyleRes.textUbuntuStyleFont3(
                                            text: "Only Kinoverse Talent",
                                            fontSize: 12,
                                            fontWeight: FontWeight.w400,
                                            txtColor: txtColor),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        TextStyleRes.textUbuntuStyleFont3(
                                            text:
                                                "Only Kinoverse users can find this job.",
                                            fontSize: 10,
                                            fontWeight: FontWeight.w400,
                                            txtColor: txtDescriptionColor),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              InkWell(
                                onTap: () {
                                  setState(() {
                                    isJobAnyone = false;
                                    isJobTalent = false;
                                    isJobInviteOnly = true;
                                  });
                                  jobState = 'Invite-Only';
                                },
                                child: Expanded(
                                  child: Container(
                                    width: (getDeviceWidth(context) - 52) / 3,
                                    padding: EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                      border:
                                          Border.all(color: btnColor, width: 1),
                                    ),
                                    child: Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            Image.asset(
                                              isJobInviteOnly
                                                  ? App.selectedIcon
                                                  : App.unselectedIcon,
                                              height: 14,
                                              width: 14,
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        TextStyleRes.textUbuntuStyleFont3(
                                            text: "Invite-Only",
                                            fontSize: 12,
                                            fontWeight: FontWeight.w400,
                                            txtColor: txtColor),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        TextStyleRes.textUbuntuStyleFont3(
                                            text:
                                                "Only freelancers or agencies you have invited can find this job.",
                                            fontSize: 10,
                                            fontWeight: FontWeight.w400,
                                            txtColor: txtDescriptionColor),
                                      ],
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        // SizedBox(
                        //   height: 140,
                        //   child: Row(
                        //     children: [
                        //       InkWell(
                        //         onTap: () {
                        //           setState(() {
                        //             isJobAnyone = true;
                        //             isJobTalent = false;
                        //             isJobInviteOnly = false;
                        //           });
                        //         },
                        //         child: Container(
                        //           width: (getDeviceWidth(context) - 52) / 3,
                        //           padding: EdgeInsets.all(8),
                        //           decoration: BoxDecoration(
                        //             border: Border.all(color: btnColor, width: 1),
                        //           ),
                        //           child: Column(
                        //             children: [
                        //               Row(
                        //                 mainAxisAlignment: MainAxisAlignment.end,
                        //                 children: [
                        //                   Image.asset(
                        //                     isJobAnyone
                        //                         ? App.selectedIcon
                        //                         : App.unselectedIcon,
                        //                     height: 14,
                        //                     width: 14,
                        //                   ),
                        //                 ],
                        //               ),
                        //               SizedBox(
                        //                 height: 5,
                        //               ),
                        //               TextStyleRes.textUbuntuStyleFont3(
                        //                   text: "Anyone",
                        //                   fontSize: 12,
                        //                   fontWeight: FontWeight.w400,
                        //                   txtColor: txtColor),
                        //               SizedBox(
                        //                 height: 5,
                        //               ),
                        //               TextStyleRes.textUbuntuStyleFont3(
                        //                   text:
                        //                       "Freelancers or Agencies using Kinoverse and public search engine can find this job.",
                        //                   fontSize: 10,
                        //                   fontWeight: FontWeight.w400,
                        //                   txtColor: txtDescriptionColor),
                        //             ],
                        //           ),
                        //         ),
                        //       ),
                        //       SizedBox(
                        //         width: 10,
                        //       ),
                        //       InkWell(
                        //         onTap: () {
                        //           setState(() {
                        //             isJobAnyone = false;
                        //             isJobTalent = true;
                        //             isJobInviteOnly = false;
                        //           });
                        //         },
                        //         child: Container(
                        //           width: (getDeviceWidth(context) - 52) / 3,
                        //           padding: EdgeInsets.all(8),
                        //           decoration: BoxDecoration(
                        //             border: Border.all(color: btnColor, width: 1),
                        //           ),
                        //           child: Column(
                        //             children: [
                        //               Row(
                        //                 mainAxisAlignment: MainAxisAlignment.end,
                        //                 children: [
                        //                   Image.asset(
                        //                     isJobTalent
                        //                         ? App.selectedIcon
                        //                         : App.unselectedIcon,
                        //                     height: 14,
                        //                     width: 14,
                        //                   ),
                        //                 ],
                        //               ),
                        //               SizedBox(
                        //                 height: 5,
                        //               ),
                        //               TextStyleRes.textUbuntuStyleFont3(
                        //                   text: "Only Kinoverse Talent",
                        //                   fontSize: 12,
                        //                   fontWeight: FontWeight.w400,
                        //                   txtColor: txtColor),
                        //               SizedBox(
                        //                 height: 5,
                        //               ),
                        //               TextStyleRes.textUbuntuStyleFont3(
                        //                   text:
                        //                       "Only Kinoverse users can find this job.",
                        //                   fontSize: 10,
                        //                   fontWeight: FontWeight.w400,
                        //                   txtColor: txtDescriptionColor),
                        //             ],
                        //           ),
                        //         ),
                        //       ),
                        //       SizedBox(
                        //         width: 10,
                        //       ),
                        //       InkWell(
                        //         onTap: () {
                        //           setState(() {
                        //             isJobAnyone = false;
                        //             isJobTalent = false;
                        //             isJobInviteOnly = true;
                        //           });
                        //         },
                        //         child: Container(
                        //           width: (getDeviceWidth(context) - 52) / 3,
                        //           padding: EdgeInsets.all(8),
                        //           decoration: BoxDecoration(
                        //             border: Border.all(color: btnColor, width: 1),
                        //           ),
                        //           child: Column(
                        //             children: [
                        //               Row(
                        //                 mainAxisAlignment: MainAxisAlignment.end,
                        //                 children: [
                        //                   Image.asset(
                        //                     isJobInviteOnly
                        //                         ? App.selectedIcon
                        //                         : App.unselectedIcon,
                        //                     height: 14,
                        //                     width: 14,
                        //                   ),
                        //                 ],
                        //               ),
                        //               SizedBox(
                        //                 height: 5,
                        //               ),
                        //               TextStyleRes.textUbuntuStyleFont3(
                        //                   text: "Invite-Only",
                        //                   fontSize: 12,
                        //                   fontWeight: FontWeight.w400,
                        //                   txtColor: txtColor),
                        //               SizedBox(
                        //                 height: 5,
                        //               ),
                        //               TextStyleRes.textUbuntuStyleFont3(
                        //                   text:
                        //                       "Only freelancers or agencies you have invited can find this job.",
                        //                   fontSize: 10,
                        //                   fontWeight: FontWeight.w400,
                        //                   txtColor: txtDescriptionColor),
                        //             ],
                        //           ),
                        //         ),
                        //       )
                        //     ],
                        //   ),
                        // ),
                        SizedBox(
                          height: 10,
                        ),
                        TextStyleRes.textUbuntuStyleFont3(
                            text: "How many people do you need for this job?",
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                            txtColor: txtColor),
                        SizedBox(
                          height: 10,
                        ),
                        IntrinsicHeight(
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              InkWell(
                                onTap: () {
                                  setState(() {
                                    isPersonOne = true;
                                  });
                                  freelancerQuantity = "One Freelancer";
                                },
                                child: Expanded(
                                  child: Container(
                                    width: (getDeviceWidth(context) - 52) / 3,
                                    padding: EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                      border:
                                          Border.all(color: btnColor, width: 1),
                                    ),
                                    child: Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            Image.asset(
                                              isPersonOne
                                                  ? App.selectedIcon
                                                  : App.unselectedIcon,
                                              height: 14,
                                              width: 14,
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Image.asset(
                                          App.freelancerIcon,
                                          height: 16,
                                          width: 16,
                                          color: Colors.white,
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        TextStyleRes.textUbuntuStyleFont3(
                                            text: "One Freelancer",
                                            fontSize: 12,
                                            fontWeight: FontWeight.w400,
                                            txtColor: txtColor),
                                        SizedBox(
                                          height: 5,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              InkWell(
                                onTap: () {
                                  setState(() {
                                    isPersonOne = false;
                                  });
                                  freelancerQuantity = "More than one";
                                },
                                child: Expanded(
                                  child: Container(
                                    width: (getDeviceWidth(context) - 52) / 3,
                                    padding: EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                      border:
                                          Border.all(color: btnColor, width: 1),
                                    ),
                                    child: Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            Image.asset(
                                              !isPersonOne
                                                  ? App.selectedIcon
                                                  : App.unselectedIcon,
                                              height: 14,
                                              width: 14,
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Image.asset(
                                          App.moreFreelancerIcon,
                                          height: 16,
                                          width: 16,
                                          color: Colors.white,
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        TextStyleRes.textUbuntuStyleFont3(
                                            text: "More than one freelancer",
                                            fontSize: 12,
                                            fontWeight: FontWeight.w400,
                                            txtColor: txtColor),
                                        SizedBox(
                                          height: 5,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        // SizedBox(
                        //   height: 110,
                        //   child: Row(
                        //     children: [
                        //       InkWell(
                        //         onTap: () {
                        //           setState(() {
                        //             isPersonOne = true;
                        //           });
                        //         },
                        //         child: Container(
                        //           width: (getDeviceWidth(context) - 52) / 3,
                        //           padding: EdgeInsets.all(8),
                        //           decoration: BoxDecoration(
                        //             border: Border.all(color: btnColor, width: 1),
                        //           ),
                        //           child: Column(
                        //             children: [
                        //               Row(
                        //                 mainAxisAlignment: MainAxisAlignment.end,
                        //                 children: [
                        //                   Image.asset(
                        //                     isPersonOne
                        //                         ? App.selectedIcon
                        //                         : App.unselectedIcon,
                        //                     height: 14,
                        //                     width: 14,
                        //                   ),
                        //                 ],
                        //               ),
                        //               SizedBox(
                        //                 height: 5,
                        //               ),
                        //               Image.asset(
                        //                 App.freelancerIcon,
                        //                 height: 16,
                        //                 width: 16,
                        //                 color: Colors.white,
                        //               ),
                        //               SizedBox(
                        //                 height: 5,
                        //               ),
                        //               TextStyleRes.textUbuntuStyleFont3(
                        //                   text: "One Freelancer",
                        //                   fontSize: 12,
                        //                   fontWeight: FontWeight.w400,
                        //                   txtColor: txtColor),
                        //               SizedBox(
                        //                 height: 5,
                        //               ),
                        //             ],
                        //           ),
                        //         ),
                        //       ),
                        //       SizedBox(
                        //         width: 10,
                        //       ),
                        //       InkWell(
                        //         onTap: () {
                        //           setState(() {
                        //             isPersonOne = false;
                        //           });
                        //         },
                        //         child: Container(
                        //           width: (getDeviceWidth(context) - 52) / 3,
                        //           padding: EdgeInsets.all(8),
                        //           decoration: BoxDecoration(
                        //             border: Border.all(color: btnColor, width: 1),
                        //           ),
                        //           child: Column(
                        //             children: [
                        //               Row(
                        //                 mainAxisAlignment: MainAxisAlignment.end,
                        //                 children: [
                        //                   Image.asset(
                        //                     !isPersonOne
                        //                         ? App.selectedIcon
                        //                         : App.unselectedIcon,
                        //                     height: 14,
                        //                     width: 14,
                        //                   ),
                        //                 ],
                        //               ),
                        //               SizedBox(
                        //                 height: 5,
                        //               ),
                        //               Image.asset(
                        //                 App.moreFreelancerIcon,
                        //                 height: 16,
                        //                 width: 16,
                        //                 color: Colors.white,
                        //               ),
                        //               SizedBox(
                        //                 height: 5,
                        //               ),
                        //               TextStyleRes.textUbuntuStyleFont3(
                        //                   text: "More than one freelancer",
                        //                   fontSize: 12,
                        //                   fontWeight: FontWeight.w400,
                        //                   txtColor: txtColor),
                        //               SizedBox(
                        //                 height: 5,
                        //               ),
                        //             ],
                        //           ),
                        //         ),
                        //       ),
                        //     ],
                        //   ),
                        // ),
                        SizedBox(
                          height: 10,
                        ),
                        TextStyleRes.textUbuntuStyleFont3(
                            text: "Talent Type",
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                            txtColor: txtColor),
                        SizedBox(
                          height: 10,
                        ),
                        Column(
                          children: [
                            InkWell(
                              onTap: () {
                                setState(() {
                                  isListEnabled = !isListEnabled;
                                });
                              },
                              child: Container(
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          color: txtDescriptionColor,
                                          width: 1)),
                                  child: IgnorePointer(
                                    child: TextFormField(
                                      cursorColor: txtColor,
                                      controller: talentController,
                                      readOnly: true,
                                      style: TextStyle(
                                        fontFamily: App.font2,
                                        color: txtColor,
                                        fontSize: 12,
                                      ),
                                      decoration: new InputDecoration(
                                          isDense: true,
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
                                          hintText: "No Preference",
                                          hintStyle: TextStyle(
                                            fontFamily: App.font2,
                                            color: txtDescriptionColor,
                                            fontSize: 12,
                                          )),
                                    ),
                                  )),
                            ),
                            Visibility(
                                visible: isListEnabled,
                                child: Container(
                                  width: getDeviceWidth(context) * 0.6,
                                  decoration: BoxDecoration(
                                    color: bgColor,
                                    boxShadow: [
                                      BoxShadow(
                                        color:
                                            backContainerColor.withOpacity(0.5),
                                        spreadRadius: 5,
                                        blurRadius: 7,
                                        offset: Offset(
                                            1, 3), // changes position of shadow
                                      ),
                                    ],
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      ListView.builder(
                                        shrinkWrap: true,
                                        itemBuilder: (context, index) {
                                          final category = talentData[index];
                                          return JobCheckbox(
                                            checked: selectedIndex == index,
                                            title: category,
                                            onChanged: (state) {
                                              setState(() {
                                                selectedIndex = index;
                                                talentController.text =
                                                    talentData[index];
                                                isListEnabled = false;
                                              });
                                            },
                                          );
                                        },
                                        itemCount: talentData.length,
                                      ),
                                    ],
                                  ),
                                )),
                          ],
                        ),
                      ],
                    ),
                  )),
                  bottomButtons()
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  ///bottomButtons
  bottomButtons() {
    return Container(
      padding: const EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: btnColor, width: 1),
              ),
              height: 35.0,
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: CommonWidget.squareButton(
                text: "BACK",
                fontSize: 12.0,
                textColor: Colors.white,
              ),
            ),
          ),
          MaterialButton(
            height: 35.0,
            elevation: 5,
            color: btnColor,
            textColor: Colors.white,
            child: Text(
              'NEXT',
              textScaleFactor: 1.0,
            ),
            onPressed: () {
              // CommonRoutePage().gotoPostJobPage6(context);
              BlocProvider.of<JobBloc>(context).add(JobScreenEvent5(
                  jobState: jobState,
                  freelancerQuantity: freelancerQuantity,
                  talentType: talentController.text.toString()));

              Navigator.of(context).pushNamed(PostJobPage6.routeName);
            },
          ),
        ],
      ),
    );
  }
}
