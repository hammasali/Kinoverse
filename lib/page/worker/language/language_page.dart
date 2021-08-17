import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kinoverse/app.dart';
import 'package:kinoverse/business_logic/bloc/fields/fields_bloc.dart';
import 'package:kinoverse/common/TextStyleRes.dart';
import 'package:kinoverse/common/common_widget.dart';
import 'package:kinoverse/core/routes.dart';
import 'package:kinoverse/page/worker/hourly_rate/hourly_rate_page.dart';
import 'package:kinoverse/page/worker/profile_overview/profile_overview_page.dart';

class LanguagePage extends StatefulWidget {
  static const String routeName = '/language_page';
  final bool edit;

  LanguagePage([this.edit]);

  @override
  _LanguagePageState createState() => _LanguagePageState();
}

class LanguageModel {
  int value;
  String name;
  String description;

  LanguageModel(this.description, this.name, this.value);

  @override
  String toString() {
    return name;
  }
}

class _LanguagePageState extends State<LanguagePage> {
  var isAddLanguage = false;
  String selectedLang;
  LanguageModel selectedLanguage;
  List<LanguageModel> _dropdownItems = [
    LanguageModel("I write in this language decently", "Basic", 0),
    LanguageModel("I write and speak this language well", "Conversational", 1),
    LanguageModel(
        "I write and speak this language\n almost perfectly", "Fluent", 2),
    LanguageModel(
        "I write and speak this language\n perfectly, including colloquialisms",
        "Native or Bilingual",
        3)
  ];

  final controller = TextEditingController();
  MyAppRoutes _myAppRoutes = MyAppRoutes();
  List<String> tags = [];

  @override
  void dispose() {
    controller.dispose();
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
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    gettingStartBtn(),
                    myLanguage(),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 20, right: 20, top: 10, bottom: 10),
                      child: Wrap(
                        spacing: 8.0, // gap between adjacent chips
                        runSpacing: 4.0, // gap between lines
                        children: <Widget>[...generate_tags()],
                      ),
                    ),
                  ],
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
                  App.microphoneIcon,
                  color: txtColor,
                  height: 20,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 12),
                child: Text("Languages",
                    style:
                        TextStyle(fontSize: 15, fontWeight: FontWeight.w400)),
              ),
            ],
          ),
        ),
      ),
    );
  }

  ///language
  myLanguage() {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20, top: 55),
      child: Container(
        padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
        color: backContainerColor,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextStyleRes.textStyleFont1(
                textColor: txtColor,
                text: "What is your English proficiency?",
                fontSize: 12,
                fontWeight: FontWeight.w700),
            SizedBox(
              height: 10,
            ),
            // Container(
            //   width: 250,
            //   padding: const EdgeInsets.only(left: 10, right: 10),
            //   decoration: BoxDecoration(
            //     border: Border.all(color: btnColor, width: 1),
            //   ),
            //   child: DropdownButtonHideUnderline(
            //     child: DropdownButton(
            //       dropdownColor: backContainerColor,
            //       hint: Text(
            //         "English Proficiency",
            //         style: TextStyle(color: Colors.white),
            //       ),
            //       items: _dropdownItems.map((LanguageModel category) {
            //         return new DropdownMenuItem(
            //           value: selectedLang,
            //           child: Column(
            //             crossAxisAlignment: CrossAxisAlignment.start,
            //             children: [
            //               TextStyleRes.textUbuntuStyleFont2(
            //                   text: category.name,
            //                   fontSize: 10,
            //                   fontWeight: FontWeight.w400),
            //               SizedBox(
            //                 height: 5,
            //               ),
            //               TextStyleRes.textStyleFont1(
            //                   textColor: txtDescriptionColor,
            //                   text: category.description,
            //                   fontSize: 10,
            //                   fontWeight: FontWeight.w300),
            //             ],
            //           ),
            //         );
            //       }).toList(),
            //       onChanged: (newValue) {
            //         print("val: $newValue  ${newValue.runtimeType}");
            //         var casting = newValue as LanguageModel;
            //         setState(() => selectedLang = casting.name);
            //       },
            //       value: selectedLang,
            //     ),
            //   ),
            // ),
            Container(
              width: 250,
              child: AppDropdownInput<LanguageModel>(
                hintText: "English Proficiency",
                options: _dropdownItems,
                value: selectedLanguage,
                onChanged: (LanguageModel value) {
                  setState(() {
                    selectedLanguage = value;
                  });
                },
                getLabel: (LanguageModel value) => value.name,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            TextStyleRes.textStyleFont1(
                textColor: txtColor,
                text: "What other languages do you speak?",
                fontSize: 12,
                fontWeight: FontWeight.w700),
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.only(
                      left: 10, right: 10, top: 5, bottom: 5),
                  decoration: BoxDecoration(
                    border: Border.all(color: btnColor, width: 1),
                  ),
                  child: TextStyleRes.textUbuntuStyleFont2(
                      text: "Add Languages",
                      fontSize: 10,
                      fontWeight: FontWeight.w400),
                ),
                SizedBox(
                  width: 10,
                ),
                Visibility(
                  visible: !isAddLanguage,
                  child: MaterialButton(
                    height: 25.0,
                    minWidth: 25.0,
                    color: btnColor,
                    textColor: Colors.white,
                    child: Icon(
                      Icons.add,
                      size: 16,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      setState(() {});
                      isAddLanguage = true;
                    },
                  ),
                ),
                Visibility(
                  visible: isAddLanguage,
                  child: MaterialButton(
                    height: 25.0,
                    minWidth: 25.0,
                    color: btnBorderWhite,
                    child: Icon(
                      Icons.remove,
                      size: 16,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      setState(() {
                        isAddLanguage = false;
                      });
                    },
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            // educationItem(),
            Visibility(
              visible: isAddLanguage,
              child: addLanguage(),
            ),
            widget.edit != true
                ? Visibility(
                    visible: !isAddLanguage,
                    child: MaterialButton(
                      height: 35.0,
                      textColor: btnColor,
                      child: Text(
                        'skip this step',
                        textScaleFactor: 1.0,
                      ),
                      onPressed: () {
                        //CommonRoutePage().gotoHourlyRate(context);
                        Navigator.of(context)
                            .pushNamed(HourlyRatePage.routeName);
                      },
                    ),
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
              //CommonRoutePage().gotoHourlyRate(context);
              BlocProvider.of<FieldsBloc>(context).add(NextButtonEventScreen8(
                  englishProficiency: selectedLanguage?.name,
                  otherLanguages: tags));

              print(selectedLang);
              print(selectedLanguage?.name);

              if (widget?.edit == null && selectedLanguage != null)
                Navigator.of(context).pushNamed(HourlyRatePage.routeName);
              //print('Language : $selectedLanguage &&& $tags');
            },
          ),
          // Visibility(
          //   visible: isAddLanguage,
          //   child: MaterialButton(
          //     height: 35.0,
          //     elevation: 5,
          //     color: btnColor,
          //     textColor: Colors.white,
          //     child: Text(
          //       'SAVE',
          //       textScaleFactor: 1.0,
          //     ),
          //     onPressed: () {
          //       ///save employment and set isAddEmployment to false
          //       setState(() {
          //         isAddLanguage = false;
          //       });
          //     },
          //   ),
          // ),
        ],
      ),
    );
  }

  addLanguage() {
    return Container(
      padding: const EdgeInsets.only(right: 20, top: 10),
      color: backContainerColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
              decoration: BoxDecoration(
                border: Border.all(color: btnColor, width: 1),
              ),
              child: TextFormField(
                validator: (value) => value.trim().isEmpty || value == null
                    ? 'Field is empty'
                    : null,
                cursorColor: txtColor,
                controller: controller,
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
                    hintText: "Add language (Optional)",
                    hintStyle: TextStyle(
                        fontFamily: App.font2,
                        color: txtColor,
                        fontSize: 10,
                        fontWeight: FontWeight.w400)),
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
                if (!tags.contains(controller?.text)) {
                  setState(() {
                    tags.add(controller?.text);
                  });

                  controller.text = '';
                }
              },
            ),
          ),
          SizedBox(
            height: 10,
          ),
        ],
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
      label: Text("$name"),
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
}

