import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kinoverse/app.dart';
import 'package:kinoverse/business_logic/bloc/fields/fields_bloc.dart';
import 'package:kinoverse/common/TextStyleRes.dart';
import 'package:kinoverse/common/common_widget.dart';
import 'package:kinoverse/model/worker_company_model.dart';
import 'package:kinoverse/page/worker/phone/phone_page.dart';

class LocationPage extends StatefulWidget {
  static const String routeName = '/location_page';

  @override
  _LocationPageState createState() => _LocationPageState();
}

class _LocationPageState extends State<LocationPage> {
  var streetAddressController = TextEditingController();
  var cityController = TextEditingController();
  var postalCodeController = TextEditingController();
  final key = GlobalKey<FormState>();

  String countryName = 'Indonesia';

  @override
  void dispose() {
    streetAddressController.dispose();
    cityController.dispose();
    postalCodeController.dispose();
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
                  children: <Widget>[gettingStartBtn(), location()],
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
                  App.location,
                  color: txtColor,
                  height: 20,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 12),
                child: Text("Location",
                    style:
                        TextStyle(fontSize: 15, fontWeight: FontWeight.w400)),
              ),
            ],
          ),
        ),
      ),
    );
  }

  ///location
  location() {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20, top: 55),
      child: Container(
        padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
        child: Form(
          key: key,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextStyleRes.textStyleFont1(
                  textColor: txtColor,
                  text: "Where are you based?",
                  fontSize: 12,
                  fontWeight: FontWeight.w700),
              SizedBox(
                height: 5,
              ),
              TextStyleRes.textUbuntuStyleFont3(
                  txtColor: txtDescriptionColor,
                  text:
                      "We take care your privacy very seriously, Only your city and country will be shown to the clients.",
                  fontSize: 10,
                  fontWeight: FontWeight.w400),
              SizedBox(
                height: 15,
              ),
              Container(
                color: backContainerColor,
                padding: const EdgeInsets.only(
                    left: 10, right: 10, top: 10, bottom: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    TextStyleRes.textUbuntuStyleFont2(
                        text: "Country",
                        fontSize: 10,
                        fontWeight: FontWeight.w700),
                    SizedBox(
                      height: 5,
                    ),
                    GestureDetector(
                      behavior: HitTestBehavior.translucent,
                      onTap: () => _countryPicker(context),
                      child: Container(
                        width: 180,
                        height: 40,
                        padding: const EdgeInsets.only(left: 10, right: 10),
                        decoration: BoxDecoration(
                          border:
                              Border.all(color: txtDescriptionColor, width: 1),
                        ),
                        child: Center(
                          child: ListTile(
                            dense: true,
                            title: TextStyleRes.textStyleFont1(
                                textColor: txtDescriptionColor,
                                textAlign: TextAlign.left,
                                fontSize: 10,
                                fontWeight: FontWeight.w400,
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

                    // DropdownButtonHideUnderline(
                    //   child: DropdownButton(
                    //     dropdownColor: backContainerColor,
                    //     hint: Text(
                    //       "Country",
                    //       style: TextStyle(
                    //           fontFamily: App.font2,
                    //           color: txtDescriptionColor,
                    //           fontSize: 10,
                    //           fontWeight: FontWeight.w400),
                    //     ),
                    //     items: _dropdownItems.map((category) {
                    //       return new DropdownMenuItem(
                    //         value: selectedCountry,
                    //         child: TextStyleRes.textUbuntuStyleFont2(
                    //             text: category,
                    //             fontSize: 10,
                    //             fontWeight: FontWeight.w400),
                    //       );
                    //     }).toList(),
                    //     onChanged: (newValue) {
                    //       setState(() => selectedCountry = newValue);
                    //     },
                    //     value: selectedCountry,
                    //   ),
                    // ),
                    SizedBox(
                      height: 10,
                    ),
                    TextStyleRes.textUbuntuStyleFont2(
                        text: "Street Address",
                        fontSize: 10,
                        fontWeight: FontWeight.w700),
                    SizedBox(
                      height: 5,
                    ),
                    Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: btnBorderWhite, width: 1),
                        ),
                        child: TextFormField(
                          cursorColor: txtColor,
                          validator: (value) =>
                              value.trim().isEmpty || value == null
                                  ? 'Field is empty'
                                  : null,
                          controller: streetAddressController,
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
                              hintText: "",
                              hintStyle: TextStyle(
                                  fontFamily: App.font2,
                                  color: txtDescriptionColor,
                                  fontSize: 10,
                                  fontWeight: FontWeight.w400)),
                        )),
                    // SizedBox(
                    //   height: 5,
                    // ),
                    // Container(
                    //     width: 180,
                    //     decoration: BoxDecoration(
                    //       border: Border.all(color: btnBorderWhite, width: 1),
                    //     ),
                    //     child: TextFormField(
                    //       cursorColor: txtColor,
                    //       controller: suitController,
                    //       style: TextStyle(
                    //           fontFamily: App.font2,
                    //           color: txtColor,
                    //           fontSize: 10,
                    //           fontWeight: FontWeight.w400),
                    //       decoration: new InputDecoration(
                    //           isDense: true,
                    //           border: InputBorder.none,
                    //           focusedBorder: InputBorder.none,
                    //           enabledBorder: InputBorder.none,
                    //           errorBorder: InputBorder.none,
                    //           disabledBorder: InputBorder.none,
                    //           contentPadding: EdgeInsets.only(
                    //             left: 10,
                    //             bottom: 10,
                    //             top: 10,
                    //           ),
                    //           hintText: "Apt/Suit",
                    //           hintStyle: TextStyle(
                    //               fontFamily: App.font2,
                    //               color: txtDescriptionColor,
                    //               fontSize: 10,
                    //               fontWeight: FontWeight.w400)),
                    //     )),
                    SizedBox(
                      height: 10,
                    ),
                    TextStyleRes.textUbuntuStyleFont2(
                        text: "City",
                        fontSize: 10,
                        fontWeight: FontWeight.w700),
                    SizedBox(
                      height: 5,
                    ),
                    Container(
                        width: 180,
                        decoration: BoxDecoration(
                          border: Border.all(color: btnBorderWhite, width: 1),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: TextFormField(
                                cursorColor: txtColor,
                                controller: cityController,
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
                                    // suffixIcon: Icon(
                                    //   Icons.search,
                                    //   color: btnBorderWhite,
                                    // ),
                                    contentPadding: EdgeInsets.only(
                                      left: 10,
                                      bottom: 10,
                                      top: 10,
                                    ),
                                    hintText: "Type your city here",
                                    hintStyle: TextStyle(
                                        fontFamily: App.font2,
                                        color: txtDescriptionColor,
                                        fontSize: 10,
                                        fontWeight: FontWeight.w400)),
                              ),
                            ),
                            Icon(
                              Icons.search,
                              color: txtDescriptionColor,
                              size: 20,
                            ),
                          ],
                        )),
                    SizedBox(
                      height: 10,
                    ),
                    TextStyleRes.textUbuntuStyleFont2(
                        text: "Zip/Postal Code",
                        fontSize: 10,
                        fontWeight: FontWeight.w700),
                    SizedBox(
                      height: 5,
                    ),
                    Container(
                        width: 180,
                        decoration: BoxDecoration(
                          border: Border.all(color: btnBorderWhite, width: 1),
                        ),
                        child: TextFormField(
                          cursorColor: txtColor,
                          controller: postalCodeController,
                          keyboardType: TextInputType.number,
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
                              hintText: "",
                              hintStyle: TextStyle(
                                  fontFamily: App.font2,
                                  color: txtDescriptionColor,
                                  fontSize: 10,
                                  fontWeight: FontWeight.w400)),
                        )),
                  ],
                ),
              ),
              SizedBox(
                height: 15,
              ),
              MaterialButton(
                height: 35.0,
                textColor: txtColor,
                child: Text(
                  'skip this step',
                  textScaleFactor: 1.0,
                ),
                onPressed: () {
                  //CommonRoutePage().gotoPhonePage(context);
                  Navigator.of(context).pushNamed(PhonePage.routeName);
                },
              ),
            ],
          ),
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
              // CommonRoutePage().gotoPhonePage(context);
              if (key.currentState.validate()) {
                WorkerCompanyModel workerCompanyModel = WorkerCompanyModel(
                    country: countryName,
                    city: cityController?.text,
                    streetAddress: streetAddressController?.text,
                    postalCode: postalCodeController?.text);

                BlocProvider.of<FieldsBloc>(context).add(
                    NextButtonEventScreen12(
                        workerCompanyModel.toMap(workerCompanyModel)));

                Navigator.of(context).pushNamed(PhonePage.routeName);
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
