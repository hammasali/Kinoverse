part of 'fields_bloc.dart';

abstract class FieldsEvent {}

class NextButtonEventScreen3 extends FieldsEvent {
  List<String> categories;

  NextButtonEventScreen3(this.categories);
}

class NextButtonEventScreen4 extends FieldsEvent {
  List skills;

  NextButtonEventScreen4(this.skills);
}

class NextButtonEventScreen5 extends FieldsEvent {
  String expert;

  NextButtonEventScreen5(this.expert);
}

class NextButtonEventScreen6 extends FieldsEvent {
  List<Map> userMapData;

  NextButtonEventScreen6({this.userMapData});
}

class NextButtonEventScreen7 extends FieldsEvent {
  List<Map<String, dynamic>> userEmploymentMapData;

  NextButtonEventScreen7({this.userEmploymentMapData});
}

class NextButtonEventScreen8 extends FieldsEvent {
  List otherLanguages;
  String englishProficiency;

  NextButtonEventScreen8({this.otherLanguages, this.englishProficiency});
}

class NextButtonEventScreen9 extends FieldsEvent {
  String hourlyRate;

  NextButtonEventScreen9(this.hourlyRate);
}

class NextButtonEventScreen10 extends FieldsEvent {
  String title, professionalOverview;

  NextButtonEventScreen10({this.title, this.professionalOverview});
}

// class NextButtonEventScreen11 extends FieldsEvent {
//   File file;
//
//   NextButtonEventScreen11(this.file);
// }

class NextButtonEventScreen12 extends FieldsEvent {
  Map<String, dynamic> userData;

  NextButtonEventScreen12(this.userData);
}

class NextButtonEventScreen13 extends FieldsEvent {
  String phoneNo;

  NextButtonEventScreen13(this.phoneNo);
}

class SubmitButtonEventScreen14 extends FieldsEvent {}
class SaveButtonEventScreen14 extends FieldsEvent {
  String name,country;

  SaveButtonEventScreen14({this.name, this.country});
}

class SubmitButtonHireEvent extends FieldsEvent {
  Map<String,dynamic> hireModel;
  File file;

  SubmitButtonHireEvent({this.hireModel, this.file});
}
