import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kinoverse/backend_service/models/job_post_model.dart';
import 'package:kinoverse/business_logic/bloc/job_bloc/job_bloc.dart';
import 'package:kinoverse/common/TextStyleRes.dart';
import 'package:kinoverse/common/common_widget.dart';
import 'package:kinoverse/page/hire/home_page/home_page.dart';
import 'package:kinoverse/page/hire/post_job/post_job_4.dart';
import 'package:kinoverse/page/hire/post_job/post_job_5.dart';
import 'package:kinoverse/page/hire/post_job/post_job_6.dart';

import '../../../app.dart';

class PreviewJobPage2 extends StatefulWidget {
  static const String routeName = '/previewJob_page2';
  final JobPostModel jobPostModel;

  const PreviewJobPage2([this.jobPostModel]);

  @override
  _PreviewJobPage2State createState() => _PreviewJobPage2State();
}

class _PreviewJobPage2State extends State<PreviewJobPage2> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      body: SafeArea(
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
                    Container(
                      color: backContainerColor,
                      padding:
                          EdgeInsets.symmetric(vertical: 16, horizontal: 8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: TextStyleRes.textUbuntuStyleFont3(
                                    text: "Experience Level",
                                    fontSize: 12,
                                    fontWeight: FontWeight.w700,
                                    txtColor: txtDescriptionColor),
                              ),
                              InkWell(
                                onTap: () {
                                  _navigateAndDisplaySelection(
                                      PostJobPage4.routeName);
                                },
                                child: Image.asset(
                                  App.edit,
                                  height: 16,
                                  width: 16,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          TextStyleRes.textUbuntuStyleFont3(
                              text: widget.jobPostModel?.freelancerType,
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              txtColor: txtColor),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      color: backContainerColor,
                      padding:
                          EdgeInsets.symmetric(vertical: 16, horizontal: 8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: TextStyleRes.textUbuntuStyleFont3(
                                    text: "Visibility",
                                    fontSize: 12,
                                    fontWeight: FontWeight.w700,
                                    txtColor: txtDescriptionColor),
                              ),
                              InkWell(
                                onTap: () {
                                  ///edit tap
                                  _navigateAndDisplaySelection(
                                      PostJobPage5.routeName);
                                },
                                child: Image.asset(
                                  App.edit,
                                  height: 16,
                                  width: 16,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          TextStyleRes.textUbuntuStyleFont3(
                              text: "Job Posting Visibility",
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              txtColor: txtDescriptionColor),
                          SizedBox(
                            height: 5,
                          ),
                          TextStyleRes.textUbuntuStyleFont3(
                              text: widget.jobPostModel?.jobState,
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              txtColor: txtColor),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      color: backContainerColor,
                      padding:
                          EdgeInsets.symmetric(vertical: 16, horizontal: 8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: TextStyleRes.textUbuntuStyleFont3(
                                    text: "Talent Preference",
                                    fontSize: 12,
                                    fontWeight: FontWeight.w700,
                                    txtColor: txtDescriptionColor),
                              ),
                              InkWell(
                                onTap: () {
                                  ///edit tap
                                  _navigateAndDisplaySelection(
                                      PostJobPage5.routeName);
                                },
                                child: Image.asset(
                                  App.edit,
                                  height: 16,
                                  width: 16,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          TextStyleRes.textUbuntuStyleFont3(
                              text: "Talent Type",
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              txtColor: txtDescriptionColor),
                          SizedBox(
                            height: 5,
                          ),
                          TextStyleRes.textUbuntuStyleFont3(
                              text: widget.jobPostModel?.talentType,
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              txtColor: txtColor),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      color: backContainerColor,
                      padding:
                          EdgeInsets.symmetric(vertical: 16, horizontal: 8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: TextStyleRes.textUbuntuStyleFont3(
                                    text: "Budget",
                                    fontSize: 12,
                                    fontWeight: FontWeight.w700,
                                    txtColor: txtDescriptionColor),
                              ),
                              InkWell(
                                onTap: () {
                                  ///edit tap
                                  _navigateAndDisplaySelection(
                                      PostJobPage6.routeName);
                                },
                                child: Image.asset(
                                  App.edit,
                                  height: 16,
                                  width: 16,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  TextStyleRes.textUbuntuStyleFont3(
                                      text: "Hourly or Fixed Price",
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400,
                                      txtColor: txtDescriptionColor),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  TextStyleRes.textUbuntuStyleFont3(
                                      text: widget
                                          .jobPostModel?.projectPaymentType,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400,
                                      txtColor: txtColor),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  TextStyleRes.textUbuntuStyleFont3(
                                      text: "Project Duration",
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400,
                                      txtColor: txtDescriptionColor),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  TextStyleRes.textUbuntuStyleFont3(
                                      text:
                                          widget.jobPostModel?.projectDuration,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400,
                                      txtColor: txtColor),
                                ],
                              ),
                              Spacer(),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  TextStyleRes.textUbuntuStyleFont3(
                                      text: "Rate",
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400,
                                      txtColor: txtDescriptionColor),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  TextStyleRes.textUbuntuStyleFont3(
                                      text: _getRate(),
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400,
                                      txtColor: txtColor),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  TextStyleRes.textUbuntuStyleFont3(
                                      text: "Time Commitment",
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400,
                                      txtColor: txtDescriptionColor),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  TextStyleRes.textUbuntuStyleFont3(
                                      text:
                                          widget.jobPostModel?.timeRequirement,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400,
                                      txtColor: txtColor),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),

                    //TODO: CO-WORKER MODULE HERE ==========>>>>>>>>>>>

                    // Container(
                    //   color: backContainerColor,
                    //   padding:
                    //       EdgeInsets.symmetric(vertical: 16, horizontal: 8),
                    //   child: Column(
                    //     crossAxisAlignment: CrossAxisAlignment.start,
                    //     children: [
                    //       Row(
                    //         children: [
                    //           Image.asset(
                    //             App.addPeopleIcon,
                    //             height: 16,
                    //             width: 16,
                    //             color: btnColor,
                    //           ),
                    //           SizedBox(
                    //             width: 5,
                    //           ),
                    //           Expanded(
                    //             child: TextStyleRes.textUbuntuStyleFont3(
                    //                 text: "Co-Worker",
                    //                 fontSize: 12,
                    //                 fontWeight: FontWeight.w700,
                    //                 txtColor: txtDescriptionColor),
                    //           ),
                    //           InkWell(
                    //             onTap: () {
                    //               ///edit tap
                    //             },
                    //             child: Image.asset(
                    //               App.edit,
                    //               height: 16,
                    //               width: 16,
                    //               color: Colors.white,
                    //             ),
                    //           ),
                    //         ],
                    //       ),
                    //       SizedBox(
                    //         height: 5,
                    //       ),
                    //       TextStyleRes.textUbuntuStyleFont3(
                    //           text:
                    //               "Let a co-worker help you find, interview & evaluate freelancers & agencies",
                    //           fontSize: 12,
                    //           fontWeight: FontWeight.w400,
                    //           txtColor: txtDescriptionColor),
                    //       SizedBox(
                    //         height: 5,
                    //       ),
                    //       Container(
                    //         width: 150,
                    //         color: btnColor,
                    //         padding: EdgeInsets.symmetric(
                    //             vertical: 8, horizontal: 8),
                    //         child: Row(
                    //           children: [
                    //             InkWell(
                    //               onTap: () {
                    //                 /// add to payment tap
                    //               },
                    //               child: Row(
                    //                 children: [
                    //                   Image.asset(
                    //                     App.addPeopleIcon,
                    //                     color: Colors.white,
                    //                     width: 12,
                    //                     height: 12,
                    //                   ),
                    //                   SizedBox(
                    //                     width: 5,
                    //                   ),
                    //                   TextStyleRes.textUbuntuStyleFont3(
                    //                       txtColor: txtColor,
                    //                       text: "Add Co-Worker",
                    //                       fontSize: 12,
                    //                       fontWeight: FontWeight.w400),
                    //                 ],
                    //               ),
                    //             )
                    //           ],
                    //         ),
                    //       ),
                    //     ],
                    //   ),
                    // ),
                  ],
                ),
              )),
              bottomButtons()
            ],
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

          //  ======================= BLOC =======================
          BlocConsumer<JobBloc, JobState>(
            builder: (context, state) {
              if (state is JobLoadingState)
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: getCircularProgress(context),
                );

              return MaterialButton(
                height: 35.0,
                elevation: 5,
                color: btnColor,
                textColor: Colors.white,
                child: Text(
                  'Post Job Now',
                  textScaleFactor: 1.0,
                ),
                onPressed: () {
                  BlocProvider.of<JobBloc>(context).add(SubmitEvent());
                },
              );
            },
            listener: (context, state) {
              if (state is JobSuccessfulState)
                return Navigator.pushNamedAndRemoveUntil<dynamic>(
                  context,
                  HireHomePage.routeName,
                  (route) =>
                      false, //if you want to disable back feature set to false
                );
              else if (state is JobUnSuccessfulState)
                return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.error,
                              color: Colors.red,
                            ),
                            SizedBox(
                              width: 5.0,
                            ),
                            Expanded(
                              child: Text(
                                state.message,
                                style: TextStyle(color: Colors.red),
                              ),
                            ),
                          ],
                        ))));
            },
          ),
        ],
      ),
    );
  }

  void _navigateAndDisplaySelection(String routeName) =>
      Navigator.of(context).pushNamed(routeName, arguments: true);

  String _getRate() {
    if (widget.jobPostModel?.projectPaymentType == "Fixed Price")
      return '\$${widget.jobPostModel?.projectRate}';

    return '\$${widget.jobPostModel?.projectRate?.split('-')[0]} - \$${widget.jobPostModel?.projectRate?.split('-')[1]}';
  }
}
