import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kinoverse/app.dart';
import 'package:kinoverse/business_logic/bloc/fields/fields_bloc.dart';
import 'package:kinoverse/common/TextStyleRes.dart';
import 'package:kinoverse/common/common_widget.dart';
import 'package:kinoverse/core/routes.dart';
import 'package:kinoverse/page/worker/profile_overview/profile_overview_page.dart';
import 'package:kinoverse/page/worker/title_overview/title_overview_page.dart';

class HourlyRatePage extends StatefulWidget {
  static const String routeName = '/hourly_ratePage';
  final bool edit;

  HourlyRatePage([this.edit]);

  @override
  _HourlyRatePageState createState() => _HourlyRatePageState();
}

class _HourlyRatePageState extends State<HourlyRatePage> {
  var _textController = TextEditingController();
  var rate = 0.00, service = 0.00, received = 0.00;
  String valueCheck;
  MyAppRoutes _myAppRoutes = MyAppRoutes();

  @override
  void dispose() {
    _myAppRoutes.dispose();
    _textController.dispose();
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
                  children: <Widget>[gettingStartBtn(), rates()],
                ),
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
                  App.hourlyRateIcon,
                  color: txtColor,
                  height: 20,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 12),
                child: Text("Hourly Rate",
                    style:
                        TextStyle(fontSize: 15, fontWeight: FontWeight.w400)),
              ),
            ],
          ),
        ),
      ),
    );
  }

  ///rates
  rates() {
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
                    "Clients will see this rate on your profile and in search results once you publish your profile. You can adjust your rate everytime you submit a proposal",
                fontSize: 12,
                fontWeight: FontWeight.w700),
            SizedBox(
              height: 30,
            ),
            Container(
              padding: const EdgeInsets.only(
                  left: 10, right: 10, top: 10, bottom: 10),
              color: backContainerColor,
              child: Row(
                children: [
                  Container(
                    width: 200,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextStyleRes.textUbuntuStyleFont2(
                            text: "Hourly Rate",
                            fontSize: 10,
                            fontWeight: FontWeight.w400),
                        SizedBox(
                          height: 5,
                        ),
                        TextStyleRes.textUbuntuStyleFont3(
                            txtColor: txtDescriptionColor,
                            text: "Total amount the client will see",
                            fontSize: 10,
                            fontWeight: FontWeight.w400),
                      ],
                    ),
                  ),
                  Spacer(),
                  Container(
                    width: 70,
                    height: 25,
                    decoration: BoxDecoration(
                      border: Border.all(color: btnColor, width: 1),
                    ),
                    padding: const EdgeInsets.only(left: 5, right: 5),
                    child: Row(
                      children: [
                        TextStyleRes.textUbuntuStyleFont2(
                            text: "\$",
                            fontSize: 10,
                            fontWeight: FontWeight.w400),
                        Container(
                          width: 50,
                          child: TextFormField(
                            cursorColor: txtColor,
                            textAlign: TextAlign.right,
                            // validator: (value) =>
                            //     value.trim().isEmpty || value == null
                            //         ? ''
                            //         : null,
                            onChanged: (value) {
                              if (value.trim().isNotEmpty || value != null)
                                valueCheck = value;

                              print(valueCheck);

                              hourlyRate(value);
                            },
                            style: TextStyle(
                              fontFamily: App.font2,
                              color: txtColor,
                              fontSize: 10,
                            ),
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              focusedBorder: InputBorder.none,
                              enabledBorder: InputBorder.none,
                              errorBorder: InputBorder.none,
                              disabledBorder: InputBorder.none,
                              hintText: "$rate",
                              hintStyle: TextStyle(
                                fontFamily: App.font2,
                                color: txtColor,
                                fontSize: 10,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  TextStyleRes.textUbuntuStyleFont2(
                      text: "/hr", fontSize: 10, fontWeight: FontWeight.w400)
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              padding: const EdgeInsets.only(
                  left: 10, right: 10, top: 10, bottom: 10),
              color: backContainerColor,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: 200,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextStyleRes.textUbuntuStyleFont2(
                            text: "Kinoverse Service Fee",
                            fontSize: 10,
                            fontWeight: FontWeight.w400),
                        SizedBox(
                          height: 5,
                        ),
                        TextStyleRes.textUbuntuStyleFont3(
                            txtColor: txtDescriptionColor,
                            text:
                                "The Kinoverse Service Fee is 15% when you begain a contract with a new client. Once you bill over \$500 with your client, the fee will be 10%.",
                            fontSize: 10,
                            fontWeight: FontWeight.w400),
                      ],
                    ),
                  ),
                  Spacer(),
                  Container(
                    width: 70,
                    height: 25,
                    padding: const EdgeInsets.only(left: 5, right: 5),
                    child: Row(
                      children: [
                        TextStyleRes.textUbuntuStyleFont2(
                            text: "\$",
                            fontSize: 10,
                            fontWeight: FontWeight.w400),
                        Container(
                          width: 50,
                          child: TextField(
                            readOnly: true,
                            cursorColor: txtColor,
                            textAlign: TextAlign.right,
                            style: TextStyle(
                              fontFamily: App.font2,
                              color: txtColor,
                              fontSize: 10,
                            ),
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              focusedBorder: InputBorder.none,
                              enabledBorder: InputBorder.none,
                              errorBorder: InputBorder.none,
                              disabledBorder: InputBorder.none,
                              hintText: '- ${service.toStringAsFixed(2)}',
                              hintStyle: TextStyle(
                                fontFamily: App.font2,
                                color: txtColor,
                                fontSize: 10,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Expanded(
                    child: SizedBox(
                      width: 5,
                    ),
                  ),
                  TextStyleRes.textUbuntuStyleFont2(
                      text: "/hour", fontSize: 10, fontWeight: FontWeight.w400),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              padding: const EdgeInsets.only(
                  left: 10, right: 10, top: 10, bottom: 10),
              color: backContainerColor,
              child: Row(
                children: [
                  Container(
                    width: 200,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextStyleRes.textUbuntuStyleFont2(
                            text: "You'll receive",
                            fontSize: 10,
                            fontWeight: FontWeight.w400),
                        SizedBox(
                          height: 5,
                        ),
                        TextStyleRes.textUbuntuStyleFont3(
                            txtColor: txtDescriptionColor,
                            text:
                                "The estimated amount you will receive after service fee",
                            fontSize: 10,
                            fontWeight: FontWeight.w400),
                      ],
                    ),
                  ),
                  Spacer(),
                  Container(
                    width: 70,
                    height: 25,
                    decoration: BoxDecoration(
                      border: Border.all(color: btnColor, width: 1),
                    ),
                    padding: const EdgeInsets.only(left: 5, right: 5),
                    child: Row(
                      children: [
                        TextStyleRes.textUbuntuStyleFont2(
                            text: "\$",
                            fontSize: 10,
                            fontWeight: FontWeight.w400),
                        Container(
                          width: 50,
                          child: TextField(
                            onChanged: (value) {
                              onReceived(value);
                            },
                            keyboardType: TextInputType.number,
                            cursorColor: txtColor,
                            textAlign: TextAlign.right,
                            style: TextStyle(
                              fontFamily: App.font2,
                              color: txtColor,
                              fontSize: 10,
                            ),
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              focusedBorder: InputBorder.none,
                              enabledBorder: InputBorder.none,
                              errorBorder: InputBorder.none,
                              disabledBorder: InputBorder.none,
                              hintText: "$received",
                              hintStyle: TextStyle(
                                fontFamily: App.font2,
                                color: txtColor,
                                fontSize: 10,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Expanded(
                    child: SizedBox(
                      width: 5,
                    ),
                  ),
                  TextStyleRes.textUbuntuStyleFont2(
                      text: "/hr", fontSize: 10, fontWeight: FontWeight.w400),
                ],
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Container(
              height: 190,
              padding: const EdgeInsets.only(
                  left: 20, right: 20, top: 20, bottom: 20),
              color: btnColor,
              child: Column(
                // mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextStyleRes.textUbuntuStyleFont2(
                      text: "Kinoverse service fee will be as low as 5%",
                      fontSize: 12,
                      fontWeight: FontWeight.w700),
                  SizedBox(
                    height: 15,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.white, width: 1),
                        ),
                        padding: const EdgeInsets.only(
                            left: 10, right: 10, top: 5, bottom: 5),
                        child: Row(
                          children: [
                            TextStyleRes.textUbuntuStyleFont2(
                                text: "See how it works",
                                fontSize: 10,
                                fontWeight: FontWeight.w500),
                            SizedBox(
                              width: 10,
                            ),
                            Image.asset(
                              App.playIcon,
                              height: 16,
                            ),
                          ],
                        ),
                      ),
                      Spacer(),
                      Container(
                        height: 120,
                        width: 120,
                        child: Image.asset(
                          App.rateGraphIcon,
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            widget.edit != true
                ? MaterialButton(
                    height: 35.0,
                    textColor: txtColor,
                    child: Text(
                      'skip this step',
                      textScaleFactor: 1.0,
                    ),
                    onPressed: () {
                      //CommonRoutePage().gotoTitleOverviewPage(context);
                      Navigator.of(context)
                          .pushNamed(TitleOverviewPage.routeName);
                    },
                  )
                : Container(),
            SizedBox(
              height: 10,
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
              //CommonRoutePage().gotoTitleOverviewPage(context);


              if (valueCheck != null) {
                BlocProvider.of<FieldsBloc>(context)
                    .add(NextButtonEventScreen9(rate.toString()));
                
                if (widget?.edit == null)
                  Navigator.of(context).pushNamed(TitleOverviewPage.routeName);
              } else
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    duration: const Duration(milliseconds: 300),
                    content: const Text('Please set the hourly rate ')));
            },
          ),
        ],
      ),
    );
  }

  void hourlyRate(String value) {
    if (value != '') {
      rate = double.parse(value);
      setState(() {
        service = (20 / 100) * rate;
        received = rate - service;
      });
    } else {
      rate = 0.00;
      setState(() {
        service = (20 / 100) * rate;
        received = rate - service.roundToDouble();
      });
    }
  }

  void onReceived(String value) {
    if (value != '') {
      received = double.parse(value);
      setState(() {
        rate = (1.05 + 20 / 100) * received;
        service = (20 / 100) * rate;
      });
    } else {
      received = 0.00;
      setState(() {
        rate = (1.05 + 20 / 100) * received;
        service = (20 / 100) * rate;
      });
    }
  }
}
