import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kinoverse/business_logic/bloc/job_bloc/job_bloc.dart';
import 'package:kinoverse/common/TextStyleRes.dart';
import 'package:kinoverse/common/common_widget.dart';
import 'package:kinoverse/page/hire/post_job/post_job_1.dart';
import 'package:kinoverse/page/hire/post_job/post_job_5.dart';
import 'package:kinoverse/page/hire/post_job/preview_job_1.dart';

import '../../../app.dart';

class PostJobPage4 extends StatefulWidget {
  static const String routeName = '/postJob_page4';
  final bool edit;

  PostJobPage4([this.edit]);

  @override
  _PostJobPage4State createState() => _PostJobPage4State();
}

class _PostJobPage4State extends State<PostJobPage4> {
  var isEntryLevel = true;
  var isIntermediateLevel = false;
  var isExpertLevel = false;

  String freelancer = 'Entry';

  var platformData = ["Mid-Editing", "Post - Editing"];
  var softwareData = ["Adobe Premiere", "Final Cut Pro"];
  List<String> selectPlatformList = [];
  List<String> selectSoftwareList = [];
  var isPlatformListEnabled = false;
  var isSoftwareListEnabled = false;

  var platformController = TextEditingController();
  var softwareController = TextEditingController();

  bool platformControllerVisibility = false,
      softwareControllerVisibility = false;

