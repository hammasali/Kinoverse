import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kinoverse/app.dart';
import 'package:kinoverse/business_logic/bloc/fields/fields_bloc.dart';
import 'package:kinoverse/common/TextStyleRes.dart';
import 'package:kinoverse/common/common_widget.dart';
import 'package:kinoverse/core/routes.dart';
import 'package:kinoverse/model/education_model.dart';
import 'package:kinoverse/page/worker/employment/employment_page.dart';
import 'package:kinoverse/page/worker/profile_overview/profile_overview_page.dart';

class EducationPage extends StatefulWidget {
  static const String routeName = '/education_page';
  final bool edit;

  EducationPage([this.edit]);

  @override
  _EducationPageState createState() => _EducationPageState();
}

class _EducationPageState extends State<EducationPage> {
  bool containerVisibility = false;
  final key = GlobalKey<FormState>();
  MyAppRoutes _myAppRoutes = MyAppRoutes();

  var schoolController = TextEditingController();
  var areaOfStudyController = TextEditingController();
  var degreeController = TextEditingController();
  var fromDateController = TextEditingController();
  var toDateController = TextEditingController();
  var descriptionController = TextEditingController();
  List<Map<String, dynamic>> userMapData = [];

  var isAddEducation = false;

  @override
  void dispose() {
    super.dispose();
    schoolController.dispose();
    areaOfStudyController.dispose();
    degreeController.dispose();
    fromDateController.dispose();
    toDateController.dispose();
    _myAppRoutes.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print("runtimeType -> " + runtimeType.toString());
    return Scaffold(
      backgroundColor: bgColor,
      body: Container(
        padding: EdgeInsets.only(top: 60),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[gettingStartBtn(), myEducation()],
                ),
              ),
            ),

