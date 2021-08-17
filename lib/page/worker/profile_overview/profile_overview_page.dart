import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:kinoverse/app.dart';
import 'package:kinoverse/backend_service/models/worker_form.dart';
import 'package:kinoverse/backend_service/repo/firebase_repo.dart';
import 'package:kinoverse/business_logic/bloc/fields/fields_bloc.dart';
import 'package:kinoverse/common/TextStyleRes.dart';
import 'package:kinoverse/core/route_pass.dart';
import 'package:kinoverse/page/worker/education/education_page.dart';
import 'package:kinoverse/page/worker/employment/employment_page.dart';
import 'package:kinoverse/page/worker/expertise_page/expertise_page.dart';
import 'package:kinoverse/page/worker/home_page/home_page.dart';
import 'package:kinoverse/page/worker/hourly_rate/hourly_rate_page.dart';
import 'package:kinoverse/page/worker/language/language_page.dart';
import 'package:kinoverse/page/worker/profile_overview/profile_overview_extension_page.dart';

class ProfileOverviewPage extends StatefulWidget {
  static const String routeName = '/profileOverview_page';
  final Map workerFormModel;

  ProfileOverviewPage([this.workerFormModel]);

  @override
  _ProfileOverviewPageState createState() => _ProfileOverviewPageState();
}

class _ProfileOverviewPageState extends State<ProfileOverviewPage> {
  String downloadURL;
  WorkerFormModel workerFormModel;
  var sharedValue = 0;

  final Map<int, Widget> profileWidgets = const <int, Widget>{
    0: Text(
      "Public",
      style: TextStyle(color: Colors.white),
    ),
    1: Text("Private", style: TextStyle(color: Colors.white))
  };

  @override
  void initState() {
    super.initState();
    workerFormModel = WorkerFormModel.fromMap(widget?.workerFormModel);
    print('Categories :: ${workerFormModel?.categories}');
  }

