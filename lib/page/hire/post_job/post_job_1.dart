import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kinoverse/app.dart';
import 'package:kinoverse/business_logic/bloc/job_bloc/job_bloc.dart';
import 'package:kinoverse/common/TextStyleRes.dart';
import 'package:kinoverse/common/common_widget.dart';
import 'package:kinoverse/core/routes.dart';
import 'package:kinoverse/page/hire/post_job/post_job_2.dart';
import 'package:kinoverse/page/hire/post_job/preview_job_1.dart';

class PostJobPage1 extends StatefulWidget {
  static const String routeName = '/postJob_page1';
  final bool edit;

  PostJobPage1([this.edit]);

  var dataList = [
    "Scriptwriter",
    "Director",
    "Business or Youtube Video",
    "Costume Designer",
    "Editor",
    "Actors",
    "Other"
  ];
  var selectedIndex = 0;
  var isListEnabled = false;
  var jobCategoryText = TextEditingController();
  var jobName = TextEditingController();

  @override
  _PostJobPage1State createState() => _PostJobPage1State();
}

class _PostJobPage1State extends State<PostJobPage1> {
  final key = GlobalKey<FormState>();
  MyAppRoutes _myAppRoutes = MyAppRoutes();

  @override
  void dispose() {
    super.dispose();
    _myAppRoutes.dispose();
    widget.jobCategoryText.dispose();
    widget.jobName.dispose();
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
              widget.isListEnabled = false;
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
                    child: Form(
                      key: key,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextStyleRes.textUbuntuStyleFont3(
                              text: "Enter the name of your job post",
                              fontSize: 12,
                              fontWeight: FontWeight.w700,
                              txtColor: txtColor),
                          SizedBox(
                            height: 5,
                          ),
                          Container(
                              color: backContainerColor,
                              child: TextFormField(
                                cursorColor: txtColor,
                                controller: widget.jobName,
                                validator: (value) =>
                                    value.trim().isEmpty || value == null
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
                                    hintText: "",
                                    hintStyle: TextStyle(
                                      fontFamily: App.font2,
                                      color: btnBorderWhite,
                                      fontSize: 10,
                                    )),
                              )),
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
                          TextStyleRes.textUbuntuStyleFont3(
                              text: "Job Category",
                              fontSize: 12,
                              fontWeight: FontWeight.w700,
                              txtColor: txtColor),
                          SizedBox(
                            height: 5,
                          ),
                          TextStyleRes.textUbuntuStyleFont3(
                              text:
                                  "Let’s categorize your job, which help us personalize your job details and match your job to relevant freelancers and agencies. ",
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              txtColor: txtColor),
                          SizedBox(
                            height: 10,
                          ),
                          TextStyleRes.textUbuntuStyleFont3(
                              text:
                                  " Here are some suggestions based on your job title:",
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              txtColor: txtColor),
                          SizedBox(
                            height: 10,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              InkWell(
                                onTap: () {
                                  print("isVisible: ${widget.isListEnabled}");
                                  // FocusScope.of(context).unfocus();
                                  setState(() {
                                    widget.isListEnabled =
                                        !widget.isListEnabled;
                                    print("isVisible: ${widget.isListEnabled}");
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
                                        controller: widget.jobCategoryText,
                                        validator: (value) => value == null ||
                                                value?.trim()?.isEmpty
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
                                            hintText:
                                                "Select some of the categories provided",
                                            hintStyle: TextStyle(
                                              fontFamily: App.font2,
                                              color: txtDescriptionColor,
                                              fontSize: 12,
                                            )),
                                      ),
                                    )),
                              ),
                              Visibility(
                                  visible: widget.isListEnabled,
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
                                                widget.dataList[index];
                                            return JobCheckbox(
                                              checked:
                                                  widget.selectedIndex == index,
                                              title: category,
                                              onChanged: (state) {
                                                setState(() {
                                                  widget.selectedIndex = index;
                                                  widget.jobCategoryText.text =
                                                      widget.dataList[index];
                                                  widget.isListEnabled = false;
                                                });
                                              },
                                            );
                                          },
                                          itemCount: widget.dataList.length,
                                        ),
                                      ],
                                    ),
                                  )),
                            ],
                          ),
                        ],
                      ),
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
              //CommonRoutePage().gotoPostJobPage2(context);
              if (key.currentState.validate()) {
                BlocProvider.of<JobBloc>(context).add(JobScreen1Event(
                    widget.jobName.text, widget.jobCategoryText.text));

                Navigator.of(context).pushNamed(PostJobPage2.routeName);
              }
            },
          ),
        ],
      ),
    );
  }
}

class JobCheckbox extends StatelessWidget {
  final bool checked;
  final String title;
  final Function(bool) onChanged;

  const JobCheckbox({this.checked, this.title, this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        unselectedWidgetColor: btnColor,
      ),
      child: CheckboxListTile(
        activeColor: btnColor,
        title: TextStyleRes.textUbuntuStyleFont3(
            text: title,
            fontSize: 12,
            fontWeight: FontWeight.w400,
            txtColor: txtColor),
        value: checked,
        onChanged: onChanged,
        controlAffinity:
            ListTileControlAffinity.leading, //  <-- leading Checkbox
      ),
    );
  }
}