class AppDropdownInput<T> extends StatelessWidget {
  final String hintText;
  final List<LanguageModel> options;
  final LanguageModel value;
  final String Function(T) getLabel;
  final void Function(LanguageModel) onChanged;

  AppDropdownInput({
    this.hintText = 'Please select an Option',
    this.options = const [],
    this.getLabel,
    this.value,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    List<DropdownMenuItem<LanguageModel>> menuItems = options
        .map((e) => DropdownMenuItem<LanguageModel>(
            value: e,
            child: SizedBox(
              height: 50,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextStyleRes.textUbuntuStyleFont2(
                      text: e.name, fontSize: 10, fontWeight: FontWeight.w400),
                  SizedBox(
                    height: 5,
                  ),
                  Expanded(
                      child: TextStyleRes.textStyleFont1(
                          textColor: txtDescriptionColor,
                          text: e.description,
                          fontSize: 10,
                          fontWeight: FontWeight.w300)),
                ],
              ),
            )))
        .toList();

    return FormField<T>(
      builder: (FormFieldState<T> state) {
        return Stack(
          children: [
            Container(
              width: 250,
              height: 50,
              child: Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.only(left: 10),
                  child: TextStyleRes.textUbuntuStyleFont2(
                      text: value == null ? "English Proficiency" : value.name,
                      fontSize: 10,
                      fontWeight: FontWeight.w400),
                ),
              ),
            ),
            Container(
              width: 250,
              height: 50,
              decoration: BoxDecoration(border: Border.all(color: btnColor)),
              child: DropdownButtonHideUnderline(
                child: DropdownButton(
                  dropdownColor: bgColor,
                  // value: options.first,
                  onChanged: onChanged,
                  items: menuItems,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