            //============================ BLOC ===============================
            BlocConsumer<FieldsBloc, FieldsState>(
                bloc: BlocProvider.of<FieldsBloc>(context),
                builder: (context, state) {
                  if (state is FieldsInitial) {
                    return Container();
                  } else if (state is FieldLoadingState) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: getCircularProgress(context),
                    );
                  } else if (state is FieldSuccessfulState) {
                    return Container();
                  } else if (state is FieldUnsuccessfulState) {
                    return Padding(
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
                                child: TextStyleRes.textStyleFont1(
                                    textColor: Colors.red,
                                    text: state.message,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w700)),
                          ],
                        ));
                  }
                  return Container();
                },
                listener: (context, state) {
                  if (state is FieldSuccessfulState && widget?.edit == true)
                    return Navigator.of(context).pushNamedAndRemoveUntil(
                        ProfileOverviewPage.routeName, (route) => false,
                        arguments: state.data);
                }),

            bottomButtons()
          ],
        ),
      ),
    );
  }

  ///gettingStartBtn
  gettingStartBtn() {
    return Center(
      child: Container(
        margin: EdgeInsets.all(5),
        height: 50.0,
        width: MediaQuery.of(context).size.width / 1.7,
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(width: 5.0, color: btnColor),
          ),
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: bgColor,
              blurRadius: 3,
              offset: Offset(1, 3),
            ),
          ],
        ),
        child: RaisedButton(
          elevation: 25,
          onPressed: () {},
          padding: EdgeInsets.all(10.0),
          color: bgColor,
          textColor: Colors.white,
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Image.asset(
                  App.educationIcon,
                  color: txtColor,
                  height: 20,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 12),
                child: Text("Education",
                    style:
                        TextStyle(fontSize: 15, fontWeight: FontWeight.w400)),
              ),
            ],
          ),
        ),
      ),
    );
  }

  ///education
  myEducation() {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20, top: 55),
      child: Container(
        padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
        color: backContainerColor,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextStyleRes.textStyleFont1(
                textColor: txtColor,
                text:
                    "Add the schools you attended, areas of study, and degrees earned.",
                fontSize: 12,
                fontWeight: FontWeight.w700),
            SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.only(
                      left: 10, right: 10, top: 5, bottom: 5),
                  decoration: BoxDecoration(
                    border: Border.all(color: btnColor, width: 1),
                  ),
                  child: TextStyleRes.textUbuntuStyleFont2(
                      text: "Add Education",
                      fontSize: 10,
                      fontWeight: FontWeight.w400),
                ),
                SizedBox(
                  width: 10,
                ),
                Visibility(
                  visible: !isAddEducation,
                  child: MaterialButton(
                    height: 25.0,
                    minWidth: 25.0,
                    color: btnColor,
                    textColor: Colors.white,
                    child: Icon(
                      Icons.add,
                      size: 16,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      setState(() {});
                      isAddEducation = true;
                    },
                  ),
                ),
                Visibility(
                  visible: isAddEducation,
                  child: MaterialButton(
                    height: 25.0,
                    minWidth: 25.0,
                    color: btnBorderWhite,
                    child: Icon(
                      Icons.remove,
                      size: 16,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      setState(() {
                        isAddEducation = false;
                      });
                    },
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Visibility(
              visible: containerVisibility,
              child: educationItem(),
            ),
            Visibility(
              visible: isAddEducation,
              child: addEducation(),
            ),
            widget.edit != true
                ? Visibility(
                    visible: !isAddEducation,
                    child: MaterialButton(
                      height: 35.0,
                      textColor: btnColor,
                      child: Text(
                        'skip this step',
                        textScaleFactor: 1.0,
                      ),
                      onPressed: () {
                        // CommonRoutePage().gotoEmploymentPage(context);
                        Navigator.of(context)
                            .pushNamed(EmploymentPage.routeName);
                      },
                    ),
                  )
                : Container(),
            SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }

  ///addEducation
  addEducation() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 10,
        ),
        TextStyleRes.textUbuntuStyleFont2(
            text: "School", fontSize: 10, fontWeight: FontWeight.w700),
        SizedBox(
          height: 5,
        ),
        Container(
            decoration: BoxDecoration(
              border: Border.all(color: btnBorderWhite, width: 1),
            ),
            child: Form(
              key: key,
              child: TextFormField(
                cursorColor: txtColor,
                controller: schoolController,
                validator: (value) => value.trim().isEmpty || value == null
                    ? 'Field is empty'
                    : null,
                style: TextStyle(
                    fontFamily: App.font2,
                    color: txtColor,
                    fontSize: 10,
                    fontWeight: FontWeight.w400),
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
                    hintText: "Ex: Columbia College Chicago",
                    hintStyle: TextStyle(
                        fontFamily: App.font2,
                        color: txtDescriptionColor,
                        fontSize: 10,
                        fontWeight: FontWeight.w400)),
              ),
            )),
        SizedBox(
          height: 10,
        ),
        TextStyleRes.textUbuntuStyleFont2(
            text: "Area of Study (Optional)",
            fontSize: 10,
            fontWeight: FontWeight.w700),
        SizedBox(
          height: 5,
        ),
        Container(
            decoration: BoxDecoration(
              border: Border.all(color: btnBorderWhite, width: 1),
            ),
            child: TextFormField(
              cursorColor: txtColor,
              controller: areaOfStudyController,
              style: TextStyle(
                  fontFamily: App.font2,
                  color: txtColor,
                  fontSize: 10,
                  fontWeight: FontWeight.w400),
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
                  hintText: "Ex: Film and Television",
                  hintStyle: TextStyle(
                      fontFamily: App.font2,
                      color: txtDescriptionColor,
                      fontSize: 10,
                      fontWeight: FontWeight.w400)),
            )),
        SizedBox(
          height: 10,
        ),
        TextStyleRes.textUbuntuStyleFont2(
            text: "Degree (Optional)",
            fontSize: 10,
            fontWeight: FontWeight.w700),
        SizedBox(
          height: 5,
        ),
        Container(
            decoration: BoxDecoration(
              border: Border.all(color: btnBorderWhite, width: 1),
            ),
            child: TextFormField(
              cursorColor: txtColor,
              controller: degreeController,
              style: TextStyle(
                  fontFamily: App.font2,
                  color: txtColor,
                  fontSize: 10,
                  fontWeight: FontWeight.w400),
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
                  hintText: "Ex: Bachelor of Arts",
                  hintStyle: TextStyle(
                      fontFamily: App.font2,
                      color: txtDescriptionColor,
                      fontSize: 10,
                      fontWeight: FontWeight.w400)),
            )),
        SizedBox(
          height: 10,
        ),
        TextStyleRes.textUbuntuStyleFont2(
            text: "Dates Attended (Optional)",
            fontSize: 10,
            fontWeight: FontWeight.w700),
        SizedBox(
          height: 5,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Expanded(
              child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: btnBorderWhite, width: 1),
                  ),
                  child: TextFormField(
                    cursorColor: txtColor,
                    controller: fromDateController,
                    keyboardType: TextInputType.number,
                    style: TextStyle(
                        fontFamily: App.font2,
                        color: txtColor,
                        fontSize: 10,
                        fontWeight: FontWeight.w400),
                    decoration: new InputDecoration(
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
                        hintText: "From",
                        hintStyle: TextStyle(
                            fontFamily: App.font2,
                            color: txtDescriptionColor,
                            fontSize: 10,
                            fontWeight: FontWeight.w400)),
                  )),
            ),
            SizedBox(
              width: 10,
            ),
            Expanded(
              child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: btnBorderWhite, width: 1),
                  ),
                  child: TextFormField(
                    cursorColor: txtColor,
                    controller: toDateController,
                    keyboardType: TextInputType.number,
                    style: TextStyle(
                        fontFamily: App.font2,
                        color: txtColor,
                        fontSize: 10,
                        fontWeight: FontWeight.w400),
                    decoration: new InputDecoration(
                        border: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        errorBorder: InputBorder.none,
                        disabledBorder: InputBorder.none,
                        hintMaxLines: 3,
                        contentPadding: EdgeInsets.only(
                          left: 10,
                          bottom: 10,
                          top: 10,
                        ),
                        hintText: "To (or expected graduation year)",
                        hintStyle: TextStyle(
                            fontFamily: App.font2,
                            color: txtDescriptionColor,
                            fontSize: 10,
                            fontWeight: FontWeight.w400)),
                  )),
            ),
          ],
        ),
        SizedBox(
          height: 10,
        ),
        TextStyleRes.textUbuntuStyleFont2(
            text: "Description (Optional)",
            fontSize: 10,
            fontWeight: FontWeight.w700),
        SizedBox(
          height: 5,
        ),
        Container(
            decoration: BoxDecoration(
              border: Border.all(color: btnBorderWhite, width: 1),
            ),
            child: TextFormField(
              cursorColor: txtColor,
              controller: descriptionController,
              style: TextStyle(
                  fontFamily: App.font2,
                  color: txtColor,
                  fontSize: 10,
                  fontWeight: FontWeight.w400),
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
                  hintText: "Describe your studies, awards, etc.",
                  hintStyle: TextStyle(
                      fontFamily: App.font2,
                      color: txtDescriptionColor,
                      fontSize: 10,
                      fontWeight: FontWeight.w400)),
            )),
      ],
    );
  }

  ///educationItem
  educationItem() {
    return ListView.separated(
      itemCount: userMapData?.length,
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              flex: 5,
              child: Container(
                // width: 250,
                decoration: BoxDecoration(
                  border: Border.all(color: btnColor, width: 1),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextStyleRes.textUbuntuStyleFont2(
                          text: userMapData[index]['school'],
                          fontSize: 10,
                          fontWeight: FontWeight.w700),
                      SizedBox(
                        height: 5,
                      ),
                      Row(
                        children: [
                          TextStyleRes.textUbuntuStyleFont2(
                              text:
                                  userMapData[index]['startDate'].toString() !=
                                          ''
                                      ? userMapData[index]['startDate']
                                      : '',
                              fontSize: 10,
                              fontWeight: FontWeight.w400),
                          TextStyleRes.textUbuntuStyleFont2(
                              text:
                                  userMapData[index]['endDate'].toString() != ''
                                      ? ' - ${userMapData[index]['endDate']}'
                                      : '',
                              fontSize: 10,
                              fontWeight: FontWeight.w400),
                        ],
                      ),
                      SizedBox(
                        height: 3,
                      ),
                      Wrap(
                        children: [
                          TextStyleRes.textUbuntuStyleFont2(
                              text:
                                  userMapData[index]['degree'].toString() != ''
                                      ? userMapData[index]['degree']
                                      : '',
                              fontSize: 10,
                              fontWeight: FontWeight.w400),
                          TextStyleRes.textUbuntuStyleFont2(
                              text: userMapData[index]['areaOfStudy']
                                          .toString() !=
                                      ''
                                  ? ' of ${userMapData[index]['areaOfStudy']}'
                                  : '',
                              fontSize: 10,
                              fontWeight: FontWeight.w400),
                        ],
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      TextStyleRes.textUbuntuStyleFont2(
                          text: userMapData[index]['description'],
                          fontSize: 10,
                          fontWeight: FontWeight.w400),
                      // TextStyleRes.textUbuntuStyleFont2(
                      //     text: "Bachelor of Arts (BA) of Film and Television",
                      //     fontSize: 10,
                      //     fontWeight: FontWeight.w400),
                    ],
                  ),
                ),
              ),
            ),
            Spacer(),
            Expanded(
              flex: 1,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () {
                      ///edit
                      performEditEvent(index);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: btnColor, width: 1),
                      ),
                      height: 25.0,
                      padding: const EdgeInsets.only(left: 5, right: 5),
                      child: Icon(
                        Icons.edit,
                        size: 16,
                        color: btnBorderWhite,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  InkWell(
                    onTap: () {
                      ///delete
                      setState(() {
                        userMapData.removeAt(index);
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: btnColor, width: 1),
                      ),
                      height: 25.0,
                      padding: const EdgeInsets.only(left: 5, right: 5),
                      child: Icon(
                        Icons.delete,
                        size: 16,
                        color: btnBorderWhite,
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        );
      },
      separatorBuilder: (BuildContext context, int index) {
        return SizedBox(
          height: 10.0,
        );
      },
    );
  }

  ///bottomButtons
  bottomButtons() {
    return Container(
      padding: const EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 40),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
            onTap: () {
              Navigator.pop(context);
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
          Spacer(),
          Visibility(
            visible: !isAddEducation,
            child: MaterialButton(
              height: 35.0,
              elevation: 5,
              color: btnColor,
              textColor: Colors.white,
              child: Text(
                'NEXT',
                textScaleFactor: 1.0,
              ),
              onPressed: () {
                //CommonRoutePage().gotoEmploymentPage(context);
                BlocProvider.of<FieldsBloc>(context)
                    .add(NextButtonEventScreen6(userMapData: userMapData));

                if (widget?.edit == null && userMapData.isNotEmpty)
                  Navigator.of(context).pushNamed(EmploymentPage.routeName);
                // else
                //   ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                //     content: const Text('Please Provide Education '),
                //   ));
              },
            ),
          ),
          Visibility(
            visible: isAddEducation,
            child: MaterialButton(
              height: 35.0,
              elevation: 5,
              color: btnColor,
              textColor: Colors.white,
              child: Text(
                'SAVE',
                textScaleFactor: 1.0,
              ),
              onPressed: () {
                ///save education and set isAddEducation to false
                setState(() {
                  if (key.currentState.validate()) {
                    isAddEducation = false;
                    performSaveEvent();
                  }
                });
              },
            ),
          ),
        ],
      ),
    );
  }

  void performEditEvent(int index) {
    {
      setState(() {
        isAddEducation = true;
        containerVisibility = false;
      });

      schoolController?.text = userMapData[index]['school'];
      degreeController?.text = userMapData[index]['degree'];
      areaOfStudyController?.text = userMapData[index]['areaOfStudy'];
      descriptionController?.text = userMapData[index]['description'];
      toDateController?.text = userMapData[index]['endDate'];
      fromDateController?.text = userMapData[index]['startDate'];
    }
  }

  void performSaveEvent() {
    setState(() {
      isAddEducation = false;
      containerVisibility = true;
    });
    EducationModel educationModel = EducationModel(
        school: schoolController?.text,
        degree: degreeController?.text,
        areaOfStudy: areaOfStudyController?.text,
        description: descriptionController?.text,
        endDate: toDateController?.text,
        startDate: fromDateController?.text);

    userMapData?.add(educationModel.toMap(educationModel));
    schoolController?.text = '';
    degreeController?.text = '';
    areaOfStudyController?.text = '';
    descriptionController?.text = '';
    toDateController?.text = '';
    fromDateController?.text = '';
  }
}
