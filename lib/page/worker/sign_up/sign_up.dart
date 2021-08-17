import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kinoverse/app.dart';
import 'package:kinoverse/business_logic/bloc/reg_bloc/reg_bloc.dart';
import 'package:kinoverse/common/StringRes.dart';
import 'package:kinoverse/common/TextStyleRes.dart';
import 'package:kinoverse/core/route_pass.dart';
import 'package:kinoverse/core/routes.dart';
import 'package:kinoverse/page/worker/sign_up/sign_up_2.dart';

class SignUp extends StatefulWidget {
  static const String routeName = '/signUp_page';

  @override
  SignUpState createState() => SignUpState();
}

class SignUpState extends State<SignUp> {
  final emailController = TextEditingController();
  MyAppRoutes _myAppRoutes = MyAppRoutes();

  @override
  void dispose() {
    emailController.text;
    _myAppRoutes.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print("runtimeType -> " + runtimeType.toString());

    return BlocListener<RegBloc, RegState>(
      listener: (context, state) {
        if (state is RegSuccessfulState) {
          Navigator.of(context).pushReplacementNamed(SignUp2.routeName,
              arguments: SignUp2Args(state.user.email, true));
        }
      },
      child: Scaffold(
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
      ),
    );
  }

  Widget buttonRow(context) {
    return Container(
      padding: EdgeInsets.only(top: 30, left: 20, right: 20),
      child: newText(),
    );
  }

  Widget newText() {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: btnColor, width: 1),
      ),
      child: Container(
        padding: EdgeInsets.only(left: 20, right: 20),
        child: Column(
          children: [
            SizedBox(height: 25),
            TextStyleRes.textStyleFont1(
                textColor: txtColor,
                text: StringRes.getFreeAccount,
                fontSize: 16.0,
                fontWeight: FontWeight.w700),
            SizedBox(height: 30),

            //===================  GOOGLE SIGN UP  ==========================
            GestureDetector(
              onTap: () {
                BlocProvider.of<RegBloc>(context).add(GoogleSignInEvent());
              },
              child: Container(
                height: 41,
                decoration: BoxDecoration(
                  border: Border.all(color: btnColor, width: 1),
                ),
                child: Row(
                  children: [
                    Stack(
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width / 9.5,
                          decoration: BoxDecoration(
                            border: Border(
                              right: BorderSide(width: 1.0, color: btnColor),
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
              ),
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
            SizedBox(height: 32),
            Container(
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
                                  BorderSide(width: 1.0, color: btnBorderWhite),
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
                    Expanded(
                      child: Container(
                          // padding: EdgeInsets.only(left: 45),
                          width: MediaQuery.of(context).size.width / 1.5,
                          child: TextFormField(
                            controller: emailController,
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
                                hintText: "Work email address",
                                hintStyle: TextStyle(
                                  fontFamily: App.font1,
                                  color: txtColor,
                                  fontSize: 13,
                                )),
                          )),
                    ),
                    //   child: TextStyleRes.textStyleFont1(
                    //       textColor: txtColor,
                    //       text: StringRes.workAddress,
                    //       fontSize: 12.0,
                    //       fontWeight: FontWeight.w700),
                    // ),
                  ],
                ),
              ),
            ),
            // SizedBox(height: 32),
            // GestureDetector(
            //   onTap: () {
            //     CommonRoutePage().gotoLogin(context);
            //   },
            //   child: Container(
            //     height: 41,
            //     decoration: BoxDecoration(
            //       border: Border.all(color: btnBorderWhite, width: 1),
            //     ),
            //     child: Center(
            //       child:TextStyleRes.textStyleFont1(
            //           textColor: txtColor,
            //           text: StringRes.loginWithEmail,
            //           fontSize: 12.0,
            //           fontWeight: FontWeight.w700),
            //     ),
            //   ),
            // ),
            SizedBox(height: 37),
            GestureDetector(
              onTap: () {
                //CommonRoutePage().gotoSignUp2(context);

                if (EmailValidator.validate(emailController.text)) {
                  Navigator.of(context).pushNamed(SignUp2.routeName,
                      arguments: SignUp2Args(emailController.text, false));
                } else
                  _scaffoldError();
              },
              child: Container(
                height: 41,
                decoration: BoxDecoration(
                  color: btnColor,
                ),
                child: Center(
                  child: TextStyleRes.textStyleFont1(
                      textColor: txtColor,
                      text: StringRes.continueEmail,
                      fontSize: 12.0,
                      fontWeight: FontWeight.w700),
                ),
              ),
            ),
            SizedBox(height: 18),
          ],
        ),
      ),
    );
  }

  _scaffoldError() {
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        duration: Duration(milliseconds: 300),
        content: Text(
          "Invalid email address",
          style: TextStyle(
            fontFamily: App.font1,
            fontSize: 13,
          ),
        )));
  }
}
