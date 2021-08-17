import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:kinoverse/app.dart';
import 'package:kinoverse/backend_service/repo/firebase_repo.dart';
import 'package:kinoverse/business_logic/bloc/fields/fields_bloc.dart';
import 'package:kinoverse/common/TextStyleRes.dart';
import 'package:kinoverse/common/common_widget.dart';
import 'package:kinoverse/core/route_pass.dart';
import 'package:kinoverse/model/hire_submit_model.dart';
import 'package:kinoverse/page/hire/home_page/home_page.dart';
import 'package:kinoverse/page/worker/profile_overview/profile_overview_extension_page.dart';

class HireSignupPage extends StatefulWidget {
  static const String routeName = '/hireSignup_Page';
  final String name, country;

  HireSignupPage({this.name, this.country});

  @override
  _HireSignupPageState createState() => _HireSignupPageState();
}

class _HireSignupPageState extends State<HireSignupPage> {
  File _image;
  PickedFile _imageFile;
  dynamic _pickImageError;
  String _retrieveDataError;
  final ImagePicker _picker = ImagePicker();

  bool _isUserEmailVerified = false;
  Timer _timer;
  final _key = GlobalKey<FormState>();
  var currentUserPhoto = FirebaseRepo.instance?.getCurrentUser()?.photoURL;

  var ownerController = TextEditingController();
  var phoneController = TextEditingController();
  var vatIDController = TextEditingController();
  var timeZoneController = TextEditingController();
  var addressController = TextEditingController();

