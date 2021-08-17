import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kinoverse/business_logic/bloc/job_bloc/job_bloc.dart';
import 'package:kinoverse/common/TextStyleRes.dart';
import 'package:kinoverse/common/common_widget.dart';
import 'package:kinoverse/page/hire/post_job/post_job_3.dart';
import 'package:kinoverse/page/hire/post_job/preview_job_1.dart';

import '../../../app.dart';

class PostJobPage2 extends StatefulWidget {
  static const String routeName = '/postJob_page2';
  final bool edit;

  PostJobPage2([this.edit]);

  @override
  _PostJobPage2State createState() => _PostJobPage2State();
}

class _PostJobPage2State extends State<PostJobPage2> {
  String description;
  final key = GlobalKey<FormState>();

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
                      TextStyleRes.textUbuntuStyleFont3(
                          text: "A good description includes",
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                          txtColor: txtColor),
                      SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextStyleRes.textUbuntuStyleFont3(
                          text: "Here are some good examples",
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                          txtColor: txtColor),
                      SizedBox(
                        height: 10,
                      ),
                      TextStyleRes.textUbuntuStyleFont3(
                          text:
                              "- The Production House needs multiple Scriptwriters for multiple titles.",
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          txtColor: txtDescriptionColor),
                      SizedBox(
                        height: 5,
                      ),
                      TextStyleRes.textUbuntuStyleFont3(
                          text:
                              "- Editing some video content for the Youtube channel",
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          txtColor: txtDescriptionColor),
                      SizedBox(
                        height: 5,
                      ),
                      TextStyleRes.textUbuntuStyleFont3(
                          text:
                              "- Requires a video bumper for the Company Profile",
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          txtColor: txtDescriptionColor),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                          color: backContainerColor,
                          child: Form(
                            key: key,
                            child: TextFormField(
                              validator: (value) =>
                                  value?.trim().isEmpty || value == null
                                      ? 'Field is empty'
                                      : null,
                              onSaved: (value) => description = value,
                              cursorColor: txtColor,
                              maxLength: 5000,
                              maxLines: 5,
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
                                  hintText: "",
                                  hintStyle: TextStyle(
                                    fontFamily: App.font2,
                                    color: btnBorderWhite,
                                    fontSize: 10,
                                  )),
                            ),
                          )),
                      SizedBox(
                        height: 10,
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: TextStyleRes.textUbuntuStyleFont3(
                            text: "5000 characters",
                            fontSize: 10,
                            fontWeight: FontWeight.w400,
                            txtColor: txtDescriptionColor),
                      ),
                      SizedBox(
                        height: 10,
                      ),

                      //TODO: ADDITIONAL PROJECT FILES MODULE HERE ====>>>>

                      // TextStyleRes.textUbuntuStyleFont3(
                      //     text: "Additional Project Files",
                      //     fontSize: 12,
                      //     fontWeight: FontWeight.w700,
                      //     txtColor: txtColor),
                      // SizedBox(
                      //   height: 10,
                      // ),
                      // Container(
                      //   width: 200,
                      //   padding:
                      //       EdgeInsets.symmetric(vertical: 8, horizontal: 24),
                      //   decoration: BoxDecoration(
                      //       border:
                      //           Border.all(color: txtDescriptionColor, width: 1)),
                      //   child: Row(
                      //     children: [
                      //       Image.asset(
                      //         App.uploadIcon,
                      //         height: 16,
                      //         width: 16,
                      //         color: txtDescriptionColor,
                      //       ),
                      //       SizedBox(
                      //         width: 10,
                      //       ),
                      //       TextStyleRes.textUbuntuStyleFont3(
                      //           text: "Upload Project Files",
                      //           fontSize: 12,
                      //           fontWeight: FontWeight.w400,
                      //           txtColor: txtDescriptionColor),
                      //     ],
                      //   ),
                      // ),
                      // SizedBox(
                      //   height: 5,
                      // ),
                      // TextStyleRes.textUbuntuStyleFont3(
                      //     text: "You may attach 5 files under 100 MB each",
                      //     fontSize: 10,
                      //     fontWeight: FontWeight.w400,
                      //     txtColor: txtDescriptionColor),
                    ],
                  ),
                )),
                bottomButtons()
              ],
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
              //CommonRoutePage().gotoPostJobPage3(context);
              if (key.currentState.validate()) {
                key.currentState.save();
                BlocProvider.of<JobBloc>(context)
                    .add(JobScreenEvent2(description));
                Navigator.of(context).pushNamed(PostJobPage3.routeName);
              }
            },
          ),
        ],
      ),
    );
  }
}
