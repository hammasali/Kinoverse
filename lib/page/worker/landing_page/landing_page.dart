import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:kinoverse/app.dart';
import 'package:kinoverse/model/slider_item.dart';
import 'package:kinoverse/page/worker/login_page/login.dart';
import 'package:kinoverse/page/worker/sign_up/sign_up.dart';

import 'landing_page_model.dart';

class LandingPage extends StatefulWidget {
  static const String routeName = '/landing_page';

  @override
  LandingPageState createState() => LandingPageState();
}

class LandingPageState extends State<LandingPage> {
  LandingPageViewModel model;

  @override
  Widget build(BuildContext context) {
    print("runtimeType -> " + runtimeType.toString());
    model ?? (model = LandingPageViewModel(this));

    return Scaffold(
      bottomNavigationBar: buttonRow(),
      backgroundColor: bgColor,
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.only(top: 60),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Center(
                child: Image.asset(
                  App.logo,
                  width: MediaQuery.of(context).size.height * 0.4,
                ),
              ),
              Expanded(
                child: Swiper(
                  autoplayDelay: 7000,
                  autoplayDisableOnInteraction: true,
                  autoplay: true,
                  duration: 3000,
                  loop: false,
                  physics: BouncingScrollPhysics(),
                  itemCount: listSlide.length,
                  itemBuilder: (context, index) {
                    return Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Container(
                            height: MediaQuery.of(context).orientation ==
                                    Orientation.portrait
                                ? MediaQuery.of(context).size.height * 0.4
                                : MediaQuery.of(context).size.height * 0.2,
                            width: MediaQuery.of(context).size.width,
                            padding: EdgeInsets.all(15),
                            child: Image.asset(
                              model.image[index],
                              width: 500,
                            )),
                        Container(
                          margin: EdgeInsets.only(top: 10),
                          child: Text(
                            model.title[index],
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: txtColor,
                              fontWeight: FontWeight.w700,
                              fontFamily: App.font2,
                              fontSize: 14,
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 15, left: 50, right: 50),
                          child: Text(
                            model.subTitle[index],
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: txtDescriptionColor,
                              fontSize: 12,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                  pagination: new SwiperPagination(
                    margin: EdgeInsets.only(bottom: 35),
                    builder: new DotSwiperPaginationBuilder(
                      color: btnColor,
                      activeColor: txtColor,
                      activeSize: 8.0,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

// =====================       BOTTOM ROW OF BUTTON        ========================

  Widget buttonRow() {
    return Container(
      padding: EdgeInsets.only(left: 20, right: 20),
      height: MediaQuery.of(context).size.height / 10.0,
      child: Column(
        children: [
          loginButton(),
          Container(
            padding: EdgeInsets.only(top: 10, bottom: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [newText(), signUp()],
            ),
          )
        ],
      ),
    );
  }

// =====================       LOGIN BUTTON        ========================

  Widget loginButton() {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          // CommonRoutePage().gotoLogin(context);
          //CommonRoutePage.goToScreen(context,HireSignUp());
          Navigator.of(context).pushNamed(Login.routeName);
        },
        child: Container(
          height: 35,
          decoration: BoxDecoration(
            color: btnColor,
          ),
          child: Center(
            child: Text(
              'Login',
              style: TextStyle(
                  color: txtColor, fontSize: 16, fontWeight: FontWeight.w700),
            ),
          ),
        ),
      ),
    );
  }

// =====================       Sign Up        ========================

  Widget newText() {
    return Text(
      'New to the Kinoverse?   ',
      style: TextStyle(
          color: txtColor,
          fontSize: 12,
          fontWeight: FontWeight.w400,
          fontFamily: App.font2),
    );
  }

  Widget signUp() {
    return GestureDetector(
      onTap: () {
        // CommonRoutePage().gotoSignUp(context);
        Navigator.of(context).pushNamed(SignUp.routeName);
      },
      child: Text(
        'Sign Up',
        style: TextStyle(
            color: txtColor, fontSize: 12, fontWeight: FontWeight.w700),
      ),
    );
  }
}
