import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kinoverse/app.dart';
import 'package:kinoverse/business_logic/bloc/fields/fields_bloc.dart';
import 'package:kinoverse/common/TextStyleRes.dart';
import 'package:kinoverse/common/common_widget.dart';
import 'package:kinoverse/core/routes.dart';
import 'package:kinoverse/model/worker_job_model.dart';
import 'package:kinoverse/page/worker/category_page/category_page.dart';
import 'package:kinoverse/page/worker/language/language_page.dart';
import 'package:kinoverse/page/worker/profile_overview/profile_overview_page.dart';

class EmploymentPage extends StatefulWidget {
  static const String routeName = '/employment_page';
  final bool edit;

  EmploymentPage([this.edit]);

  @override
  _EmploymentPageState createState() => _EmploymentPageState();
}

class _EmploymentPageState extends State<EmploymentPage> {
  bool containerVisibility = false;
  final key = GlobalKey<FormState>();
  MyAppRoutes _myAppRoutes = MyAppRoutes();
  var isAddEmployment = false;
  var isCurrentlyWorking = false;
  var companyController = TextEditingController();
  var cityController = TextEditingController();
  var countryController = TextEditingController();
  var titleController = TextEditingController();
  var fromDateController = TextEditingController();
  var toDateController = TextEditingController();
  var descriptionController = TextEditingController();
  List<Map<String, dynamic>> userMapData = [];

