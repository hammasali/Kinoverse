import 'package:flutter/material.dart';
import 'package:kinoverse/backend_service/models/job_post_model.dart';
import 'package:kinoverse/common/TextStyleRes.dart';
import 'package:kinoverse/page/hire/post_job/post_job_1.dart';
import 'package:kinoverse/page/hire/post_job/post_job_2.dart';
import 'package:kinoverse/page/hire/post_job/post_job_3.dart';
import 'package:kinoverse/page/hire/post_job/post_job_4.dart';
import 'package:kinoverse/page/hire/post_job/post_job_6.dart';
import 'package:kinoverse/page/hire/post_job/preview_job_2.dart';

import '../../../app.dart';

class PreviewJobPage1 extends StatefulWidget {
  static const String routeName = '/previewJob_page1';
  final Map jobPostModelMapData;

  const PreviewJobPage1([this.jobPostModelMapData]);

  @override
  _PreviewJobPage1State createState() => _PreviewJobPage1State();
}

class _PreviewJobPage1State extends State<PreviewJobPage1> {
  JobPostModel jobPostModel;

  @override
  void initState() {
    super.initState();
    jobPostModel = JobPostModel?.fromMap(widget.jobPostModelMapData);
    print(jobPostModel?.projectQuestion?.isEmpty);
  }

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
                                    text: "Title",
                                    fontSize: 12,
                                    fontWeight: FontWeight.w700,
                                    txtColor: txtDescriptionColor),
                              ),
                              InkWell(
                                onTap: () {
                                  ///edit tap
                                  _navigateAndDisplaySelection(
                                      PostJobPage1.routeName);
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
                              text: jobPostModel?.jobPost,
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              txtColor: txtColor),
                          SizedBox(
                            height: 10,
                          ),
                          TextStyleRes.textUbuntuStyleFont3(
                              text: "Job Category",
                              fontSize: 12,
                              fontWeight: FontWeight.w700,
                              txtColor: txtDescriptionColor),
                          SizedBox(
                            height: 5,
                          ),
                          TextStyleRes.textUbuntuStyleFont3(
                              text: jobPostModel?.categories,
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
                                    text: "Description",
                                    fontSize: 12,
                                    fontWeight: FontWeight.w700,
                                    txtColor: txtDescriptionColor),
                              ),
                              InkWell(
                                onTap: () {
                                  ///edit tap
                                  _navigateAndDisplaySelection(
                                      PostJobPage2.routeName);
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
                              text: jobPostModel?.description,
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
                                    text: "Details",
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
                          TextStyleRes.textUbuntuStyleFont3(
                              text: "Contract",
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              txtColor: txtColor),
                          SizedBox(
                            height: 5,
                          ),
                          TextStyleRes.textUbuntuStyleFont3(
                              text: jobPostModel?.projectDuration,
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
                        children: <Widget>[
                          Row(
                            children: [
                              Expanded(
                                child: TextStyleRes.textUbuntuStyleFont3(
                                    text: "Screening Questions",
                                    fontSize: 12,
                                    fontWeight: FontWeight.w700,
                                    txtColor: txtDescriptionColor),
                              ),
                              InkWell(
                                onTap: () {
                                  ///edit tap
                                  _navigateAndDisplaySelection(
                                      PostJobPage3.routeName);
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
                          jobPostModel?.projectQuestion?.length < 0
                              ? TextStyleRes.textUbuntuStyleFont3(
                                  text: "No Question.",
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                  txtColor: txtColor)
                              : Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: jobPostModel.projectQuestion
                                      .map<Widget>(
                                        (questions) =>
                                            TextStyleRes.textUbuntuStyleFont3(
                                                text: questions,
                                                fontSize: 12,
                                                fontWeight: FontWeight.w400,
                                                txtColor: txtColor),
                                      )
                                      .toList(),
                                ),
                          SizedBox(
                            height: 5,
                          ),
                          TextStyleRes.textUbuntuStyleFont3(
                              text: "Require Cover letter?",
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              txtColor: txtDescriptionColor),
                          SizedBox(
                            height: 5,
                          ),
                          TextStyleRes.textUbuntuStyleFont3(
                              text: "Yes",
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
                                    text: "Expertise",
                                    fontSize: 12,
                                    fontWeight: FontWeight.w700,
                                    txtColor: txtDescriptionColor),
                              ),
                              InkWell(
                                onTap: () {
                                  ///edit tap
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
                              text: "Editing Platforms",
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              txtColor: txtDescriptionColor),
                          SizedBox(
                            height: 5,
                          ),
                          GenerateSkill(jobPostModel?.editingPlatform),
                          SizedBox(
                            height: 10,
                          ),
                          TextStyleRes.textUbuntuStyleFont3(
                              text: "Editing Software",
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              txtColor: txtDescriptionColor),
                          SizedBox(
                            height: 5,
                          ),
                          GenerateSkill(jobPostModel?.editingSoftware),
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
    );
  }

  ///bottomButtons
  bottomButtons() {
    return Container(
      padding: const EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
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
              //CommonRoutePage().gotoPreviewJobPage2(context);
              Navigator.of(context).pushNamed(PreviewJobPage2.routeName,
                  arguments: jobPostModel);
            },
          ),
        ],
      ),
    );
  }

  void _navigateAndDisplaySelection(String routeName) =>
      Navigator.of(context).pushNamed(routeName, arguments: true);

  Widget GenerateSkill(final List<String> tags) => Wrap(
        spacing: 4.0, // gap between adjacent chips
        runSpacing: 4.0, // gap between lines
        children: <Widget>[...generate_tags(tags)],
      );

  ///list
  generate_tags(final List<String> tags) {
    return tags.map<Widget>((tag) => get_chip(tag)).toList();
  }

  get_chip(name) {
    return Theme(
      data: ThemeData(canvasColor: bgColor),
      child: InputChip(
        backgroundColor: bgColor,
        labelStyle: TextStyle(color: Colors.white),
        label: TextStyleRes.textUbuntuStyleFont3(
            txtColor: Colors.white,
            text: "$name",
            fontSize: 15,
            fontWeight: FontWeight.w400),
        shape: RoundedRectangleBorder(
          side: BorderSide(color: btnBorderWhite, width: 1),
          borderRadius: BorderRadius.circular(0),
        ),
      ),
    );
  }
}

// class GenerateSkills extends StatelessWidget {
//   final List<String> tags;
//
//   const GenerateSkills(this.tags);
//
//   @override
//   Widget build(BuildContext context) {
//     return Wrap(
//       spacing: 4.0, // gap between adjacent chips
//       runSpacing: 4.0, // gap between lines
//       children: <Widget>[...generate_tags()],
//     );
//   }
//
//   ///list
//   generate_tags() {
//     return tags.map((tag) => get_chip(tag)).toList();
//   }
//
//   get_chip(name) {
//     return Theme(
//       data: ThemeData(canvasColor: bgColor),
//       child: InputChip(
//         backgroundColor: bgColor,
//         labelStyle: TextStyle(color: Colors.white),
//         label: TextStyleRes.textUbuntuStyleFont3(
//             txtColor: Colors.white,
//             text: "$name",
//             fontSize: 15,
//             fontWeight: FontWeight.w400),
//         shape: RoundedRectangleBorder(
//           side: BorderSide(color: btnBorderWhite, width: 1),
//           borderRadius: BorderRadius.circular(0),
//         ),
//       ),
//     );
//   }
// }