  Widget get _imageWidget => FutureBuilder<void>(
        future: getURL(),
        builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return Container(
                width: 80,
                height: 80,
                child: CircleAvatar(
                    backgroundColor: Colors.transparent,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: getCircularProgress(context),
                    )),
              );
            case ConnectionState.done:
              return Container(
                  height: 80.0,
                  width: 80.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(40.0),
                  ),
                  child: downloadURL != null
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(40.0),
                          child: FittedBox(
                              fit: BoxFit.cover,
                              child: Image.network(downloadURL)))
                      : Container(
                          width: 80,
                          height: 80,
                          child: CircleAvatar(
                              backgroundColor: Colors.transparent,
                              child: Icon(
                                Icons.account_circle_outlined,
                                color: Colors.white,
                                size: 80,
                              )),
                        ));
            default:
              return Container(
                width: 80,
                height: 80,
                child: CircleAvatar(
                    backgroundColor: Colors.transparent,
                    child: Icon(
                      Icons.account_circle_outlined,
                      color: Colors.white,
                      size: 80,
                    )),
              );
          }
        },
      );

  Widget get _displayNameCountryCreatedAt => FutureBuilder<DocumentSnapshot>(
        future: _fetch(),
        builder:
            (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return TextStyleRes.textStyleFont1(
                  textColor: txtColor,
                  text: "Loading...",
                  fontSize: 12,
                  fontWeight: FontWeight.w700);

            case ConnectionState.done:
              Map<String, dynamic> data = snapshot.data?.data();
              return Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextStyleRes.textStyleFont1(
                          textColor: txtColor,
                          text: "${data['name']}",
                          fontSize: 12,
                          fontWeight: FontWeight.w700),
                      InkWell(
                        onTap: () {
                          Navigator.of(context)
                              .pushNamed(ProfileOverViewExtensionPage.routeName,
                                  arguments:
                                      ProfileOverViewExtensionPageArgs(true))
                              .then((value) => _fetch());
                        },
                        child: Container(
                          height: 25.0,
                          padding: const EdgeInsets.only(left: 5, right: 5),
                          child: Image.asset(
                            App.edit,
                            height: 14,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.location_on_outlined,
                        size: 16,
                        color: Colors.white,
                      ),
                      TextStyleRes.textUbuntuStyleFont2(
                          text: "${data['country']}",
                          fontSize: 12,
                          fontWeight: FontWeight.w400),
                    ],
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  TextStyleRes.textUbuntuStyleFont2(
                      text:
                          "${DateFormat('hh:mm a').format(DateTime.now()) + ' local time'}",
                      fontSize: 12,
                      fontWeight: FontWeight.w400),
                ],
              );

            // Column(
            //   children: [
            //     Row(
            //       mainAxisAlignment: MainAxisAlignment.center,
            //       children: <Widget>[
            //         Text('${data['name']}, '),
            //         Text('${data['country']}'),
            //         IconButton(
            //             icon: Icon(Icons.edit),
            //             onPressed: () {
            //               Navigator.of(context)
            //                   .push(MaterialPageRoute(
            //                   builder: (_) => ScreenExtension14()))
            //                   .then((value) => _fetch());
            //             })
            //       ],
            //     ),
            //     Text('${data['createdAt']}'),
            //   ],
            // );
            default:
              return Text(
                'Error: ${snapshot.error}}',
                textAlign: TextAlign.center,
              );
          }
        },
      );

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
                  children: <Widget>[profile(), details()],
                ),
              ),
            ),
            bottomButtons()
          ],
        ),
      ),
    );
  }

  ///profile
  profile() {
    return Center(
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _imageWidget,
            // Container(
            //   width: 80,
            //   height: 80,
            //   child: CircleAvatar(
            //       backgroundColor: Colors.transparent,
            //       child: Icon(
            //         Icons.account_circle_outlined,
            //         color: Colors.white,
            //         size: 80,
            //       )),
            // ),
            SizedBox(
              height: 5,
            ),

            ///Fetch data from server
            _displayNameCountryCreatedAt,

            // Row(
            //   mainAxisAlignment: MainAxisAlignment.center,
            //   children: [
            //     TextStyleRes.textStyleFont1(
            //         textColor: txtColor,
            //         text: "Michel Jordan",
            //         fontSize: 12,
            //         fontWeight: FontWeight.w700),
            //     InkWell(
            //       onTap: () {
            //         Navigator.of(context)
            //             .pushNamed(ProfileOverViewExtensionPage.routeName);
            //       },
            //       child: Container(
            //         height: 25.0,
            //         padding: const EdgeInsets.only(left: 5, right: 5),
            //         child: Image.asset(
            //           App.edit,
            //           height: 14,
            //           color: Colors.white,
            //         ),
            //       ),
            //     ),
            //   ],
            // ),
            // SizedBox(
            //   height: 5,
            // ),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.center,
            //   children: [
            //     Icon(
            //       Icons.location_on_outlined,
            //       size: 16,
            //       color: Colors.white,
            //     ),
            //     TextStyleRes.textUbuntuStyleFont2(
            //         text: "Ubud, Bali, Indonesia",
            //         fontSize: 12,
            //         fontWeight: FontWeight.w400),
            //   ],
            // ),
            // SizedBox(
            //   height: 5,
            // ),
            // TextStyleRes.textUbuntuStyleFont2(
            //     text: "11:16 AM local time",
            //     fontSize: 12,
            //     fontWeight: FontWeight.w400),
          ],
        ),
      ),
    );
  }

  ///details
  details() {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20, top: 30),
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                TextStyleRes.textUbuntuStyleFont2(
                    text: "View account as",
                    fontSize: 10,
                    fontWeight: FontWeight.w700),
                Spacer(),
                CupertinoSegmentedControl(
                  borderColor: btnColor,
                  selectedColor: btnColor,
                  unselectedColor: Colors.transparent,
                  children: profileWidgets,
                  onValueChanged: (int val) {
                    setState(() {
                      sharedValue = val;
                    });
                  },
                  groupValue: sharedValue,
                )
              ],
            ),
            SizedBox(
              height: 10,
            ),

            ///  ---------------   LANGUAGE  -------------  ///

            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                rowEdit('English Language', LanguagePage.routeName),
                workerFormModel?.englishProficiency.toString() != ''
                    ? languageItem()
                    : Container(),
                workerFormModel?.otherLanguages.toString() != ''
                    ? otherLanguages(workerFormModel.otherLanguages)
                    : Container(),
              ],
            ),
            SizedBox(
              height: 10,
            ),

            ///---------------   Hourly Rate  -------------///

            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                rowEdit('Hourly Rate', HourlyRatePage.routeName),
                workerFormModel?.hourlyRate != ''
                    ? TextStyleRes.textUbuntuStyleFont2(
                        text: "\$${workerFormModel.hourlyRate}",
                        fontSize: 12,
                        fontWeight: FontWeight.w400)
                    : Container()
              ],
            ),
            SizedBox(
              height: 10,
            ),

            ///---------------   Skills  -------------///

            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                rowEdit('Skills', ExpertisePage.routeName),
                workerFormModel?.skills != ''
                    ? skillsItem(workerFormModel.skills)
                    : Container(),
              ],
            ),
            SizedBox(
              height: 10,
            ),

            ///---------------   Employment History  -------------///

            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                rowEdit('Employment History', EmploymentPage.routeName),
                workerFormModel?.employment != ''
                    ? employmentItem(workerFormModel.employment)
                    : Container(),
              ],
            ),

            SizedBox(
              height: 10,
            ),

            ///---------------   Education History  ------------- ///

            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                rowEdit('Education', EducationPage.routeName),
                workerFormModel?.education != ''
                    ? educationItem(workerFormModel.education)
                    : Container(),
              ],
            ),
          ],
        ),
      ),
    );
  }

  ///Languages
  languageItem() {
    return TextStyleRes.textUbuntuStyleFont2(
        text: '${workerFormModel?.englishProficiency}',
        fontSize: 12,
        fontWeight: FontWeight.w400);
  }

  Widget otherLanguages(List<dynamic> data) {
    return ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        padding: const EdgeInsets.symmetric(vertical: 5.0),
        itemCount: data?.length,
        shrinkWrap: true,
        itemBuilder: (
          context,
          index,
        ) {
          return TextStyleRes.textUbuntuStyleFont2(
              text: data[index], fontSize: 12, fontWeight: FontWeight.w400);
        });
  }

  ///Skills

  Widget skillsItem(List<dynamic> data) {
    return ListView.separated(
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      itemCount: data?.length,
      shrinkWrap: true,
      itemBuilder: (
        context,
        index,
      ) {
        return Container(
            width: getDeviceWidth(context) / 2,
            decoration: BoxDecoration(
              border: Border.all(color: txtDescriptionColor, width: 1),
            ),
            padding:
                const EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
            child: Center(
              child: TextStyleRes.textUbuntuStyleFont2(
                  text: data[index], fontSize: 12, fontWeight: FontWeight.w400),
            ));
      },
      separatorBuilder: (BuildContext context, int index) {
        return SizedBox(
          height: 10.0,
        );
      },
    );
  }

  ///employment Item
  employmentItem(List<dynamic> data) {
    return ListView.separated(
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      itemCount: data?.length,
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
                          text: data[index]['company'],
                          fontSize: 10,
                          fontWeight: FontWeight.w700),
                      SizedBox(
                        height: 5,
                      ),
                      Wrap(
                        children: [
                          TextStyleRes.textUbuntuStyleFont2(
                              text: data[index]['start'].toString() != ''
                                  ? data[index]['start']
                                  : '',
                              fontSize: 10,
                              fontWeight: FontWeight.w400),
                          TextStyleRes.textUbuntuStyleFont2(
                              text: data[index]['end'].toString() != ''
                                  ? ' - ${data[index]['end']}'
                                  : '',
                              fontSize: 10,
                              fontWeight: FontWeight.w400),
                        ],
                      ),
                      SizedBox(
                        height: 3,
                      ),
                      TextStyleRes.textUbuntuStyleFont2(
                          text: data[index]['title'],
                          fontSize: 10,
                          fontWeight: FontWeight.w700),
                      SizedBox(
                        height: 3,
                      ),

                      Wrap(
                        children: [
                          TextStyleRes.textUbuntuStyleFont2(
                              text: data[index]['city'].toString() != ''
                                  ? data[index]['city']
                                  : '',
                              fontSize: 10,
                              fontWeight: FontWeight.w400),
                          TextStyleRes.textUbuntuStyleFont2(
                              text: data[index]['country'].toString() != ''
                                  ? ', ${data[index]['country']}'
                                  : '',
                              fontSize: 10,
                              fontWeight: FontWeight.w400),
                        ],
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      TextStyleRes.textUbuntuStyleFont2(
                          text: data[index]['currentlyWorking'] == true
                              ? 'Currently working'
                              : '',
                          fontSize: 10,
                          fontWeight: FontWeight.w700),
                      SizedBox(
                        height: 5,
                      ),
                      TextStyleRes.textUbuntuStyleFont2(
                          text: data[index]['description'],
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
          ],
        );
      },
      separatorBuilder: (BuildContext context, int index) {
        return SizedBox(
          height: 10.0,
        );
      },
    );

    // return Row(
    //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //   children: [
    //     Expanded(
    //       flex: 5,
    //       child: Container(
    //         // width: 250,
    //         decoration: BoxDecoration(
    //           border: Border.all(color: txtDescriptionColor, width: 1),
    //         ),
    //         child: Padding(
    //           padding: const EdgeInsets.all(8.0),
    //           child: Column(
    //             crossAxisAlignment: CrossAxisAlignment.start,
    //             children: [
    //               TextStyleRes.textUbuntuStyleFont2(
    //                   text: "Editor",
    //                   fontSize: 12,
    //                   fontWeight: FontWeight.w700),
    //               SizedBox(
    //                 height: 5,
    //               ),
    //               TextStyleRes.textUbuntuStyleFont3(
    //                   text: "GIE",
    //                   fontSize: 12,
    //                   fontWeight: FontWeight.w400,
    //                   txtColor: Colors.white),
    //               Row(
    //                 children: [
    //                   TextStyleRes.textUbuntuStyleFont3(
    //                       text: "Miles Film",
    //                       fontSize: 12,
    //                       txtColor: Colors.white,
    //                       fontWeight: FontWeight.w400),
    //                   SizedBox(
    //                     width: 10,
    //                   ),
    //                   TextStyleRes.textUbuntuStyleFont3(
    //                       text: "2021",
    //                       fontSize: 12,
    //                       txtColor: txtDescriptionColor,
    //                       fontWeight: FontWeight.w400),
    //                 ],
    //               ),
    //             ],
    //           ),
    //         ),
    //       ),
    //     ),
    //     SizedBox(
    //       width: 100,
    //     )
    //   ],
    // );
  }

  ///educationItem
  educationItem(List<dynamic> data) {
    return ListView.separated(
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      itemCount: data?.length,
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
                          text: data[index]['school'],
                          fontSize: 10,
                          fontWeight: FontWeight.w700),
                      SizedBox(
                        height: 5,
                      ),
                      Row(
                        children: [
                          TextStyleRes.textUbuntuStyleFont2(
                              text: data[index]['startDate'].toString() != ''
                                  ? data[index]['startDate']
                                  : '',
                              fontSize: 10,
                              fontWeight: FontWeight.w400),
                          TextStyleRes.textUbuntuStyleFont2(
                              text: data[index]['endDate'].toString() != ''
                                  ? ' - ${data[index]['endDate']}'
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
                              text: data[index]['degree'].toString() != ''
                                  ? data[index]['degree']
                                  : '',
                              fontSize: 10,
                              fontWeight: FontWeight.w400),
                          TextStyleRes.textUbuntuStyleFont2(
                              text: data[index]['areaOfStudy'].toString() != ''
                                  ? ' of ${data[index]['areaOfStudy']}'
                                  : '',
                              fontSize: 10,
                              fontWeight: FontWeight.w400),
                        ],
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      TextStyleRes.textUbuntuStyleFont2(
                          text: data[index]['description'],
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
          ],
        );
      },
      separatorBuilder: (BuildContext context, int index) {
        return SizedBox(
          height: 10.0,
        );
      },
    );

    // return Row(
    //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //   children: [
    //     Expanded(
    //       flex: 5,
    //       child: Container(
    //         decoration: BoxDecoration(
    //           border: Border.all(color: txtDescriptionColor, width: 1),
    //         ),
    //         child: Padding(
    //           padding: const EdgeInsets.all(8.0),
    //           child: Column(
    //             crossAxisAlignment: CrossAxisAlignment.start,
    //             children: [
    //               TextStyleRes.textUbuntuStyleFont2(
    //                   text: "Columbia College Chicago",
    //                   fontSize: 12,
    //                   fontWeight: FontWeight.w700),
    //               SizedBox(
    //                 height: 5,
    //               ),
    //               TextStyleRes.textUbuntuStyleFont3(
    //                   text: "2017 - 2021",
    //                   fontSize: 12,
    //                   fontWeight: FontWeight.w400,
    //                   txtColor: Colors.white),
    //               TextStyleRes.textUbuntuStyleFont3(
    //                   text: "Bachelor of Arts (BA) of Film and Television",
    //                   fontSize: 12,
    //                   txtColor: Colors.white,
    //                   fontWeight: FontWeight.w400),
    //             ],
    //           ),
    //         ),
    //       ),
    //     ),
    //     SizedBox(
    //       width: 100,
    //     )
    //   ],
    // );
  }

  ///bottomButtons
  bottomButtons() {
    return Container(
      padding: const EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 40),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          //============================ BLOC ===============================

          BlocConsumer<FieldsBloc, FieldsState>(
              bloc: BlocProvider.of<FieldsBloc>(context),
              builder: (context, state) {
                if (state is FieldLoadingState) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextStyleRes.textStyleFont1(
                          textColor: Colors.white,
                          text: 'Uploading Profile...',
                          fontSize: 12,
                          fontWeight: FontWeight.w800),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: getCircularProgress(context),
                      ),
                    ],
                  );
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
                return MaterialButton(
                  height: 35.0,
                  elevation: 5,
                  color: btnColor,
                  textColor: Colors.white,
                  child: Text(
                    'Submit Profile',
                    textScaleFactor: 1.0,
                  ),
                  onPressed: () {
                    // CommonRoutePage().gotoHomePage(context);
                    BlocProvider.of<FieldsBloc>(context)
                        .add(SubmitButtonEventScreen14());
                  },
                );
              },
              listener: (context, state) {
                if (state is FieldSuccessfulState)
                  return Navigator.pushNamedAndRemoveUntil<dynamic>(
                    context,
                    HomePage.routeName,
                    (route) =>
                        false, //if you want to disable back feature set to false
                  );
              }),
        ],
      ),
    );
  }

  Widget rowEdit(String text, String routeName) {
    return Row(
      children: [
        TextStyleRes.textUbuntuStyleFont2(
            text: text, fontSize: 10, fontWeight: FontWeight.w700),
        Spacer(),
        InkWell(
          onTap: () =>
              Navigator.of(context).pushNamed(routeName, arguments: true),
          child: Container(
            height: 25.0,
            padding: const EdgeInsets.only(left: 5, right: 5),
            child: Image.asset(
              App.edit,
              height: 14,
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }

  getURL() async {
    downloadURL = await FirebaseRepo.instance.downloadURL();
  }

  Future<DocumentSnapshot> _fetch() async =>
      await FirebaseRepo.instance.fetchWorkerDataFromDb();
}
