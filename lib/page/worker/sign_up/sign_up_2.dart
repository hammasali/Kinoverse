import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kinoverse/app.dart';
import 'package:kinoverse/business_logic/bloc/reg_bloc/reg_bloc.dart';
import 'package:kinoverse/common/StringRes.dart';
import 'package:kinoverse/common/TextStyleRes.dart';
import 'package:kinoverse/common/common_widget.dart';
import 'package:kinoverse/core/route_pass.dart';
import 'package:kinoverse/core/routes.dart';
import 'package:kinoverse/page/hire/signup_pgae/signup_page.dart';
import 'package:kinoverse/page/worker/getting_started_page/getting_started_page1.dart';

class SignUp2 extends StatefulWidget {
  static const String routeName = '/signUp2_page';
  final String email;
  final bool isGoogle;

  SignUp2([this.email, this.isGoogle]);

  @override
  _SignUp2State createState() => _SignUp2State();
}

class _SignUp2State extends State<SignUp2> {
  bool check1 = false;
  bool check2 = true;
  bool isWorkerSignup = true;
  String countryName = 'Indonesia';

  TextEditingController userNameController = TextEditingController();
  TextEditingController displayNameController = TextEditingController();
  TextEditingController userPasswordController = TextEditingController();
  MyAppRoutes _myAppRoutes = MyAppRoutes();

