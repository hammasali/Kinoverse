import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kinoverse/app.dart';
import 'package:kinoverse/business_logic/bloc/fields/fields_bloc.dart';
import 'package:kinoverse/common/TextStyleRes.dart';
import 'package:kinoverse/common/common_widget.dart';
import 'package:kinoverse/page/worker/profile_overview/profile_overview_page.dart';

class PhonePage extends StatefulWidget {
  static const String routeName = '/phone_page';

  @override
  _PhonePageState createState() => _PhonePageState();
}

class _PhonePageState extends State<PhonePage> {
  String countryPhoneCode = '+1';
  String phoneNo;
  final controller = TextEditingController();

  @override
  void dispose() {
    super.dispose();

    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print("runtimeType -> " + runtimeType.toString());
    return BlocListener<FieldsBloc, FieldsState>(
      listener: (context, state) {
        if (state is FieldSuccessfulState)
          Navigator.pushNamedAndRemoveUntil<dynamic>(
              context, ProfileOverviewPage.routeName, (route) => false,
              //if you want to disable back feature set to false
              arguments: state.data);
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
                    children: <Widget>[gettingStartBtn(), phone()],
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
                  App.phoneIcon,
                  color: txtColor,
                  height: 20,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 12),
                child: Text("Phone",
                    style:
                        TextStyle(fontSize: 15, fontWeight: FontWeight.w400)),
              ),
            ],
          ),
        ),
      ),
    );
  }

  ///phone
  phone() {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20, top: 55),
      child: Container(
        padding: const EdgeInsets.only(top: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextStyleRes.textStyleFont1(
                textColor: txtColor,
                text: "Add your phone number",
                fontSize: 12,
                fontWeight: FontWeight.w700),
            SizedBox(
              height: 5,
            ),
            TextStyleRes.textUbuntuStyleFont3(
                txtColor: txtDescriptionColor,
                text: "Your phone number will not be shared with clients.",
                fontSize: 10,
                fontWeight: FontWeight.w400),
            SizedBox(
              height: 30,
            ),
            Container(
              height: 40,
              decoration: BoxDecoration(
                border: Border.all(color: txtDescriptionColor, width: 1),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    color: txtDescriptionColor,
                    child: CountryCodePicker(
                      dialogBackgroundColor: Color(0x00ff3E4346),
                      onChanged: (CountryCode code) {
                        countryPhoneCode = code.dialCode;
                        print(countryPhoneCode);
                      },
                      padding: const EdgeInsets.all(0),
                      dialogTextStyle: TextStyle(
                          fontFamily: App.font2,
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.w400),
                      searchStyle: TextStyle(
                          fontFamily: App.font2,
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.w400),
                      searchDecoration: InputDecoration(
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
                          borderSide:
                              BorderSide(color: const Color(0xFF8C98A8)),
                        ),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: const Color(0xFF8C98A8).withOpacity(0.2),
                          ),
                        ),
                      ),
                      //backgroundColor: Color(0x00ff3E4346),
                      initialSelection: countryPhoneCode,
                      flagWidth: 30,
                      showCountryOnly: false,
                      showOnlyCountryWhenClosed: false,
                    ),
                  ),
                  Expanded(
                    child: Container(
                        width: 180,
                        decoration: BoxDecoration(
                          border: Border.all(color: btnBorderWhite, width: 1),
                        ),
                        child: TextFormField(
                          cursorColor: txtColor,
                          controller: controller,
                          validator: (value) =>
                              value.trim().isEmpty || value == null
                                  ? 'Field is empty'
                                  : null,
                          onSaved: (value) => phoneNo = value,
                          keyboardType: TextInputType.phone,
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
                              hintText: "Enter your phone number",
                              hintStyle: TextStyle(
                                  fontFamily: App.font2,
                                  color: txtDescriptionColor,
                                  fontSize: 10,
                                  fontWeight: FontWeight.w400)),
                        )),
                  ),
                ],
              ),
            ),
            // SizedBox(
            //   height: 30,
            // ),
            // MaterialButton(
            //   height: 35.0,
            //   textColor: txtColor,
            //   child: Text(
            //     'skip this step',
            //     textScaleFactor: 1.0,
            //   ),
            //   onPressed: () {
            //     // CommonRoutePage().gotoProfileOverviewPage(context);
            //     Navigator.pushNamedAndRemoveUntil<dynamic>(
            //         context,
            //         ProfileOverviewPage.routeName,
            //         (route) => false, //if you want to disable back feature set to false
            //         arguments: context.read<FieldsBloc>().state);
            //   },
            // ),
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
              'Preview Profile',
              textScaleFactor: 1.0,
            ),
            onPressed: () {
              //CommonRoutePage().gotoProfileOverviewPage(context);

              if (controller.text.trim().isNotEmpty &&
                  controller.text != null) {
                String phone = countryPhoneCode + controller.text.trim();
                print(phone);
                BlocProvider.of<FieldsBloc>(context)
                    .add(NextButtonEventScreen13(phone.trim()));
              } else
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    duration: const Duration(milliseconds: 300),
                    content: const Text('Please Enter valid phone No.')));
            },
          ),
        ],
      ),
    );
  }
}
