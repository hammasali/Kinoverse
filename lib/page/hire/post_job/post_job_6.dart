import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kinoverse/business_logic/bloc/job_bloc/job_bloc.dart';
import 'package:kinoverse/common/TextStyleRes.dart';
import 'package:kinoverse/common/common_widget.dart';
import 'package:kinoverse/page/hire/post_job/post_job_1.dart';
import 'package:kinoverse/page/hire/post_job/post_job_7.dart';
import 'package:kinoverse/page/hire/post_job/preview_job_1.dart';

import '../../../app.dart';

class PostJobPage6 extends StatefulWidget {
  static const String routeName = '/postJob_page6';
  final bool edit;

  PostJobPage6([this.edit]);

  @override
  _PostJobPage6State createState() => _PostJobPage6State();
}

class _PostJobPage6State extends State<PostJobPage6> {
  var payByHour = true;
  var durationData = [
    "More than 6 months",
    "3 to 6 months",
    "1 to 3 months",
    "Less than 1 month"
  ];

  var isDurationListEnabled = false;
  var selectedDurationIndex = 0;
  var durationController = TextEditingController();
  var _projectPaymentType = "Hourly Rate";
  final _key = GlobalKey<FormState>();
  String fixedPrice, hourlyRate;
  var start, end;

  @override
  void initState() {
    super.initState();
    durationController.text = "More than 6 months";
  }

  @override
  void dispose() {
    super.dispose();
    durationController.dispose();
  }