  @override
  void dispose() {
    userNameController.dispose();
    userPasswordController.dispose();
    displayNameController.dispose();
    _myAppRoutes.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print("runtimeType -> " + runtimeType.toString());
    return Scaffold(
      backgroundColor: bgColor,
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.only(top: 60),
          child: SingleChildScrollView(
            child: Column(
              // mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                ///go to dashboard scren
                GestureDetector(
                  onTap: () {
                    //CommonRoutePage.goToScreen(context, DashBoardPage(0));
                  },
                  child: Center(
                    child: Image.asset(
                      App.logo,
                      width: MediaQuery.of(context).size.height * 0.4,
                    ),
                  ),
                ),
                SizedBox(
                  height: 25,
                ),
                Container(
                  // height: MediaQuery.of(context).size.height / 1.3500,
                  width: MediaQuery.of(context).size.width / 1.1,
                  decoration: BoxDecoration(
                    border: Border.all(color: btnColor, width: 1),
                  ),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      TextStyleRes.textStyleFont1(
                        textColor: txtColor,
                        text: StringRes.completeFreeAccountSetup,
                        fontSize: 16.0,
                        fontWeight: FontWeight.w700,
                      ),
                      SizedBox(
                        height: 10,
                      ),

                      //============================ EMAIL FIELD ===========================
                      Row(
                        children: [
                          Padding(
                            padding:
                                const EdgeInsets.only(left: 40.0, right: 2),
                            child: CircleAvatar(
                              backgroundColor: btnBorderWhite,
                              radius: 20,
                              child: Center(
                                  child: Image.asset(
                                App.Useremail,
                                height: 20,
                                width: 20,
                              )),
                            ),
                          ),
                          Container(
                              width: MediaQuery.of(context).size.width / 1.5,
                              child: TextFormField(
                                readOnly: true,
                                cursorColor: txtColor,
                                style: TextStyle(
                                  fontFamily: App.font1,
                                  color: txtColor,
                                  fontSize: 13,
                                ),
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
                                    hintText: widget.email,
                                    hintStyle: TextStyle(
                                      fontFamily: App.font1,
                                      color: txtColor,
                                      fontSize: 13,
                                    )),
                              )),
                        ],
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      //============================ USERNAME FIELD ===========================

                      Visibility(
                        visible: !widget.isGoogle,
                        child: Row(
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 40.0, right: 2),
                              child: CircleAvatar(
                                backgroundColor: btnBorderWhite,
                                radius: 20,
                                child: Center(
                                    child: Image.asset(
                                  App.edit,
                                  height: 20,
                                  width: 20,
                                )),
                              ),
                            ),
                            Container(
                                width: MediaQuery.of(context).size.width / 1.5,
                                child: TextFormField(
                                  controller: userNameController,
                                  cursorColor: txtColor,
                                  style: TextStyle(
                                    fontFamily: App.font1,
                                    color: txtColor,
                                    fontSize: 13,
                                  ),
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
                                      hintText: "Username",
                                      hintStyle: TextStyle(
                                        fontFamily: App.font1,
                                        color: txtColor,
                                        fontSize: 13,
                                      )),
                                )),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 8,
                      ),

                      //============================ DISPLAY NAME FIELD ===========================

                      Visibility(
                        visible: !widget.isGoogle,
                        child: Row(
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 40.0, right: 2),
                              child: CircleAvatar(
                                backgroundColor: btnBorderWhite,
                                radius: 20,
                                child: Center(
                                    child: Image.asset(
                                  App.edit,
                                  height: 20,
                                  width: 20,
                                )),
                              ),
                            ),
                            Container(
                                width: MediaQuery.of(context).size.width / 1.5,
                                child: TextFormField(
                                  controller: displayNameController,
                                  cursorColor: txtColor,
                                  style: TextStyle(
                                    fontFamily: App.font1,
                                    color: txtColor,
                                    fontSize: 13,
                                  ),
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
                                      hintText: "displayname",
                                      hintStyle: TextStyle(
                                        fontFamily: App.font1,
                                        color: txtColor,
                                        fontSize: 13,
                                      )),
                                )),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 8,
                      ),

                      //============================ PASSWORD FIELD ===========================
                      Visibility(
                        visible: !widget.isGoogle,
                        child: Row(
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 40.0, right: 2),
                              child: CircleAvatar(
                                backgroundColor: btnBorderWhite,
                                radius: 20,
                                child: Center(
                                    child: Image.asset(
                                  App.Password,
                                  height: 20,
                                  width: 20,
                                )),
                              ),
                            ),
                            Container(
                                width: MediaQuery.of(context).size.width / 1.5,
                                child: TextFormField(
                                  controller: userPasswordController,
                                  obscureText: true,
                                  cursorColor: txtColor,
                                  style: TextStyle(
                                    fontFamily: App.font1,
                                    color: txtColor,
                                    fontSize: 13,
                                  ),
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
                                      hintText: "password",
                                      hintStyle: TextStyle(
                                        fontFamily: App.font1,
                                        color: txtColor,
                                        fontSize: 13,
                                      )),
                                )),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 8,
                      ),

                      //============================ COUNTRY PICKER ===========================

                      GestureDetector(
                        behavior: HitTestBehavior.translucent,
                        onTap: () => _countryPicker(context),
                        child: Container(
                          padding:
                              const EdgeInsets.only(left: 20.0, right: 20.0),
                          child: Container(
                            height: 58,
                            width: MediaQuery.of(context).size.width - 10,
                            decoration: BoxDecoration(
                              color: bgColor,
                              boxShadow: [
                                BoxShadow(
                                    color: shadowColorBlack,
                                    spreadRadius: 1,
                                    blurRadius: 6)
                              ],
                            ),
                            child: Container(
                              child: ListTile(
                                leading: Container(
                                    height: 20, child: Image.asset(App.vactor)),
                                title: TextStyleRes.textStyleFont1(
                                    textColor: txtColor,
                                    textAlign: TextAlign.left,
                                    fontSize: 12,
                                    //text: StringRes.indonesia
                                    text: countryName),
                                trailing: Icon(
                                  Icons.keyboard_arrow_down_outlined,
                                  color: txtColor,
                                  size: 20,
                                ),
                                //backgroundColor: bgColor,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      TextStyleRes.textUbuntuStyleFont2(
                          text: StringRes.iWantTo, fontSize: 12),
                      SizedBox(
                        height: 15,
                      ),

                      //============================ IS WORKER?? FIELD ===========================

                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CommonWidget.squareButton(
                            containerColor:
                                isWorkerSignup ? txtColor : btnColor,
                            fontSize: 12.0,
                            height: 40.0,
                            width: 100.0,
                            fontWeight: FontWeight.w700,
                            text: StringRes.hire,
                            textColor: isWorkerSignup ? colorBlack : txtColor,
                            onTap: () {
                              setState(() {
                                isWorkerSignup = false;
                              });
                            },
                          ),
                          CommonWidget.squareButton(
                            containerColor:
                                isWorkerSignup ? btnColor : txtColor,
                            fontSize: 12.0,
                            height: 40.0,
                            width: 100.0,
                            fontWeight: FontWeight.w700,
                            text: StringRes.work,
                            textColor: isWorkerSignup ? txtColor : colorBlack,
                            onTap: () {
                              setState(() {
                                isWorkerSignup = true;
                              });
                            },
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 15,
                      ),

                      //============================ AGREEMENT FIELD ===========================

                      Container(
                        width: 280,
                        child: CheckboxListTile(
                          title: TextStyleRes.textUbuntuStyleFont2(
                            fontSize: 12,
                            text: StringRes.sendMeUsefulEmail,
                          ),
                          value: check1,
                          onChanged: (newValue1) {
                            setState(() {
                              check1 = newValue1;
                            });
                          },
                          controlAffinity: ListTileControlAffinity.leading,
                          //  <-- leading Checkbox
                          activeColor: btnColor,
                        ),
                      ),
                      Container(
                        width: 280,
                        color: backContainerColor,
                        child: CheckboxListTile(
                          title: TextStyleRes.textUbuntuStyleFont2(
                            fontSize: 12,
                            text: StringRes.privacyPolicyAgreement,
                          ),
                          value: check2,
                          onChanged: (newValue2) {
                            setState(() {
                              check2 = newValue2;
                            });
                          },
                          activeColor: btnColor,
                          controlAffinity: ListTileControlAffinity
                              .leading, //  <-- leading Checkbox
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),

// ================================ BLOC =====================================
                      BlocConsumer<RegBloc, RegState>(
                          builder: (context, state) {
                        if (state is RegInitial) {
                          return Container();
                        } else if (state is RegLoadingState) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: CircularProgressIndicator.adaptive(
                              strokeWidth: 1.1,
                              backgroundColor: Color(0x00ffA60000),
                              valueColor: new AlwaysStoppedAnimation<Color>(
                                  Color(0x00ffffffff)),
                            ),
                          );
                        } else if (state is RegSuccessfulState) {
                          return Container();
                        } else if (state is RegUnsuccessfulState) {
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
                      }, listener: (context, state) {
                        if (state is RegSuccessfulState)
                          //   if (isWorkerSignup) {
                          //   CommonRoutePage().gotoGettingStartedPage1(context);
                          // } else {
                          //   CommonRoutePage().gotoHireSignupPage(context);
                          // }
                          isWorkerSignup
                              ? Navigator.of(context).pushNamedAndRemoveUntil(
                                  GettingStartedPage1.routeName,
                                  (route) => false,
                                ) //if you want to disable back feature set to false)
                              : Navigator.of(context).pushNamedAndRemoveUntil(
                                  // MaterialPageRoute(
                                  //     builder: (_) => SignUpScreenHire(
                                  //           name: userNameController.text,
                                  //           country: '',
                                  //         )),
                                  HireSignupPage.routeName,
                                  (route) => false,
                                  arguments: HireSignupPageArgs(
                                      userNameController.text.trim(),
                                      countryName) //if you want to disable back feature set to false
                                  );
                      }),

                      //============================ CREATE BUTTON FIELD ===========================

                      CommonWidget.squareButton(
                        text: StringRes.createAccount,
                        fontSize: 14.0,
                        height: 40.0,
                        width: 200.0,
                        containerColor: btnColor,
                        textColor: txtColor,
                        onTap: () {
                          _createAccount();
                        },
                      ),
                      SizedBox(
                        height: 15,
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _createAccount() {
    var profileState;

    if (isWorkerSignup)
      profileState = 'work';
    else
      profileState = 'hire';

    if (widget.isGoogle) {
      BlocProvider.of<RegBloc>(context).add(CreateAccountEvent(
          country: countryName,
          profileState: profileState,
          check1: check1,
          check2: check2));
    } else {
      BlocProvider.of<RegBloc>(context).add(CreateAccountEvent(
          name: displayNameController.text,
          email: widget.email,
          password: userPasswordController.text,
          username: userNameController.text,
          country: countryName,
          profileState: profileState,
          anonymousSignIn: true,
          check1: check1,
          check2: check2));
    }

    print('${widget.email} \n '
        '${userNameController.text} \n '
        '${displayNameController.text} \n '
        '${userPasswordController.text} \n'
        '$profileState \n'
        '$check1 \n'
        '$check2');
  }

  void _countryPicker(BuildContext context) {
    showCountryPicker(
        context: context,
        showPhoneCode: false,
        onSelect: (Country country) {
          setState(() {
            countryName = country.name;
          });
          print('Select country: ${country.displayName}');
        },
        countryListTheme: CountryListThemeData(
          flagSize: 18.0,
          textStyle: TextStyle(
            color: txtColor,
            fontSize: 14,
          ),
          borderRadius: BorderRadius.zero,
          backgroundColor: Color(0x00ff3E4346),
          inputDecoration: InputDecoration(
            labelText: 'Search',
            hintText: 'Start typing to search',
            labelStyle: TextStyle(
              color: const Color(0xFF8C98A8),
              fontSize: 14,
            ),
            prefixIcon: Theme(
                data: Theme.of(context)
                    .copyWith(primaryColor: Color(0x00ffA60000)),
                child: const Icon(Icons.search)),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: const Color(0xFF8C98A8)),
            ),
            border: OutlineInputBorder(
              borderSide: BorderSide(
                color: const Color(0xFF8C98A8).withOpacity(0.2),
              ),
            ),
          ),
        ));
  }
}