  @override
  void dispose() {
    super.dispose();
    platformController.dispose();
    softwareController.dispose();
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
              isPlatformListEnabled = false;
              isSoftwareListEnabled = false;
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
                            text:
                                "What level of experience should a freelancer have?",
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
                                    isEntryLevel = true;
                                    isIntermediateLevel = false;
                                    isExpertLevel = false;
                                  });
                                  freelancer = 'Entry';
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
                                              isEntryLevel
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
                                            text: "Entry Level",
                                            fontSize: 12,
                                            fontWeight: FontWeight.w400,
                                            txtColor: txtColor),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        TextStyleRes.textUbuntuStyleFont3(
                                            text:
                                                "Looking for someone relatively new to this field",
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
                                    isEntryLevel = false;
                                    isIntermediateLevel = true;
                                    isExpertLevel = false;
                                  });
                                  freelancer = 'Intermediate';
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
                                              isIntermediateLevel
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
                                            text: "Intermediate",
                                            fontSize: 12,
                                            fontWeight: FontWeight.w400,
                                            txtColor: txtColor),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        TextStyleRes.textUbuntuStyleFont3(
                                            text:
                                                "Looking for substancial experience in this field",
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
                                    isEntryLevel = false;
                                    isIntermediateLevel = false;
                                    isExpertLevel = true;
                                  });
                                  freelancer = 'Expert';
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
                                              isExpertLevel
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
                                            text: "Expert",
                                            fontSize: 12,
                                            fontWeight: FontWeight.w400,
                                            txtColor: txtColor),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        TextStyleRes.textUbuntuStyleFont3(
                                            text:
                                                "Looking for comprehensive & deep expertise to this field",
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
                        //   height: 110,
                        //   child: Row(
                        //     children: [
                        //       InkWell(
                        //         onTap: () {
                        //           setState(() {
                        //             isEntryLevel = true;
                        //             isIntermediateLevel = false;
                        //             isExpertLevel = false;
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
                        //                     isEntryLevel
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
                        //                   text: "Entry Level",
                        //                   fontSize: 12,
                        //                   fontWeight: FontWeight.w400,
                        //                   txtColor: txtColor),
                        //               SizedBox(
                        //                 height: 5,
                        //               ),
                        //               TextStyleRes.textUbuntuStyleFont3(
                        //                   text:
                        //                       "Looking for someone relatively new to this field",
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
                        //             isEntryLevel = false;
                        //             isIntermediateLevel = true;
                        //             isExpertLevel = false;
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
                        //                     isIntermediateLevel
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
                        //                   text: "Intermediate",
                        //                   fontSize: 12,
                        //                   fontWeight: FontWeight.w400,
                        //                   txtColor: txtColor),
                        //               SizedBox(
                        //                 height: 5,
                        //               ),
                        //               TextStyleRes.textUbuntuStyleFont3(
                        //                   text:
                        //                       "Looking for substancial experience in this field",
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
                        //             isEntryLevel = false;
                        //             isIntermediateLevel = false;
                        //             isExpertLevel = true;
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
                        //                     isExpertLevel
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
                        //                   text: "Expert",
                        //                   fontSize: 12,
                        //                   fontWeight: FontWeight.w400,
                        //                   txtColor: txtColor),
                        //               SizedBox(
                        //                 height: 5,
                        //               ),
                        //               TextStyleRes.textUbuntuStyleFont3(
                        //                   text:
                        //                       "Looking for comprehensive & deep expertise to this field",
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
                            text:
                                "What skills & expertise are most important to you in editing?",
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                            txtColor: txtColor),
                        SizedBox(
                          height: 10,
                        ),
                        Visibility(
                          visible: platformControllerVisibility,
                          child: Container(
                              color: backContainerColor,
                              child: TextFormField(
                                cursorColor: txtColor,
                                controller: platformController,
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
                                    hintText: 'Create your own platform...',
                                    hintStyle: TextStyle(
                                      fontFamily: App.font2,
                                      color: btnBorderWhite,
                                      fontSize: 10,
                                    )),
                              )),
                        ),

                        Visibility(
                          visible: !platformControllerVisibility,
                          child: Column(
                            children: [
                              InkWell(
                                onTap: () {
                                  setState(() {
                                    isPlatformListEnabled =
                                        !isPlatformListEnabled;
                                    isSoftwareListEnabled = false;
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
                                            hintText: "Editing Platform",
                                            hintStyle: TextStyle(
                                              fontFamily: App.font2,
                                              color: txtDescriptionColor,
                                              fontSize: 12,
                                            )),
                                      ),
                                    )),
                              ),
                              Visibility(
                                  visible: isPlatformListEnabled,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: bgColor,
                                      boxShadow: [
                                        BoxShadow(
                                          color: backContainerColor
                                              .withOpacity(0.5),
                                          spreadRadius: 5,
                                          blurRadius: 7,
                                          offset: Offset(1,
                                              3), // changes position of shadow
                                        ),
                                      ],
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        InkWell(
                                          onTap: () {
                                            setState(() {
                                              platformControllerVisibility =
                                                  true;
                                            });
                                          },
                                          child: Container(
                                              padding: EdgeInsets.all(8),
                                              color: backContainerColor,
                                              child: Row(
                                                children: [
                                                  TextStyleRes.textUbuntuStyleFont3(
                                                      text:
                                                          "Create your own platform",
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      txtColor: txtColor),
                                                ],
                                              )),
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Center(
                                          child:
                                              TextStyleRes.textUbuntuStyleFont3(
                                                  text: "or",
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w400,
                                                  txtColor: txtColor),
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 8),
                                          child: TextStyleRes.textUbuntuStyleFont3(
                                              text:
                                                  "Select from our suggested platforms",
                                              fontSize: 12,
                                              fontWeight: FontWeight.w700,
                                              txtColor: txtColor),
                                        ),
                                        ListView.builder(
                                          shrinkWrap: true,
                                          itemBuilder: (context, index) {
                                            final category =
                                                platformData[index];
                                            return JobCheckbox(
                                              checked: selectPlatformList
                                                  .contains(category),
                                              title: category,
                                              onChanged: (state) {
                                                if (state) {
                                                  setState(() =>
                                                      selectPlatformList
                                                          .add(category));
                                                } else {
                                                  setState(() =>
                                                      selectPlatformList
                                                          .remove(category));
                                                }
                                              },
                                            );
                                          },
                                          itemCount: platformData.length,
                                        ),
                                      ],
                                    ),
                                  )),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Visibility(
                          visible: softwareControllerVisibility,
                          child: Container(
                              color: backContainerColor,
                              child: TextFormField(
                                cursorColor: txtColor,
                                controller: softwareController,
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
                                    hintText: 'Create your own software...',
                                    hintStyle: TextStyle(
                                      fontFamily: App.font2,
                                      color: btnBorderWhite,
                                      fontSize: 10,
                                    )),
                              )),
                        ),

                        Visibility(
                          visible: !softwareControllerVisibility,
                          child: Column(
                            children: [
                              InkWell(
                                onTap: () {
                                  setState(() {
                                    isSoftwareListEnabled =
                                        !isSoftwareListEnabled;
                                    isPlatformListEnabled = false;
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
                                            hintText: "Editing Software",
                                            hintStyle: TextStyle(
                                              fontFamily: App.font2,
                                              color: txtDescriptionColor,
                                              fontSize: 12,
                                            )),
                                      ),
                                    )),
                              ),
                              Visibility(
                                  visible: isSoftwareListEnabled,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: bgColor,
                                      boxShadow: [
                                        BoxShadow(
                                          color: backContainerColor
                                              .withOpacity(0.5),
                                          spreadRadius: 5,
                                          blurRadius: 7,
                                          offset: Offset(1,
                                              3), // changes position of shadow
                                        ),
                                      ],
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        InkWell(
                                          onTap: () {
                                            setState(() {
                                              softwareControllerVisibility =
                                                  true;
                                            });
                                          },
                                          child: Container(
                                              padding: EdgeInsets.all(8),
                                              color: backContainerColor,
                                              child: Row(
                                                children: [
                                                  TextStyleRes.textUbuntuStyleFont3(
                                                      text:
                                                          "Create your own software",
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      txtColor: txtColor),
                                                ],
                                              )),
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Center(
                                          child:
                                              TextStyleRes.textUbuntuStyleFont3(
                                                  text: "or",
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w400,
                                                  txtColor: txtColor),
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 8),
                                          child: TextStyleRes.textUbuntuStyleFont3(
                                              text:
                                                  "Select from our suggested software",
                                              fontSize: 12,
                                              fontWeight: FontWeight.w700,
                                              txtColor: txtColor),
                                        ),
                                        ListView.builder(
                                          shrinkWrap: true,
                                          itemBuilder: (context, index) {
                                            final category =
                                                softwareData[index];
                                            return JobCheckbox(
                                              checked: selectSoftwareList
                                                  .contains(category),
                                              title: category,
                                              onChanged: (state) {
                                                if (state) {
                                                  setState(() =>
                                                      selectSoftwareList
                                                          .add(category));
                                                } else {
                                                  setState(() =>
                                                      selectSoftwareList
                                                          .remove(category));
                                                }
                                              },
                                            );
                                          },
                                          itemCount: softwareData.length,
                                        ),
                                      ],
                                    ),
                                  )),
                            ],
                          ),
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
              //CommonRoutePage().navigatorPop(context);
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
              //CommonRoutePage().gotoPostJobPage5(context);
              if (platformController.text != null &&
                  platformController.text.isNotEmpty &&
                  !selectPlatformList
                      .contains(platformController.text.toString()))
                selectPlatformList.add(platformController.text.toString());

              if (softwareController.text != null &&
                  softwareController.text.isNotEmpty &&
                  !selectSoftwareList
                      .contains(softwareController.text.toString()))
                selectSoftwareList.add(softwareController.text.toString());

              BlocProvider.of<JobBloc>(context).add(JobScreenEvent4(
                  freelancerType: freelancer,
                  editingPlatform: selectPlatformList,
                  editingSoftware: selectSoftwareList));

              Navigator.of(context).pushNamed(PostJobPage5.routeName);
            },
          ),
        ],
      ),
    );
  }
}
