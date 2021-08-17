import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kinoverse/business_logic/bloc/job_bloc/job_bloc.dart';
import 'package:kinoverse/common/TextStyleRes.dart';
import 'package:kinoverse/common/common_widget.dart';
import 'package:kinoverse/page/hire/post_job/post_job_1.dart';
import 'package:kinoverse/page/hire/post_job/post_job_4.dart';
import 'package:kinoverse/page/hire/post_job/preview_job_1.dart';

import '../../../app.dart';

class PostJobPage3 extends StatefulWidget {
  static const String routeName = '/postJob_page3';
  final bool edit;

  PostJobPage3([this.edit]);

  @override
  _PostJobPage3State createState() => _PostJobPage3State();
}

class _PostJobPage3State extends State<PostJobPage3> {
  var isOneTimeProject = true;
  var isOnGoingProject = false;
  var isComplexProject = false;
  String projectType = 'One Tme Project';

  final List<String> questionData = [
    "Do you have any question about the job description?",
    "Do you have suggestions to make this project run successfully?",
    "What challenging part of this job are you most experienced in?",
    "What part of this job appeals to you?",
    "What past project or job have you had that is most like this one and why?",
    "What questions do you have about this project?",
    "Which of the required job skills do you feel you are strongest at?",
    "Which part of this project do you think will take the most time?"
  ];
  List<String> selectedData = [];
  var isListEnabled = false;
  var questionController = TextEditingController();
  bool visibility = true, textFieldVisibility = false;
  final key = GlobalKey<FormState>();

  @override
  void dispose() {
    super.dispose();
    questionController.dispose();
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
                            text: "What type of project do you have?",
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                            txtColor: txtColor),
                        SizedBox(
                          height: 10,
                        ),
                        IntrinsicHeight(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              InkWell(
                                onTap: () {
                                  setState(() {
                                    isOneTimeProject = true;
                                    isOnGoingProject = false;
                                    isComplexProject = false;
                                  });
                                  projectType = 'One Tme Project';
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
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            Image.asset(
                                              isOneTimeProject
                                                  ? App.selectedIcon
                                                  : App.unselectedIcon,
                                              height: 14,
                                              width: 14,
                                            ),
                                          ],
                                        ),
                                        Image.asset(
                                          App.oneTimeProjectIcon,
                                          height: 20,
                                          width: 16,
                                          color: Colors.white,
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        TextStyleRes.textUbuntuStyleFont3(
                                            text: "One Time Project",
                                            fontSize: 12,
                                            fontWeight: FontWeight.w400,
                                            txtColor: txtColor),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        TextStyleRes.textUbuntuStyleFont3(
                                            text:
                                                "Find the right skills for a short-term needed",
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
                                    isOneTimeProject = false;
                                    isOnGoingProject = true;
                                    isComplexProject = false;
                                  });
                                  projectType = 'On_Going Project';
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
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            Image.asset(
                                              isOnGoingProject
                                                  ? App.selectedIcon
                                                  : App.unselectedIcon,
                                              height: 14,
                                              width: 14,
                                            ),
                                          ],
                                        ),
                                        Image.asset(
                                          App.ongoingIcon,
                                          height: 20,
                                          width: 16,
                                          color: Colors.white,
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        TextStyleRes.textUbuntuStyleFont3(
                                            text: "On Going Project",
                                            fontSize: 12,
                                            fontWeight: FontWeight.w400,
                                            txtColor: txtColor),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        TextStyleRes.textUbuntuStyleFont3(
                                            text:
                                                "Find skilled resources for an extended engagement",
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
                                    isOneTimeProject = false;
                                    isOnGoingProject = false;
                                    isComplexProject = true;
                                  });
                                  projectType = 'Complex Project';
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
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            Image.asset(
                                              isComplexProject
                                                  ? App.selectedIcon
                                                  : App.unselectedIcon,
                                              height: 14,
                                              width: 14,
                                            ),
                                          ],
                                        ),
                                        Image.asset(
                                          App.complexProjectIcon,
                                          height: 16,
                                          width: 20,
                                          color: Colors.white,
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        TextStyleRes.textUbuntuStyleFont3(
                                            text: "Complex Project",
                                            fontSize: 12,
                                            fontWeight: FontWeight.w400,
                                            txtColor: txtColor),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        TextStyleRes.textUbuntuStyleFont3(
                                            text:
                                                "Find experts and agencies for large projects",
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
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            TextStyleRes.textUbuntuStyleFont3(
                                text: "Screening Questions",
                                fontSize: 12,
                                fontWeight: FontWeight.w700,
                                txtColor: txtColor),
                            SizedBox(
                              width: 10,
                            ),
                            TextStyleRes.textUbuntuStyleFont3(
                                text: "(Optional)",
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                                txtColor: txtDescriptionColor),
                          ],
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        TextStyleRes.textUbuntuStyleFont3(
                            text:
                                "Add screening questions and/or require a cover letter",
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            txtColor: txtColor),
                        SizedBox(
                          height: 10,
                        ),
                        Visibility(
                          visible: textFieldVisibility,
                          child: Container(
                              color: backContainerColor,
                              child: Form(
                                key: key,
                                child: TextFormField(
                                  cursorColor: txtColor,
                                  controller: questionController,
                                  validator: (value) =>
                                      value == null || value?.trim()?.isEmpty
                                          ? 'Field is empty'
                                          : null,
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
                                      hintText: 'Create your own question...',
                                      hintStyle: TextStyle(
                                        fontFamily: App.font2,
                                        color: btnBorderWhite,
                                        fontSize: 10,
                                      )),
                                ),
                              )),
                        ),
                        Visibility(
                          visible: visibility,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              InkWell(
                                onTap: () {
                                  setState(() {
                                    isListEnabled = !isListEnabled;
                                    print("isListEnabled: $isListEnabled");
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
                                            hintText: "Add Questions",
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
                                              visibility = false;
                                              textFieldVisibility = true;
                                            });
                                          },
                                          child: Container(
                                              padding: EdgeInsets.all(8),
                                              color: backContainerColor,
                                              child: Row(
                                                children: [
                                                  TextStyleRes.textUbuntuStyleFont3(
                                                      text:
                                                          "Create your own questions",
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
                                                  "Select from our suggested questions",
                                              fontSize: 12,
                                              fontWeight: FontWeight.w700,
                                              txtColor: txtColor),
                                        ),
                                        ListView.builder(
                                          shrinkWrap: true,
                                          itemBuilder: (context, index) {
                                            final category =
                                                questionData[index];
                                            return JobCheckbox(
                                              checked: selectedData
                                                  .contains(category),
                                              title: category,
                                              onChanged: (state) {
                                                if (state) {
                                                  setState(() => selectedData
                                                      .add(category));
                                                } else {
                                                  setState(() => selectedData
                                                      .remove(category));
                                                }
                                              },
                                            );
                                          },
                                          itemCount: questionData.length,
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
              // CommonRoutePage().gotoPostJobPage4(context);
              if (questionController.text != null &&
                  !selectedData.contains((questionController.text.toString())))
                selectedData.add(questionController.text.toString());

              BlocProvider.of<JobBloc>(context).add(JobScreenEvent3(
                  projectType: projectType, projectQuestion: selectedData));

              Navigator.of(context).pushNamed(PostJobPage4.routeName);
            },
          ),
        ],
      ),
    );
  }
}

