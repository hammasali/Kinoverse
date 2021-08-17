import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kinoverse/business_logic/bloc/fields/fields_bloc.dart';
import 'package:kinoverse/common/TextStyleRes.dart';
import 'package:kinoverse/common/common_widget.dart';
import 'package:kinoverse/core/routes.dart';
import 'package:kinoverse/page/worker/education/education_page.dart';

import '../../../app.dart';

class ExpertiseLevelPage extends StatefulWidget {
  static const String routeName = '/expertise_levelPage';

  @override
  _ExpertiseLevelPageState createState() => _ExpertiseLevelPageState();
}

class _ExpertiseLevelPageState extends State<ExpertiseLevelPage> {
  var isEntryLevelMarked = true;
  var isExperienceLevelMarked = false;
  var isIntermediateLevelMarked = false;
  MyAppRoutes _myAppRoutes = MyAppRoutes();
  String expert = 'Entry Level';

  @override
  void dispose() {
    _myAppRoutes.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print("runtimeType -> " + runtimeType.toString());
    return Scaffold(
      backgroundColor: bgColor,
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(top: 60),
          height: MediaQuery.of(context).size.height,
          child: Column(children: <Widget>[
            gettingStartBtn(),
            myServices(),
            Spacer(),
            // =======================  BLOC  ======================
            BlocBuilder<FieldsBloc, FieldsState>(builder: (context, state) {
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
            }),
            bottomButtons()
          ]),
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
                  App.expertiseLevelIcon,
                  color: txtColor,
                  height: 20,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 12),
                child: Text("Expertise Level",
                    style:
                        TextStyle(fontSize: 15, fontWeight: FontWeight.w400)),
              ),
            ],
          ),
        ),
      ),
    );
  }

  ///myServices
  myServices() {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20, top: 55),
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextStyleRes.textStyleFont1(
                textColor: txtColor,
                text: "What is your level of experience in this field?",
                fontSize: 12,
                fontWeight: FontWeight.w700),
            SizedBox(
              height: 20,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      color: btnColor,
                      width: 200,
                      padding: const EdgeInsets.only(
                          left: 10, right: 10, top: 10, bottom: 10),
                      child: TextStyleRes.textStyleFont1(
                          textColor: txtColor,
                          text: "Entry Level",
                          fontSize: 10,
                          fontWeight: FontWeight.w700),
                    ),
                    Spacer(),
                    Visibility(
                      visible: !isEntryLevelMarked,
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
                          expert = 'Entry Level';
                          isEntryLevelMarked = true;
                          isExperienceLevelMarked = false;
                          isIntermediateLevelMarked = false;
                        },
                      ),
                    ),
                    Visibility(
                      visible: isEntryLevelMarked,
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
                            print('true');
                            isEntryLevelMarked = false;
                            isExperienceLevelMarked = false;
                            isIntermediateLevelMarked = false;
                          });
                        },
                      ),
                    ),
                  ],
                ),
                Container(
                  color: Colors.white,
                  width: 200,
                  padding: const EdgeInsets.only(
                      left: 10, right: 10, top: 15, bottom: 15),
                  child: TextStyleRes.textUbuntuStyleFont3(
                      text: "I am relatively new in this field.",
                      fontSize: 10,
                      txtColor: Colors.black,
                      fontWeight: FontWeight.w400),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      color: btnColor,
                      width: 200,
                      padding: const EdgeInsets.only(
                          left: 10, right: 10, top: 10, bottom: 10),
                      child: TextStyleRes.textStyleFont1(
                          textColor: txtColor,
                          text: "Intermediate",
                          fontSize: 10,
                          fontWeight: FontWeight.w700),
                    ),
                    Spacer(),
                    Visibility(
                      visible: !isIntermediateLevelMarked,
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
                          expert = 'Intermediate';
                          isEntryLevelMarked = false;
                          isExperienceLevelMarked = false;
                          isIntermediateLevelMarked = true;
                        },
                      ),
                    ),
                    Visibility(
                      visible: isIntermediateLevelMarked,
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
                            isEntryLevelMarked = false;
                            isExperienceLevelMarked = false;
                            isIntermediateLevelMarked = false;
                          });
                        },
                      ),
                    ),
                  ],
                ),
                Container(
                  color: Colors.white,
                  width: 200,
                  padding: const EdgeInsets.only(
                      left: 10, right: 10, top: 15, bottom: 15),
                  child: TextStyleRes.textUbuntuStyleFont3(
                      text: "I have substantial experience in this field.",
                      fontSize: 10,
                      txtColor: Colors.black,
                      fontWeight: FontWeight.w400),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      color: btnColor,
                      width: 200,
                      padding: const EdgeInsets.only(
                          left: 10, right: 10, top: 10, bottom: 10),
                      child: TextStyleRes.textStyleFont1(
                          textColor: txtColor,
                          text: "Expert",
                          fontSize: 10,
                          fontWeight: FontWeight.w700),
                    ),
                    Spacer(),
                    Visibility(
                      visible: !isExperienceLevelMarked,
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
                          expert = 'Expert';
                          isEntryLevelMarked = false;
                          isExperienceLevelMarked = true;
                          isIntermediateLevelMarked = false;
                        },
                      ),
                    ),
                    Visibility(
                      visible: isExperienceLevelMarked,
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
                            isEntryLevelMarked = false;
                            isExperienceLevelMarked = false;
                            isIntermediateLevelMarked = false;
                          });
                        },
                      ),
                    ),
                  ],
                ),
                Container(
                  color: Colors.white,
                  width: 200,
                  padding: const EdgeInsets.only(
                      left: 10, right: 10, top: 15, bottom: 15),
                  child: TextStyleRes.textUbuntuStyleFont3(
                      text:
                          "I have comprehensive and deep expertise in this field.",
                      fontSize: 10,
                      txtColor: Colors.black,
                      fontWeight: FontWeight.w400),
                ),
              ],
            ),
          ],
        ),
      ),
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
              //CommonRoutePage().gotoEducationPage(context);
              BlocProvider.of<FieldsBloc>(context)
                  .add(NextButtonEventScreen5(expert));

              Navigator.of(context).pushNamed(EducationPage.routeName);
            },
          ),
        ],
      ),
    );
  }
}
