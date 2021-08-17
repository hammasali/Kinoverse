import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kinoverse/app.dart';
import 'package:kinoverse/business_logic/bloc/reg_bloc/reg_bloc.dart';
import 'package:kinoverse/common/StringRes.dart';
import 'package:kinoverse/common/TextStyleRes.dart';
import 'package:kinoverse/core/routes.dart';
import 'package:kinoverse/page/worker/home_page/home_page.dart';

class Login extends StatefulWidget {
  static const String routeName = '/login_page';

  @override
  LoginState createState() => LoginState();
}

class LoginState extends State<Login> {
  TextEditingController loginUserEmailController = TextEditingController();
  TextEditingController loginPasswordController = TextEditingController();
  bool _obscureTextLogin = true;
  MyAppRoutes _myAppRoutes = MyAppRoutes();

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
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.only(top: 60),
          child: ListView(
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Center(
                    child: Image.asset(
                      App.logo,
                      width: MediaQuery.of(context).size.height * 0.4,
                    ),
                  ),
                  buttonRow(context),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buttonRow(context) {
    return Container(
      padding: EdgeInsets.only(top: 30, left: 20, right: 20),
      child: newText(context),
    );
  }

  Widget newText(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;

    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: btnColor, width: 1),
      ),
      child: Container(
        padding: EdgeInsets.only(left: 10, right: 10),
        child: Column(
          children: [
            SizedBox(height: screenSize.height * 0.05),
            GestureDetector(
              onTap: () {
                BlocProvider.of<RegBloc>(context).add(GoogleLoginEvent());
              },
              child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 15),
                  height: 41,
                  decoration: BoxDecoration(
                    border: Border.all(color: btnBorderWhite, width: 1),
                  ),
                  child: Center(
                    child: Row(
                      children: [
                        Stack(
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width / 9.5,
                              decoration: BoxDecoration(
                                border: Border(
                                  right:
                                      BorderSide(width: 1.0, color: btnColor),
                                ),
                                color: Colors.white,
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.only(left: 6.5),
                              child: Center(
                                child: Image.asset(
                                  App.search,
                                  height: 20,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Container(
                          padding: EdgeInsets.only(left: 45),
                          child: Center(
                            child: TextStyleRes.textStyleFont1(
                                textColor: txtColor,
                                text: StringRes.continueGoogle,
                                fontSize: 12.0,
                                fontWeight: FontWeight.w700),
                          ),
                        ),
                      ],
                    ),
                  )),
            ),
            SizedBox(height: 30),
            Text(
              'or',
              style: TextStyle(
                color: txtColor,
                fontSize: 12,
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(height: screenSize.height * 0.05),
            Padding(
              padding: EdgeInsets.only(left: 0, right: 0),
              child: Container(
                height: screenSize.height * 0.07,
                width: screenSize.width * 5,
                decoration: BoxDecoration(
                  color: bgColor,
                  borderRadius: BorderRadius.circular(0),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Center(
                    child: TextFormField(
                      validator: (val) => val.isEmpty || !val.contains("@")
                          ? "enter a valid email"
                          : null,
                      keyboardType: TextInputType.emailAddress,
                      style: TextStyle(color: Colors.white),
                      controller: loginUserEmailController,
                      cursorColor: btnBorderWhite,
                      decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(0)),
                          borderSide:
                              BorderSide(width: 1, color: btnBorderWhite),
                        ),
                        disabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(0)),
                          borderSide:
                              BorderSide(width: 1, color: btnBorderWhite),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(0)),
                          borderSide:
                              BorderSide(width: 1, color: btnBorderWhite),
                        ),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(0)),
                            borderSide: BorderSide(
                              width: 1,
                            )),
                        errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(0)),
                            borderSide:
                                BorderSide(width: 1, color: btnBorderWhite)),
                        focusedErrorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(0)),
                            borderSide:
                                BorderSide(width: 1, color: btnBorderWhite)),
                        labelText: 'Email',
                        labelStyle: TextStyle(
                          color: btnBorderWhite,
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        ),
                        suffixIcon: Padding(
                          padding: const EdgeInsetsDirectional.only(end: 0),
                          child: Image.asset(App.Useremail,
                              height: 20, color: btnBorderWhite),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: screenSize.height * 0.05),
            Padding(
              padding: EdgeInsets.only(left: 0, right: 0),
              child: Container(
                height: screenSize.height * 0.07,
                width: screenSize.width * 5,
                decoration: BoxDecoration(
                    color: bgColor, borderRadius: BorderRadius.circular(0)),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Center(
                    child: TextFormField(
                      validator: (val) =>
                          val.isEmpty ? "enter a valid password" : null,
                      obscureText: _obscureTextLogin,
                      style: TextStyle(color: Colors.white),
                      controller: loginPasswordController,
                      cursorColor: btnBorderWhite,
                      decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(0)),
                          borderSide:
                              BorderSide(width: 1, color: btnBorderWhite),
                        ),
                        disabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(0)),
                          borderSide:
                              BorderSide(width: 1, color: btnBorderWhite),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(0)),
                          borderSide:
                              BorderSide(width: 1, color: btnBorderWhite),
                        ),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(0)),
                            borderSide: BorderSide(
                              width: 1,
                            )),
                        errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(0)),
                            borderSide:
                                BorderSide(width: 1, color: btnBorderWhite)),
                        focusedErrorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(0)),
                            borderSide:
                                BorderSide(width: 1, color: btnBorderWhite)),
                        labelText: 'Password',
                        labelStyle: TextStyle(
                          color: btnBorderWhite,
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        ),
                        suffixIcon: Padding(
                          padding: const EdgeInsetsDirectional.only(end: 7),
                          child: Image.asset(App.Password,
                              //fit: BoxFit.cover,
                              width: 10,
                              height: 10,
                              color: btnBorderWhite),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: screenSize.height * 0.07),

            //===================== BLOC ========================

            BlocConsumer<RegBloc, RegState>(builder: (context, state) {
              if (state is RegInitial) {
                return Container();
              } else if (state is RegLoadingState) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: getCircularProgress(context),
                );
              } else if (state is RegSuccessfulState) {
                return Container();
              } else if (state is RegUnsuccessfulState) {
                return Padding(
                    padding: const EdgeInsets.all(8.0),
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
                          child: Text(
                            state.message,
                            style: TextStyle(color: Colors.red),
                          ),
                        ),
                      ],
                    ));
              }
              return Container();
            }, listener: (context, state) {
              if (state is RegSuccessfulState)
                Navigator.of(context).pushNamedAndRemoveUntil(
                  HomePage.routeName,
                  (route) =>
                      false, //if you want to disable back feature set to false
                );
            }),
            Padding(
              padding: EdgeInsets.only(left: 15, right: 15),
              child: MaterialButton(
                height: screenSize.height * 0.07,
                minWidth: MediaQuery.of(context).size.width,
                elevation: 5,
                color: btnColor,
                textColor: Colors.white,
                child: Text(
                  'LogIn',
                  textScaleFactor: 1.2,
                ),
                onPressed: () {
                  BlocProvider.of<RegBloc>(context).add(LogInButtonPressedEvent(
                      email: loginUserEmailController.text,
                      password: loginPasswordController.text));
                },
              ),
            ),
            SizedBox(height: 30),
            /* Container(
              height: 41,
              decoration: BoxDecoration(
                border: Border.all(color: btnBorderWhite, width: 1),
              ),
              child: Center(
                child: Row(
                  children: [
                    Stack(
                      children: [

                        Container(
                          padding: EdgeInsets.only(left: 6.5),
                          child: Center(
                            child: Image.asset(
                              App.envelope,
                              color: btnBorderWhite,
                              height: 20,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 10),
                      child: TextStyleRes.textStyleFont1(
                          textColor: txtColor,
                          text: StringRes.EnterEmail,
                          fontSize: 12.0,
                          fontWeight: FontWeight.w700),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 30),

            GestureDetector(
              onTap: () {},
              child: Container(
                height: 41,
                decoration: BoxDecoration(
                  border: Border.all(color: btnBorderWhite, width: 1),
                ),
                child: Center(
                  child: Row(
                    children: [
                      Stack(
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width / 9.5,
                            decoration: BoxDecoration(
                              border: Border(
                                right: BorderSide(
                                    width: 1.0, color: btnBorderWhite),
                              ),
                              color: bgColor,
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.only(left: 6.5),
                            child: Center(
                              child: Image.asset(
                                App.envelope,
                                color: btnBorderWhite,
                                height: 20,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Container(
                        padding: EdgeInsets.only(left: 45),
                        child: TextStyleRes.textStyleFont1(
                            textColor: txtColor,
                            text: StringRes.workAddress,
                            fontSize: 12.0,
                            fontWeight: FontWeight.w700),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 37),
            GestureDetector(
              onTap: () {
                CommonRoutePage().gotoSignUp2(context);
              },
              child: Container(
                height: 41,
                decoration: BoxDecoration(
                  color: btnColor,
                ),
                child: Center(
                  child: TextStyleRes.textStyleFont1(
                      textColor: txtColor,
                      text: StringRes.logIn,
                      fontSize: 12.0,
                      fontWeight: FontWeight.w700),
                ),
              ),
            ),
            SizedBox(height: 30),*/
          ],
        ),
      ),
    );
  }
}
