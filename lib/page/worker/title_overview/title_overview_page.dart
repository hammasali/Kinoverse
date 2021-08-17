import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kinoverse/app.dart';
import 'package:kinoverse/business_logic/bloc/fields/fields_bloc.dart';
import 'package:kinoverse/common/TextStyleRes.dart';
import 'package:kinoverse/common/common_widget.dart';
import 'package:kinoverse/page/worker/profile_photo/profile_photo_page.dart';

class TitleOverviewPage extends StatefulWidget {
  static const String routeName = '/title_overviewPage';

  @override
  _TitleOverviewPageState createState() => _TitleOverviewPageState();
}

class _TitleOverviewPageState extends State<TitleOverviewPage> {
  var titleController = TextEditingController();
  var profileOverviewController = TextEditingController();
  final _key = GlobalKey<FormState>();

  @override
  void dispose() {
    titleController.dispose();
    profileOverviewController.dispose();
    super.dispose();
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
                  children: <Widget>[gettingStartBtn(), title()],
                ),
              ),
            ),
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
                  App.titleIcon,
                  color: txtColor,
                  height: 20,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 12),
                child: Text("Title & Overview",
                    style:
                        TextStyle(fontSize: 15, fontWeight: FontWeight.w400)),
              ),
            ],
          ),
        ),
      ),
    );
  }

  ///title
  title() {
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
                    "Learn more about writing a great profile or browse profiles in your category",
                fontSize: 12,
                fontWeight: FontWeight.w700),
            SizedBox(
              height: 30,
            ),
            Container(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: Form(
                key: _key,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextStyleRes.textUbuntuStyleFont2(
                        text: "Title",
                        fontSize: 10,
                        fontWeight: FontWeight.w700),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      color: backContainerColor,
                      child: TextFormField(
                        cursorColor: txtColor,
                        controller: titleController,
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
                            hintText: "Example: Editor, Director",
                            hintStyle: TextStyle(
                                fontFamily: App.font2,
                                color: txtDescriptionColor,
                                fontSize: 10,
                                fontWeight: FontWeight.w400)),
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    TextStyleRes.textUbuntuStyleFont2(
                        text: "Professional Overview",
                        fontSize: 10,
                        fontWeight: FontWeight.w700),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      color: backContainerColor,
                      child: TextFormField(
                        cursorColor: txtColor,
                        controller: profileOverviewController,
                        validator: (value) =>
                            value.trim().isEmpty || value == null
                                ? 'Field is empty'
                                : null,
                        maxLines: 8,
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
                            hintMaxLines: 5,
                            hintText:
                                "Highlight your top skills, experience and interests. This is one of the first thing clients will see on your profile",
                            hintStyle: TextStyle(
                                fontFamily: App.font2,
                                color: txtDescriptionColor,
                                fontSize: 10,
                                fontWeight: FontWeight.w400)),
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextStyleRes.textStyleFont1(
                          text: "5000 characters left",
                          fontSize: 10,
                          fontWeight: FontWeight.w400,
                          textColor: txtDescriptionColor),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    MaterialButton(
                      height: 35.0,
                      textColor: txtColor,
                      child: Text(
                        'skip this step',
                        textScaleFactor: 1.0,
                      ),
                      onPressed: () {
                        //CommonRoutePage().gotoProfilePhotoPage(context);

                        Navigator.of(context)
                            .pushNamed(ProfilePhotoPage.routeName);
                      },
                    ),
                  ],
                ),
              ),
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
              //CommonRoutePage().gotoProfilePhotoPage(context);

              if (_key.currentState.validate()) {
                BlocProvider.of<FieldsBloc>(context).add(
                    NextButtonEventScreen10(
                        title: titleController.text,
                        professionalOverview: profileOverviewController.text));

                Navigator.of(context).pushNamed(ProfilePhotoPage.routeName);
              }
            },
          ),
        ],
      ),
    );
  }
}
