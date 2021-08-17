import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kinoverse/app.dart';
import 'package:kinoverse/business_logic/cubit/fields_profile_photo_cubit/fields_photo_cubit.dart';
import 'package:kinoverse/common/TextStyleRes.dart';
import 'package:kinoverse/common/common_widget.dart';
import 'package:kinoverse/core/routes.dart';
import 'package:kinoverse/page/worker/location/location_page.dart';

class ProfilePhotoPage extends StatefulWidget {
  static const String routeName = '/profilePhoto_page';

  @override
  _ProfilePhotoPageState createState() => _ProfilePhotoPageState();
}

class _ProfilePhotoPageState extends State<ProfilePhotoPage> {
  File _image;
  PickedFile _imageFile;
  dynamic _pickImageError;
  String _retrieveDataError;
  MyAppRoutes _appRoutes = MyAppRoutes();

  final ImagePicker _picker = ImagePicker();

  @override
  void dispose() {
    super.dispose();
    _appRoutes.dispose();
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
              return Container();
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
                  children: <Widget>[
                    gettingStartBtn(),
                    profile(),
                  ],
                ),
              ),
            ),

            //============================ BLOC ===============================

            BlocConsumer<FieldsPhotoCubit, FieldsPhotoState>(
                bloc: BlocProvider.of<FieldsPhotoCubit>(context),
                builder: (context, state) {
                  if (state is FieldsPhotoInitial) {
                    return Container();
                  } else if (state is FieldsPhotoLoading) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextStyleRes.textStyleFont1(
                            textColor: Colors.white,
                            text: 'Uploading...',
                            fontSize: 12,
                            fontWeight: FontWeight.w800),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: getCircularProgress(context),
                        ),
                      ],
                    );
                  } else if (state is FieldsPhotoSuccessfulState) {
                    return Container();
                  } else if (state is FieldsPhotoUnsuccessfulState) {
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
                  if (state is FieldsPhotoSuccessfulState)
                    return Navigator.of(context)
                        .pushNamed(LocationPage.routeName);
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
                  App.profilePhotoIcon,
                  color: txtColor,
                  height: 20,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 12),
                child: Text("Profile Photo",
                    style:
                        TextStyle(fontSize: 15, fontWeight: FontWeight.w400)),
              ),
            ],
          ),
        ),
      ),
    );
  }

  ///profile
  profile() {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20, top: 55),
      child: Container(
        padding: const EdgeInsets.only(left: 0, right: 0, top: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextStyleRes.textStyleFont1(
                textColor: txtColor,
                text:
                    "Please upload a professional portrait that clearly shows your face",
                fontSize: 12,
                fontWeight: FontWeight.w700),
            SizedBox(
              height: 30,
            ),
            Center(
              child: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Container(
                    //   height: 80,
                    //   width: 80,
                    //   decoration: BoxDecoration(
                    //       borderRadius: BorderRadius.circular(40),
                    //       color: btnColor),
                    //   child: Center(
                    //       child: Icon(
                    //     Icons.account_circle_outlined,
                    //     color: Colors.white,
                    //     size: 70,
                    //   )),
                    // ),
                    _imageUpload,
                    SizedBox(
                      height: 10,
                    ),
                    InkWell(
                      onTap: () {
                        showSheet(context);
                      },
                      child: Container(
                        width: 200,
                        decoration: BoxDecoration(
                          border: Border.all(color: btnColor, width: 1),
                        ),
                        height: 30.0,
                        padding: const EdgeInsets.only(left: 20, right: 20),
                        child: CommonWidget.squareButton(
                          text: "Upload Profile Photo",
                          fontSize: 12.0,
                          textColor: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            MaterialButton(
              height: 35.0,
              textColor: txtColor,
              child: Text(
                'skip this step',
                textScaleFactor: 1.0,
              ),
              onPressed: () {
                //CommonRoutePage().gotoLocationPage(context);
                Navigator.of(context).pushNamed(LocationPage.routeName);
              },
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
          Spacer(),
          BlocBuilder<FieldsPhotoCubit, FieldsPhotoState>(
            bloc: BlocProvider.of<FieldsPhotoCubit>(context),
            builder: (context, state) {
              if (state is FieldsPhotoInitial) {
                return MaterialButton(
                  height: 35.0,
                  elevation: 5,
                  color: btnColor,
                  textColor: Colors.white,
                  child: Text(
                    'NEXT',
                    textScaleFactor: 1.0,
                  ),
                  onPressed: () {
                    // CommonRoutePage().gotoLocationPage(context);
                    BlocProvider.of<FieldsPhotoCubit>(context)
                        .NextButtonEventScreen11(_image);
                  },
                );
              } else if (state is FieldsPhotoLoading) {
                return MaterialButton(
                  height: 35.0,
                  elevation: 5,
                  color: Colors.grey,
                  textColor: Colors.white,
                  child: Text(
                    'NEXT',
                    textScaleFactor: 1.0,
                  ),
                  onPressed: () => null,
                );
              }
              return MaterialButton(
                height: 35.0,
                elevation: 5,
                color: btnColor,
                textColor: Colors.white,
                child: Text(
                  'NEXT',
                  textScaleFactor: 1.0,
                ),
                onPressed: () {
                  // CommonRoutePage().gotoLocationPage(context);
                  BlocProvider.of<FieldsPhotoCubit>(context)
                      .NextButtonEventScreen11(_image);
                },
              );
            },
          ),
        ],
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
          label: 'image_picker_example_picked_image');
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
}
