import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kinoverse/app.dart';
import 'package:kinoverse/business_logic/bloc/fields/fields_bloc.dart';
import 'package:kinoverse/common/TextStyleRes.dart';
import 'package:kinoverse/common/common_widget.dart';
import 'package:kinoverse/page/hire/signup_pgae/signup_page.dart';
import 'package:kinoverse/page/worker/profile_overview/profile_overview_page.dart';

class ProfileOverViewExtensionPage extends StatefulWidget {
  static const String routeName = '/profileOverViewExtension_page';
  final bool submitProfile;

  ProfileOverViewExtensionPage([this.submitProfile]);

  @override
  _ProfileOverViewExtensionPageState createState() =>
      _ProfileOverViewExtensionPageState();
}

class _ProfileOverViewExtensionPageState
    extends State<ProfileOverViewExtensionPage> {
  TextEditingController userNameController = TextEditingController();
  final _key = GlobalKey<FormState>();
  String countryName = 'Indonesia';

  @override
  void dispose() {
    super.dispose();
    userNameController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print("runtimeType -> " + runtimeType.toString());
    return BlocListener<FieldsBloc, FieldsState>(
      listener: (context, state) {
        if (state is FieldSuccessfulState)
          widget?.submitProfile
              ? Navigator.of(context).pushNamedAndRemoveUntil(
                  ProfileOverviewPage.routeName, (route) => false,
                  arguments: state.data)
              : Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(
                      builder: (_) => HireSignupPage(
                            name: userNameController.text,
                            country: countryName,
                          )),
                  (route) => false,
                );
      },
      child: Scaffold(
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
                padding: const EdgeInsets.only(left: 20),
                child: Text("Update",
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
                text: "Update your display name and country",
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
                        text: "Display Name",
                        fontSize: 10,
                        fontWeight: FontWeight.w700),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      color: backContainerColor,
                      child: TextFormField(
                        cursorColor: txtColor,
                        controller: userNameController,
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
                            hintText: "Example: Scot Jr",
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
                        text: "Select Country",
                        fontSize: 10,
                        fontWeight: FontWeight.w700),
                    SizedBox(
                      height: 10,
                    ),
                    GestureDetector(
                      behavior: HitTestBehavior.translucent,
                      onTap: () => _countryPicker(context),
                      child: Container(
                        padding: const EdgeInsets.only(left: 20.0, right: 20.0),
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
              'Save',
              textScaleFactor: 1.0,
            ),
            onPressed: () {
              // ignore: null_aware_in_condition
              if (_key.currentState?.validate()) {
                BlocProvider.of<FieldsBloc>(context).add(
                    SaveButtonEventScreen14(
                        name: userNameController.text.trim(),
                        country: countryName));
              }
            },
          ),
        ],
      ),
    );
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
