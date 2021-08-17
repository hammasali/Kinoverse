import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kinoverse/business_logic/bloc/job_bloc/job_bloc.dart';
import 'package:kinoverse/common/TextStyleRes.dart';
import 'package:kinoverse/common/common_widget.dart';
import 'package:kinoverse/page/hire/post_job/post_job_1.dart';
import 'package:kinoverse/page/hire/post_job/preview_job_1.dart';

import '../../../app.dart';

class PostJobPage7 extends StatefulWidget {
  static const String routeName = '/postJob_page7';

  @override
  _PostJobPage7State createState() => _PostJobPage7State();
}

class _PostJobPage7State extends State<PostJobPage7> {
  var languageData = [
    "Any Level",
    "Conversational or better",
    "Fluent or better",
    "Native or billingual only",
    // "Add other languages"
  ];
  var timeData = [
    "I don’t know yet",
    "More than 30 hours a week",
    "Less than 30 hours a week"
  ];
  var isLanguageListEnabled = false;
  var selectedLanguageIndex = 0;
  var languageController = TextEditingController();
  var timeController = TextEditingController();
  var selectedTimeIndex = 0;
  var isTimeListEnabled = false;
  final _key = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    timeController.text = "I don’t know yet";
    languageController.text = "Any Level";
  }

  @override
  void dispose() {
    super.dispose();
    timeController.dispose();
    languageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<JobBloc, JobState>(
      listener: (context, state) {
        if (state is JobSuccessfulState)
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
              isLanguageListEnabled = false;
              isTimeListEnabled = false;
            });
          },
          child: SafeArea(
            child: Container(
              padding: EdgeInsets.all(16),
              child: Form(
                key: _key,
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
                                  "Do you have time time requirement for this project?",
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
                                    isTimeListEnabled = !isTimeListEnabled;
                                    isLanguageListEnabled = false;
                                  });
                                },
                                child: Container(
                                    width: getDeviceWidth(context) * 0.6,
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color: txtDescriptionColor,
                                            width: 1)),
                                    child: IgnorePointer(
                                      child: TextFormField(
                                        cursorColor: txtColor,
                                        controller: timeController,
                                        validator: (value) => value == null
                                            ? 'Field is empty'
                                            : null,
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
                                            hintText: "I don't know yet",
                                            hintStyle: TextStyle(
                                              fontFamily: App.font2,
                                              color: txtDescriptionColor,
                                              fontSize: 12,
                                            )),
                                      ),
                                    )),
                              ),
                              Visibility(
                                  visible: isTimeListEnabled,
                                  child: Container(
                                    width: getDeviceWidth(context) * 0.6,
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
                                        ListView.builder(
                                          shrinkWrap: true,
                                          itemBuilder: (context, index) {
                                            final category = timeData[index];
                                            return JobCheckbox(
                                              checked:
                                                  selectedTimeIndex == index,
                                              title: category,
                                              onChanged: (state) {
                                                setState(() {
                                                  selectedTimeIndex = index;
                                                  timeController.text =
                                                      timeData[index];
                                                  isTimeListEnabled = false;
                                                });
                                              },
                                            );
                                          },
                                          itemCount: timeData.length,
                                        ),
                                      ],
                                    ),
                                  )),
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          TextStyleRes.textUbuntuStyleFont3(
                              text: "English Level",
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
                                    isTimeListEnabled = false;
                                    isLanguageListEnabled =
                                        !isLanguageListEnabled;
                                  });
                                },
                                child: Container(
                                    width: getDeviceWidth(context) * 0.6,
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color: txtDescriptionColor,
                                            width: 1)),
                                    child: IgnorePointer(
                                      child: TextFormField(
                                        cursorColor: txtColor,
                                        controller: languageController,
                                        validator: (value) => value == null
                                            ? 'Field is empty'
                                            : null,
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
                                            hintText: "Any Level",
                                            hintStyle: TextStyle(
                                              fontFamily: App.font2,
                                              color: txtDescriptionColor,
                                              fontSize: 12,
                                            )),
                                      ),
                                    )),
                              ),
                              Visibility(
                                  visible: isLanguageListEnabled,
                                  child: Container(
                                    width: getDeviceWidth(context) * 0.6,
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
                                        ListView.builder(
                                          shrinkWrap: true,
                                          itemBuilder: (context, index) {
                                            final category =
                                                languageData[index];
                                            return JobCheckbox(
                                              checked: selectedLanguageIndex ==
                                                  index,
                                              title: category,
                                              onChanged: (state) {
                                                setState(() {
                                                  selectedLanguageIndex = index;
                                                  languageController.text =
                                                      languageData[index];
                                                  isLanguageListEnabled = false;
                                                });
                                              },
                                            );
                                          },
                                          itemCount: languageData.length,
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
              'Preview Post Job',
              textScaleFactor: 1.0,
            ),
            onPressed: () {
              if (_key.currentState.validate()) {
                BlocProvider.of<JobBloc>(context).add(PreviewPostJob(
                    englishLevel: languageController.text.toString(),
                    timeRequirement: timeController.text.toString()));

                print('${timeController.text} &&& ${languageController.text}');
              }
            },
          ),
        ],
      ),
    );
  }
}
