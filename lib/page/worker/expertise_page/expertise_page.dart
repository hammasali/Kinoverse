import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kinoverse/business_logic/bloc/fields/fields_bloc.dart';
import 'package:kinoverse/common/TextStyleRes.dart';
import 'package:kinoverse/common/common_widget.dart';
import 'package:kinoverse/core/routes.dart';
import 'package:kinoverse/page/worker/expertise_page/expertise_level_page.dart';
import 'package:kinoverse/page/worker/profile_overview/profile_overview_page.dart';

import '../../../app.dart';

class ExpertisePage extends StatefulWidget {
  static const String routeName = '/expertise_page';
  final bool edit;

  ExpertisePage([this.edit]);

  @override
  _ExpertisePageState createState() => _ExpertisePageState();
}

class _ExpertisePageState extends State<ExpertisePage> {
  var skillsController = TextEditingController();

  final key = GlobalKey<FormState>();
  MyAppRoutes _myAppRoutes = MyAppRoutes();

  List<String> tags = [];

  @override
  void dispose() {
    skillsController.dispose();
    _myAppRoutes.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print("runtimeType -> " + runtimeType.toString());
    return Scaffold(
      backgroundColor: bgColor,
      body: Container(
        padding: EdgeInsets.only(top: 60),
        height: MediaQuery.of(context).size.height,
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(children: <Widget>[
                  gettingStartBtn(),
                  myServices(),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 20, right: 20, top: 10, bottom: 10),
                    child: Wrap(
                      spacing: 8.0, // gap between adjacent chips
                      runSpacing: 4.0, // gap between lines
                      children: <Widget>[...generate_tags()],
                    ),
                  ),
                  // Spacer(),
                ]),
              ),
            ),

            // =======================  BLOC  ======================
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
                  App.expertiseIcon,
                  color: txtColor,
                  height: 20,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 12),
                child: Text("Expertise",
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
        padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
        color: backContainerColor,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // TextStyleRes.textUbuntuStyleFont2(
            //     text: "Tell us about the work you do.",
            //     fontSize: 12,
            //     fontWeight: FontWeight.w400),
            // SizedBox(
            //   height: 25,
            // ),
            TextStyleRes.textStyleFont1(
                textColor: txtColor,
                text: "Tell us about some of your skills",
                fontSize: 12,
                fontWeight: FontWeight.w700),
            SizedBox(
              height: 20,
            ),
            Container(
                decoration: BoxDecoration(
                  border: Border.all(color: btnColor, width: 1),
                ),
                child: Form(
                  key: key,
                  child: TextFormField(
                    validator: (value) => value.trim().isEmpty || value == null
                        ? 'Field is empty'
                        : null,
                    cursorColor: txtColor,
                    controller: skillsController,
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
                          bottom: 11,
                          top: 11,
                        ),
                        hintText: "Type Things like: Final Cut Pro,or...",
                        hintStyle: TextStyle(
                            fontFamily: App.font2,
                            color: txtColor,
                            fontSize: 10,
                            fontWeight: FontWeight.w400)),
                  ),
                )),
            SizedBox(
              height: 10,
            ),
            Align(
              alignment: Alignment.center,
              child: MaterialButton(
                height: 35.0,
                color: btnColor,
                textColor: Colors.white,
                child: Text(
                  'ADD',
                  textScaleFactor: 1.0,
                ),
                onPressed: () {
                  if (key.currentState.validate()) {
                    if (!tags.contains(skillsController?.text)) {
                      setState(() {
                        tags.add(skillsController?.text);
                      });

                      skillsController.text = '';
                    }
                  }
                },
              ),
            ),
            SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }

  ///list
  generate_tags() {
    return tags.map((tag) => get_chip(tag)).toList();
  }

  get_chip(name) {
    return InputChip(
      // backgroundColor: backContainerColor,
      // labelStyle: TextStyle(color: Colors.white),
      label: Text("${name}"),
      deleteIcon: Image.asset(App.closeCircleDark),
      deleteIconColor: Colors.white,
      onSelected: (bool value) {},
      onDeleted: () {
        setState(() {
          tags.remove(name);
        });
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
              //CommonRoutePage().gotoExpertiseLevelPage(context);
              BlocProvider.of<FieldsBloc>(context)
                  .add(NextButtonEventScreen4(tags));

              if (widget?.edit == null && tags.isNotEmpty)
                Navigator.of(context).pushNamed(ExpertiseLevelPage.routeName);
              // else
              //   ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              //     content: const Text('Please Provide Education '),
              //   ));
            },
          ),
        ],
      ),
    );
  }
}