  @override
  void initState() {
    super.initState();
    Future(() async {
      _timer = Timer.periodic(Duration(seconds: 5), (timer) async {
        FirebaseRepo.instance.getCurrentUser().reload();
        var user = FirebaseRepo.instance.getCurrentUser();
        print('${user.emailVerified}');
        if (user.emailVerified) {
          setState(() {
            _isUserEmailVerified = user.emailVerified;
          });

          timer.cancel();
        }
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    if (_timer != null) {
      _timer?.cancel();
    }

    ownerController.dispose();
    phoneController.dispose();
    vatIDController.dispose();
    timeZoneController.dispose();
    addressController.dispose();
  }

  Widget get _imageUpload => FutureBuilder<void>(
        future: retrieveLostData(),
        builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
              return Container(
                height: 80,
                width: 80,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(40), color: btnColor),
                child: Center(
                    child: Icon(
                  Icons.account_circle_outlined,
                  color: Colors.white,
                  size: 70,
                )),
              );
            case ConnectionState.waiting:
              return Container(
                height: 80,
                width: 80,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(40), color: btnColor),
                child: Center(
                    child: Icon(
                  Icons.account_circle_outlined,
                  color: Colors.white,
                  size: 70,
                )),
              );
            case ConnectionState.done:
              return Container(
                height: 100,
                width: 100.0,
                decoration: BoxDecoration(
                  color: Colors.teal,
                  borderRadius: BorderRadius.circular(100.0),
                ),
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(130.0),
                    child:
                        FittedBox(fit: BoxFit.cover, child: _previewImage())),
              );
            default:
              return Container(
                height: 80,
                width: 80,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(40), color: btnColor),
                child: Center(
                    child: Icon(
                  Icons.account_circle_outlined,
                  color: Colors.white,
                  size: 70,
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
                                      ProfileOverViewExtensionPageArgs(false))
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
    return Scaffold(
      backgroundColor: bgColor,
      body: SafeArea(
        //TODO : ADD THE SIGN !
        child: _isUserEmailVerified
            ? Container(
                padding: EdgeInsets.only(top: 60),
                child: Column(
                  children: [
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 55, left: 20, right: 10),
                      child: Text(
                          'We have sent link to your account. Please verify it.',
                          style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w700,
                              color: txtColor)),
                    ),
                    SizedBox(
                      height: 5.0,
                    ),
                    CircularProgressIndicator.adaptive(
                      strokeWidth: 1.1,
                      backgroundColor: Color(0x00ffA60000),
                      valueColor: new AlwaysStoppedAnimation<Color>(
                          Color(0x00ffffffff)),
                    )
                  ],
                ),
              )
            : BlocListener<FieldsBloc, FieldsState>(
                listener: (context, state) {
                  if (state is FieldSuccessfulState)
                    Navigator.of(context).pushNamed(HireHomePage.routeName);
                },
                child: Container(
                  height: double.infinity,
                  color: bgColor,
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Form(
                    key: _key,
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              InkWell(
                                onTap: () => Navigator.of(context).pop(),
                                child: Image.asset(
                                  App.backIcon,
                                  height: 24,
                                  width: 24,
                                  color: Colors.white,
                                ),
                              ),
                              Spacer(),
                              TextStyleRes.textStyleFont1(
                                  text: "Company Profile",
                                  textColor: Colors.white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w700),
                              Spacer(),
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          profile(),
                          TextStyleRes.textUbuntuStyleFont3(
                              text: "Company Contacts",
                              txtColor: Colors.white,
                              fontSize: 10,
                              fontWeight: FontWeight.w700),
                          SizedBox(
                            height: 10,
                          ),

                          TextStyleRes.textUbuntuStyleFont2(
                              text: "Owner",
                              fontSize: 10,
                              fontWeight: FontWeight.w400),
                          SizedBox(
                            height: 5,
                          ),
                          Container(
                              width: getDeviceWidth(context) * 0.6,
                              decoration: BoxDecoration(
                                border:
                                    Border.all(color: btnBorderWhite, width: 1),
                                color: backContainerColor,
                              ),
                              child: TextFormField(
                                cursorColor: txtColor,
                                controller: ownerController,
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
                          TextStyleRes.textUbuntuStyleFont2(
                              text: "Phone Number",
                              fontSize: 10,
                              fontWeight: FontWeight.w400),
                          SizedBox(
                            height: 5,
                          ),
                          Container(
                              width: getDeviceWidth(context) * 0.6,
                              decoration: BoxDecoration(
                                border:
                                    Border.all(color: btnBorderWhite, width: 1),
                                color: backContainerColor,
                              ),
                              child: TextFormField(
                                cursorColor: txtColor,
                                controller: phoneController,
                                keyboardType: TextInputType.phone,
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
                          TextStyleRes.textUbuntuStyleFont2(
                              text: "VAT ID",
                              fontSize: 10,
                              fontWeight: FontWeight.w400),
                          SizedBox(
                            height: 5,
                          ),
                          Container(
                              width: getDeviceWidth(context) * 0.6,
                              decoration: BoxDecoration(
                                border:
                                    Border.all(color: btnBorderWhite, width: 1),
                                color: backContainerColor,
                              ),
                              child: TextFormField(
                                cursorColor: txtColor,
                                controller: vatIDController,
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
                            height: 5,
                          ),
                          TextStyleRes.textUbuntuStyleFont3(
                              text: "Enter your VAT ID to enable VAT invoicing",
                              fontSize: 10,
                              fontWeight: FontWeight.w400,
                              txtColor: txtDescriptionColor),
                          SizedBox(
                            height: 10,
                          ),
                          // TextStyleRes.textUbuntuStyleFont2(
                          //     text: "Timezone", fontSize: 10, fontWeight: FontWeight.w400),
                          // SizedBox(
                          //   height: 5,
                          // ),
                          // Container(
                          //     width: getDeviceWidth(context) * 0.6,
                          //     decoration: BoxDecoration(
                          //       border: Border.all(color: btnBorderWhite, width: 1),
                          //       color: backContainerColor,
                          //     ),
                          //     child: TextFormField(
                          //       cursorColor: txtColor,
                          //       controller: timeZoneController,
                          //       style: TextStyle(
                          //         fontFamily: App.font2,
                          //         color: txtColor,
                          //         fontSize: 12,
                          //       ),
                          //       decoration: new InputDecoration(
                          //           isDense: true,
                          //           border: InputBorder.none,
                          //           focusedBorder: InputBorder.none,
                          //           enabledBorder: InputBorder.none,
                          //           errorBorder: InputBorder.none,
                          //           disabledBorder: InputBorder.none,
                          //           contentPadding: EdgeInsets.only(
                          //             left: 10,
                          //             bottom: 10,
                          //             top: 10,
                          //           ),
                          //           hintText: "",
                          //           hintStyle: TextStyle(
                          //             fontFamily: App.font2,
                          //             color: btnBorderWhite,
                          //             fontSize: 10,
                          //           )),
                          //     )),
                          // SizedBox(
                          //   height: 10,
                          // ),
                          TextStyleRes.textUbuntuStyleFont2(
                              text: "Address",
                              fontSize: 10,
                              fontWeight: FontWeight.w400),
                          SizedBox(
                            height: 5,
                          ),
                          Container(
                              width: getDeviceWidth(context) * 0.6,
                              decoration: BoxDecoration(
                                border:
                                    Border.all(color: btnBorderWhite, width: 1),
                                color: backContainerColor,
                              ),
                              child: TextFormField(
                                cursorColor: txtColor,
                                controller: addressController,
                                validator: (value) =>
                                    value.trim().isEmpty || value == null
                                        ? 'Field is empty'
                                        : null,
                                style: TextStyle(
                                  fontFamily: App.font2,
                                  color: txtColor,
                                  fontSize: 13,
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
                            height: getDeviceHeight(context) * 0.28,
                          ),
                          Center(
                              child: CommonWidget.squareButton(
                            text: "Create New Account",
                            fontSize: 12.0,
                            height: 40.0,
                            width: 200.0,
                            containerColor: btnColor,
                            textColor: txtColor,
                            onTap: () {
                              if (_key.currentState.validate()) _submit();

                              //CommonRoutePage().gotoHireHomePage(context);
                            },
                          ))
                        ],
                      ),
                    ),
                  ),
                ),
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
            Center(
              child: GestureDetector(
                onTap: () => showSheet(context),
                child: Container(
                  child: Stack(children: [
                    _imageUpload,
                    // FittedBox(fit: BoxFit.cover, child: _previewImage()),
                    Positioned(
                        top: 0,
                        right: 0,
                        child: Icon(
                          Icons.add_a_photo_rounded,
                          color: Colors.white,
                        ))
                  ]),
                ),
              ),
            ),
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
            //         text: widget.name,
            //         fontSize: 12,
            //         fontWeight: FontWeight.w500),
            //     SizedBox(width: 5.0,),
            //     InkWell(
            //       onTap: () {
            //         ///edit
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
            //     SizedBox(width: 5.0,),
            //
            //     TextStyleRes.textUbuntuStyleFont2(
            //         text: widget.country,
            //         fontSize: 12,
            //         fontWeight: FontWeight.w400),
            //   ],
            // ),
            // SizedBox(
            //   height: 5,
            // ),
            // TextStyleRes.textUbuntuStyleFont2(
            //     text:
            //         "${DateFormat('hh:mm a').format(DateTime.now()) + ' local time'}",
            //     fontSize: 12,
            //     fontWeight: FontWeight.w400),
          ],
        ),
      ),
    );
  }

  void _onImageButtonPressed(ImageSource source, {BuildContext context}) async {
    try {
      final pickedFile = await _picker.getImage(
        source: source,
      );
      setState(() {
        _imageFile = pickedFile;
      });
    } catch (e) {
      setState(() {
        _pickImageError = e;
      });
    }
  }

  Widget _previewImage() {
    final Text retrieveError = _getRetrieveErrorWidget();
    if (retrieveError != null) {
      return retrieveError;
    }

    if (_imageFile != null) {
      _image = File(_imageFile.path);
      print('image File : $_image');
      return Semantics(
          child: Image.file(
            _image,
          ),
          label: 'Picked Image');
    } else if (_pickImageError != null) {
      return Container(
        height: 80,
        width: 80,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(40), color: btnColor),
        child: Center(
            child: Icon(
          Icons.account_circle_outlined,
          color: Colors.white,
          size: 70,
        )),
      );
    } else {
      return Container(
        height: 80,
        width: 80,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(40), color: btnColor),
        child: Center(
            child: Icon(
          Icons.account_circle_outlined,
          color: Colors.white,
          size: 70,
        )),
      );
    }
  }