  get _hourlyRate => Column(
        children: [
          TextStyleRes.textUbuntuStyleFont3(
              text: "Set your own hourly range",
              fontSize: 12,
              fontWeight: FontWeight.w700,
              txtColor: txtColor),
          SizedBox(
            height: 10,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                padding: EdgeInsets.symmetric(vertical: 4, horizontal: 4),
                width: 100,
                decoration: BoxDecoration(
                    border: Border.all(color: txtDescriptionColor, width: 1)),
                child: Row(
                  children: [
                    TextStyleRes.textUbuntuStyleFont3(
                        text: "\$",
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        txtColor: txtDescriptionColor),
                    Container(
                      width: 80,
                      child: TextFormField(
                        cursorColor: txtColor,
                        validator: (value) =>
                            value.trim().isEmpty || value == null
                                ? 'Field is empty'
                                : null,
                        onSaved: (value) => start = value,
                        autofocus: false,
                        textAlign: TextAlign.end,
                        autocorrect: true,
                        enableSuggestions: true,
                        maxLength: 3,
                        keyboardType: TextInputType.number,
                        style: TextStyle(
                          fontFamily: App.font2,
                          color: txtColor,
                          fontWeight: FontWeight.w700,
                          fontSize: 13,
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
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: 5,
              ),
              TextStyleRes.textUbuntuStyleFont3(
                  text: "/hour",
                  fontSize: 10,
                  fontWeight: FontWeight.w400,
                  txtColor: txtDescriptionColor),
              SizedBox(
                width: 10,
              ),
              TextStyleRes.textUbuntuStyleFont3(
                  text: "to",
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  txtColor: txtDescriptionColor),
              SizedBox(
                width: 5,
              ),
              Container(
                padding: EdgeInsets.symmetric(vertical: 4, horizontal: 4),
                width: 100,
                decoration: BoxDecoration(
                    border: Border.all(color: txtDescriptionColor, width: 1)),
                child: Row(
                  children: [
                    TextStyleRes.textUbuntuStyleFont3(
                        text: "\$",
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        txtColor: txtDescriptionColor),
                    Container(
                      width: 80,
                      child: TextFormField(
                        cursorColor: txtColor,
                        validator: (value) =>
                            value.trim().isEmpty || value == null
                                ? 'Field is empty'
                                : null,
                        onSaved: (value) => end = value,
                        autofocus: false,
                        textAlign: TextAlign.end,
                        autocorrect: true,
                        enableSuggestions: true,
                        maxLength: 3,
                        keyboardType: TextInputType.number,
                        style: TextStyle(
                          fontFamily: App.font2,
                          color: txtColor,
                          fontWeight: FontWeight.w700,
                          fontSize: 13,
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
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: 5,
              ),
              TextStyleRes.textUbuntuStyleFont3(
                  text: "/hour",
                  fontSize: 10,
                  fontWeight: FontWeight.w400,
                  txtColor: txtDescriptionColor),
            ],
          ),
        ],
      );

  get _fixedPriced => Column(
        children: [
          TextStyleRes.textUbuntuStyleFont3(
              text: "Set your own fixed price",
              fontSize: 12,
              fontWeight: FontWeight.w700,
              txtColor: txtColor),
          SizedBox(
            height: 10,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                padding: EdgeInsets.symmetric(vertical: 4, horizontal: 4),
                width: 100,
                decoration: BoxDecoration(
                    border: Border.all(color: txtDescriptionColor, width: 1)),
                child: Row(
                  children: [
                    TextStyleRes.textUbuntuStyleFont3(
                        text: "\$",
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        txtColor: txtDescriptionColor),
                    Container(
                      width: 80,
                      child: TextFormField(
                        cursorColor: txtColor,
                        validator: (value) =>
                            value.trim().isEmpty || value == null
                                ? 'Field is empty'
                                : null,
                        onSaved: (value) => fixedPrice = value,
                        autofocus: false,
                        textAlign: TextAlign.end,
                        autocorrect: true,
                        enableSuggestions: true,
                        maxLength: 3,
                        keyboardType: TextInputType.number,
                        style: TextStyle(
                          fontFamily: App.font2,
                          color: txtColor,
                          fontWeight: FontWeight.w700,
                          fontSize: 13,
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
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: 5,
              ),
              TextStyleRes.textUbuntuStyleFont3(
                  text: "/hour",
                  fontSize: 10,
                  fontWeight: FontWeight.w400,
                  txtColor: txtDescriptionColor),
            ],
          ),
        ],
      );

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
              isDurationListEnabled = false;
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
                          SizedBox(
                            height: 10,
                          ),
                          TextStyleRes.textUbuntuStyleFont3(
                              text: "How will you pay freelancer or agency?",
                              fontSize: 12,
                              fontWeight: FontWeight.w700,
                              txtColor: txtColor),
                          SizedBox(
                            height: 10,
                          ),
                          IntrinsicHeight(
                            // height: 130,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                InkWell(
                                  onTap: () {
                                    setState(() {
                                      payByHour = true;
                                    });
                                    _projectPaymentType = "Hourly Rate";
                                  },
                                  child: Expanded(
                                    child: Container(
                                      width: (getDeviceWidth(context) - 52) / 3,
                                      padding: EdgeInsets.all(8),
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                            color: btnColor, width: 1),
                                      ),
                                      child: Column(
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              Image.asset(
                                                payByHour
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
                                            App.hourlyHourIcon,
                                            height: 16,
                                            width: 16,
                                            color: Colors.white,
                                          ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          TextStyleRes.textUbuntuStyleFont3(
                                              text: "Pay by the hour",
                                              fontSize: 12,
                                              fontWeight: FontWeight.w400,
                                              txtColor: txtColor),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          TextStyleRes.textUbuntuStyleFont3(
                                              text:
                                                  "Pay by hourly to easily scale up & down",
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
                                      payByHour = false;
                                    });
                                    _projectPaymentType = "Fixed Price";
                                  },
                                  child: Expanded(
                                    child: Container(
                                      width: (getDeviceWidth(context) - 52) / 3,
                                      padding: EdgeInsets.all(8),
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                            color: btnColor, width: 1),
                                      ),
                                      child: Column(
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              Image.asset(
                                                !payByHour
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
                                            App.fixPriceIcon,
                                            height: 16,
                                            width: 16,
                                            color: Colors.white,
                                          ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          TextStyleRes.textUbuntuStyleFont3(
                                              text: "Pay a fixed price",
                                              fontSize: 12,
                                              fontWeight: FontWeight.w400,
                                              txtColor: txtColor),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          TextStyleRes.textUbuntuStyleFont3(
                                              text:
                                                  "Define payment before work begins & pay only when work is delivered",
                                              fontSize: 10,
                                              fontWeight: FontWeight.w400,
                                              txtColor: txtDescriptionColor),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          // SizedBox(
                          //   height: 130,
                          //   child: Row(
                          //     children: [
                          //       InkWell(
                          //         onTap: () {
                          //           setState(() {
                          //             payByHour = true;
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
                          //                     payByHour
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
                          //                 App.hourlyHourIcon,
                          //                 height: 16,
                          //                 width: 16,
                          //                 color: Colors.white,
                          //               ),
                          //               SizedBox(
                          //                 height: 5,
                          //               ),
                          //               TextStyleRes.textUbuntuStyleFont3(
                          //                   text: "Pay by the hour",
                          //                   fontSize: 12,
                          //                   fontWeight: FontWeight.w400,
                          //                   txtColor: txtColor),
                          //               SizedBox(
                          //                 height: 5,
                          //               ),
                          //               TextStyleRes.textUbuntuStyleFont3(
                          //                   text:
                          //                       "Pay by hourly to easily scale up & down",
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
                          //             payByHour = false;
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
                          //                     !payByHour
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
                          //                 App.fixPriceIcon,
                          //                 height: 16,
                          //                 width: 16,
                          //                 color: Colors.white,
                          //               ),
                          //               SizedBox(
                          //                 height: 5,
                          //               ),
                          //               TextStyleRes.textUbuntuStyleFont3(
                          //                   text: "Pay a fixed price",
                          //                   fontSize: 12,
                          //                   fontWeight: FontWeight.w400,
                          //                   txtColor: txtColor),
                          //               SizedBox(
                          //                 height: 5,
                          //               ),
                          //               TextStyleRes.textUbuntuStyleFont3(
                          //                   text:
                          //                       "Define payment before work begins & pay only when work is delivered",
                          //                   fontSize: 10,
                          //                   fontWeight: FontWeight.w400,
                          //                   txtColor: txtDescriptionColor),
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
                          payByHour ? _hourlyRate : _fixedPriced,
                          SizedBox(
                            height: 10,
                          ),
                          TextStyleRes.textUbuntuStyleFont3(
                              text:
                                  "How long do you expect this project to last?",
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
                                    isDurationListEnabled =
                                        !isDurationListEnabled;
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
                                        controller: durationController,
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
                                            hintText: "Select Duration",
                                            hintStyle: TextStyle(
                                              fontFamily: App.font2,
                                              color: txtDescriptionColor,
                                              fontSize: 12,
                                            )),
                                      ),
                                    )),
                              ),
                              Visibility(
                                  visible: isDurationListEnabled,
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
                                                durationData[index];
                                            return JobCheckbox(
                                              checked: selectedDurationIndex ==
                                                  index,
                                              title: category,
                                              onChanged: (state) {
                                                setState(() {
                                                  selectedDurationIndex = index;
                                                  durationController.text =
                                                      durationData[index];
                                                  isDurationListEnabled = false;
                                                });
                                              },
                                            );
                                          },
                                          itemCount: durationData.length,
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
              'NEXT',
              textScaleFactor: 1.0,
            ),
            onPressed: () {
              //CommonRoutePage().gotoPostJobPage7(context);
              if (_key.currentState.validate()) {
                _key.currentState.save();
                var projectRate;

                if (payByHour)
                  projectRate = ('$start-$end');
                else
                  projectRate = fixedPrice;

                BlocProvider.of<JobBloc>(context).add(JobScreenEvent6(
                    projectDuration: durationController.text.toString(),
                    projectRate: projectRate,
                    projectPaymentType: _projectPaymentType));

                Navigator.of(context).pushNamed(PostJobPage7.routeName);
              }
            },
          ),
        ],
      ),
    );
  }
}