  @override
  void dispose() {
    super.dispose();
    _myAppRoutes.dispose();
    companyController.dispose();
    cityController.dispose();
    countryController.dispose();

    titleController.dispose();
    fromDateController.dispose();
    toDateController.dispose();
    descriptionController.dispose();
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
                  children: <Widget>[gettingStartBtn(), myEmployment()],
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
                  App.employmentIcon,
                  color: txtColor,
                  height: 20,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 12),
                child: Text("Employment",
                    style:
                        TextStyle(fontSize: 15, fontWeight: FontWeight.w400)),
              ),
            ],
          ),
        ),
      ),
    );
  }

  ///employment
  myEmployment() {
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
                text: "Add your past experience",
                fontSize: 12,
                fontWeight: FontWeight.w700),
            SizedBox(
              height: 15,
            ),
            TextStyleRes.textUbuntuStyleFont2(
                text:
                    "Build your credibility by showcasing the projects or jobs you have completed",
                fontSize: 10,
                fontWeight: FontWeight.w400),
            SizedBox(
              height: 15,
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
                      text: "Add Employment",
                      fontSize: 10,
                      fontWeight: FontWeight.w400),
                ),
                SizedBox(
                  width: 10,
                ),
                Visibility(
                  visible: !isAddEmployment,
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
                      isAddEmployment = true;
                    },
                  ),
                ),
                Visibility(
                  visible: isAddEmployment,
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
                        isAddEmployment = false;
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
              child: employmentItem(),
            ),
            Visibility(
              visible: isAddEmployment,
              child: addEmployment(),
            ),
            widget.edit != true
                ? Visibility(
                    visible: !isAddEmployment,
                    child: MaterialButton(
                      height: 35.0,
                      textColor: btnColor,
                      child: Text(
                        'skip this step',
                        textScaleFactor: 1.0,
                      ),
                      onPressed: () {
                        //CommonRoutePage().gotoLanguagePage(context);
                        Navigator.of(context).pushNamed(LanguagePage.routeName);
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

  ///addEmployment
  addEmployment() {
    return Form(
      key: key,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 10,
          ),
          TextStyleRes.textUbuntuStyleFont2(
              text: "Company", fontSize: 10, fontWeight: FontWeight.w700),
          SizedBox(
            height: 5,
          ),
          Container(
              decoration: BoxDecoration(
                border: Border.all(color: btnBorderWhite, width: 1),
              ),
              child: TextFormField(
                cursorColor: txtColor,
                controller: companyController,
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
                    hintText: "",
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
              text: "Location", fontSize: 10, fontWeight: FontWeight.w700),
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
                      controller: cityController,
                      validator: (value) =>
                          value.trim().isEmpty || value == null
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
                          hintText: "City",
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
                      controller: countryController,
                      cursorColor: txtColor,
                      validator: (value) =>
                          value.trim().isEmpty || value == null
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
                          hintMaxLines: 3,
                          contentPadding: EdgeInsets.only(
                            left: 10,
                            bottom: 10,
                            top: 10,
                          ),
                          hintText: "Country",
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
              text: "Title", fontSize: 10, fontWeight: FontWeight.w700),
          SizedBox(
            height: 5,
          ),
          Container(
              decoration: BoxDecoration(
                border: Border.all(color: btnBorderWhite, width: 1),
              ),
              child: TextFormField(
                cursorColor: txtColor,
                controller: titleController,
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
                    hintText: "",
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
              text: "Period", fontSize: 10, fontWeight: FontWeight.w700),
          SizedBox(
            height: 5,
          ),
          Visibility(
            visible: !isCurrentlyWorking,
            child: Row(
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
                        validator: (value) =>
                            value.trim().isEmpty || value == null
                                ? 'Field is empty'
                                : null,
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
                        validator: (value) =>
                            value.trim().isEmpty || value == null
                                ? 'Field is empty'
                                : null,
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
                            hintText: "To (or expected year)",
                            hintStyle: TextStyle(
                                fontFamily: App.font2,
                                color: txtDescriptionColor,
                                fontSize: 10,
                                fontWeight: FontWeight.w400)),
                      )),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          CategoryCheckbox(
            checked: isCurrentlyWorking,
            title: "I currently work here",
            onChanged: (state) {
              setState(() {
                isCurrentlyWorking = state;
              });
            },
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
                maxLines: 5,
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
                    hintText: "",
                    hintStyle: TextStyle(
                        fontFamily: App.font2,
                        color: txtDescriptionColor,
                        fontSize: 10,
                        fontWeight: FontWeight.w400)),
              )),
        ],
      ),
    );
  }

  ///employmentItem
  employmentItem() {
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
                          text: userMapData[index]['company'],
                          fontSize: 10,
                          fontWeight: FontWeight.w700),
                      SizedBox(
                        height: 5,
                      ),
                      Wrap(
                        children: [
                          TextStyleRes.textUbuntuStyleFont2(
                              text: userMapData[index]['start'].toString() != ''
                                  ? userMapData[index]['start']
                                  : '',
                              fontSize: 10,
                              fontWeight: FontWeight.w400),
                          TextStyleRes.textUbuntuStyleFont2(
                              text: userMapData[index]['end'].toString() != ''
                                  ? ' - ${userMapData[index]['end']}'
                                  : '',
                              fontSize: 10,
                              fontWeight: FontWeight.w400),
                        ],
                      ),
                      SizedBox(
                        height: 3,
                      ),
                      TextStyleRes.textUbuntuStyleFont2(
                          text: userMapData[index]['title'],
                          fontSize: 10,
                          fontWeight: FontWeight.w700),
                      SizedBox(
                        height: 3,
                      ),

                      Wrap(
                        children: [
                          TextStyleRes.textUbuntuStyleFont2(
                              text: userMapData[index]['city'].toString() != ''
                                  ? userMapData[index]['city']
                                  : '',
                              fontSize: 10,
                              fontWeight: FontWeight.w400),
                          TextStyleRes.textUbuntuStyleFont2(
                              text:
                                  userMapData[index]['country'].toString() != ''
                                      ? ', ${userMapData[index]['country']}'
                                      : '',
                              fontSize: 10,
                              fontWeight: FontWeight.w400),
                        ],
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      TextStyleRes.textUbuntuStyleFont2(
                          text: userMapData[index]['currentlyWorking'] == true
                              ? 'Currently working'
                              : '',
                          fontSize: 10,
                          fontWeight: FontWeight.w700),
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
            visible: !isAddEmployment,
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
                //CommonRoutePage().gotoLanguagePage(context);
                BlocProvider.of<FieldsBloc>(context).add(
                    NextButtonEventScreen7(userEmploymentMapData: userMapData));

                if (widget?.edit == null && userMapData.isNotEmpty)
                  Navigator.of(context).pushNamed(LanguagePage.routeName);
              },
            ),
          ),
          Visibility(
            visible: isAddEmployment,
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
                ///save employment and set isAddEmployment to false
                if (key.currentState.validate()) {
                  isAddEmployment = false;
                  performSaveEvent();
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  performEditEvent(int index) {
    {
      setState(() {
        isAddEmployment = true;
        containerVisibility = false;
      });

      fromDateController?.text = userMapData[index]['start'];
      cityController?.text = userMapData[index]['city'];
      countryController?.text = userMapData[index]['country'];
      titleController?.text = userMapData[index]['title'];
      descriptionController?.text = userMapData[index]['description'];
      toDateController?.text = userMapData[index]['end'];
      companyController?.text = userMapData[index]['company'];
    }
  }

  void performSaveEvent() {
    setState(() {
      isAddEmployment = false;
      containerVisibility = true;
    });

    WorkerJobModel workerJobModel = WorkerJobModel(
        company: companyController?.text,
        city: cityController?.text,
        country: countryController?.text,
        title: titleController?.text,
        start: fromDateController?.text,
        end: toDateController?.text,
        description: descriptionController?.text,
        currentlyWorking: isCurrentlyWorking);
    userMapData.add(workerJobModel.toMap(workerJobModel));

    companyController?.text = '';
    cityController?.text = '';
    countryController?.text = '';
    titleController?.text = '';
    descriptionController?.text = '';
    fromDateController?.text = '';
    toDateController?.text = '';
    isCurrentlyWorking = false;
  }
}