  Future<void> retrieveLostData() async {
    final LostData response = await _picker.getLostData();
    if (response.isEmpty) {
      return;
    }
    if (response.file != null) {
      setState(() {
        _imageFile = response.file;
      });
    } else {
      _retrieveDataError = response.exception.code;
    }
  }

  Text _getRetrieveErrorWidget() {
    if (_retrieveDataError != null) {
      final Text result = Text(_retrieveDataError);
      _retrieveDataError = null;
      return result;
    }
    return null;
  }

  void showSheet(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            height: 140.0,
            color: Color(0x00ff3E4346),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                FloatingActionButton(
                  onPressed: () {
                    _onImageButtonPressed(ImageSource.gallery,
                        context: context);
                    Navigator.of(context).pop();
                  },
                  backgroundColor: Color(0x00ffA60000),
                  heroTag: 'image0',
                  tooltip: 'Pick Image from gallery',
                  child: const Icon(Icons.photo_library),
                ),
                FloatingActionButton(
                  onPressed: () {
                    _onImageButtonPressed(ImageSource.camera, context: context);
                    Navigator.of(context).pop();
                  },
                  backgroundColor: Color(0x00ffA60000),
                  heroTag: 'image1',
                  tooltip: 'Take a Photo',
                  child: const Icon(Icons.camera_alt),
                ),
              ],
            ),
          );
        });
  }

  Future<DocumentSnapshot> _fetch() async =>
      await FirebaseRepo.instance.fetchWorkerDataFromDb();

  void _submit() {
    HireModel hireModel = HireModel(
      owner: ownerController?.text,
      address: addressController?.text,
      phoneNumber: phoneController?.text,
      vatId: vatIDController?.text,
      profileImage: _image?.toString(),
      timeZone: '',
    );

    BlocProvider.of<FieldsBloc>(context).add(SubmitButtonHireEvent(
        hireModel: hireModel.toMap(hireModel), file: _image));
  }
}
