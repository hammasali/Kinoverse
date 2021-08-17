import 'package:flutter/material.dart';
import 'package:kinoverse/app.dart';
import 'package:kinoverse/common/StringRes.dart';
import 'package:kinoverse/common/TextStyleRes.dart';
import 'package:kinoverse/common/common_widget.dart';
import 'package:kinoverse/page/hire/home_page/home_page.dart';
import 'package:kinoverse/page/worker/category_page/category_page.dart';

class GettingStartedPage2 extends StatefulWidget {
  static const String routeName = '/getting_startedPage2';

  @override
  _GettingStartedPageState createState() => _GettingStartedPageState();
}

class _GettingStartedPageState extends State<GettingStartedPage2> {
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
              children: <Widget>[
                gettingStartBtn(),
                txtOnly(),
                myProfile(),
              ],
            ),
          ),
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
                  App.download,
                  color: txtColor,
                  height: 20,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 12),
                child: Text("Getting Started",
                    style:
                        TextStyle(fontSize: 15, fontWeight: FontWeight.w400)),
              ),
            ],
          ),
        ),
      ),
    );
  }

  ///txt
  txtOnly() {
    return Padding(
      padding: const EdgeInsets.only(top: 55, left: 20, right: 10),
      child: Text(
          "To provide a hight quality experience to all customers, admission to Kinoverse is highly competitive.",
          style: TextStyle(
              fontSize: 12, fontWeight: FontWeight.w700, color: txtColor)),
    );
  }

  ///myProfile
  myProfile() {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20, top: 30),
      child: Container(
        padding: const EdgeInsets.only(left: 30, right: 20, top: 10),
        color: backContainerColor,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextStyleRes.textUbuntuStyleFont2(
                text: "Let's begin your journey",
                fontSize: 10,
                fontWeight: FontWeight.w700),
            // SizedBox(
            //   height: 25,
            // ),
            // TextStyleRes.textUbuntuStyleFont2(
            //     text: StringRes.linkDIn,
            //     fontSize: 10,
            //     fontWeight: FontWeight.w400),
            SizedBox(
              height: 60,
            ),
            Align(
                alignment: Alignment.center,
                child: Column(
                  children: [
                    InkWell(
                      onTap: () {
                        //CommonRoutePage().gotoCategoryPage(context);
                       Navigator.of(context).pushNamed(CategoryPage.routeName);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: btnColor, width: 1),
                        ),
                        child: CommonWidget.squareButton(
                          text: StringRes.fillOutForm,
                          fontSize: 12.0,
                          height: 40.0,
                          fontWeight: FontWeight.w700,
                          textColor: btnColor,
                        ),
                      ),
                    )
                  ],
                )),
            SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}