// SizedBox(
//   height: 140,
//   child: Row(
//     children: [
//       InkWell(
//         onTap: () {
//           setState(() {
//             isOneTimeProject = true;
//             isOnGoingProject = false;
//             isComplexProject = false;
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
//                 crossAxisAlignment:
//                     CrossAxisAlignment.start,
//                 mainAxisAlignment: MainAxisAlignment.end,
//                 children: [
//                   Image.asset(
//                     isOneTimeProject
//                         ? App.selectedIcon
//                         : App.unselectedIcon,
//                     height: 14,
//                     width: 14,
//                   ),
//                 ],
//               ),
//               Image.asset(
//                 App.oneTimeProjectIcon,
//                 height: 20,
//                 width: 16,
//                 color: Colors.white,
//               ),
//               SizedBox(
//                 height: 5,
//               ),
//               TextStyleRes.textUbuntuStyleFont3(
//                   text: "One Time Project",
//                   fontSize: 12,
//                   fontWeight: FontWeight.w400,
//                   txtColor: txtColor),
//               SizedBox(
//                 height: 5,
//               ),
//               TextStyleRes.textUbuntuStyleFont3(
//                   text:
//                       "Find the right skills for a short-term needed",
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
//             isOneTimeProject = false;
//             isOnGoingProject = true;
//             isComplexProject = false;
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
//                 crossAxisAlignment:
//                     CrossAxisAlignment.start,
//                 mainAxisAlignment: MainAxisAlignment.end,
//                 children: [
//                   Image.asset(
//                     isOnGoingProject
//                         ? App.selectedIcon
//                         : App.unselectedIcon,
//                     height: 14,
//                     width: 14,
//                   ),
//                 ],
//               ),
//               Image.asset(
//                 App.ongoingIcon,
//                 height: 20,
//                 width: 16,
//                 color: Colors.white,
//               ),
//               SizedBox(
//                 height: 5,
//               ),
//               TextStyleRes.textUbuntuStyleFont3(
//                   text: "On Going Project",
//                   fontSize: 12,
//                   fontWeight: FontWeight.w400,
//                   txtColor: txtColor),
//               SizedBox(
//                 height: 5,
//               ),
//               TextStyleRes.textUbuntuStyleFont3(
//                   text:
//                       "Find skilled resources for an extended engagement",
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
//             isOneTimeProject = false;
//             isOnGoingProject = false;
//             isComplexProject = true;
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
//                 crossAxisAlignment:
//                     CrossAxisAlignment.start,
//                 mainAxisAlignment: MainAxisAlignment.end,
//                 children: [
//                   Image.asset(
//                     isComplexProject
//                         ? App.selectedIcon
//                         : App.unselectedIcon,
//                     height: 14,
//                     width: 14,
//                   ),
//                 ],
//               ),
//               Image.asset(
//                 App.complexProjectIcon,
//                 height: 16,
//                 width: 20,
//                 color: Colors.white,
//               ),
//               SizedBox(
//                 height: 5,
//               ),
//               TextStyleRes.textUbuntuStyleFont3(
//                   text: "Complex Project",
//                   fontSize: 12,
//                   fontWeight: FontWeight.w400,
//                   txtColor: txtColor),
//               SizedBox(
//                 height: 5,
//               ),
//               TextStyleRes.textUbuntuStyleFont3(
//                   text:
//                       "Find experts and agencies for large projects",
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
