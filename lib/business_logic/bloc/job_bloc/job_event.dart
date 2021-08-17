part of 'job_bloc.dart';

abstract class JobEvent {}

class JobScreen1Event extends JobEvent {
  String jobPost, categories;

  JobScreen1Event(this.jobPost, this.categories);
}

class JobScreenEvent2 extends JobEvent {
  var description;

  JobScreenEvent2(this.description);
}

class JobScreenEvent3 extends JobEvent {
  String projectType;
  List<String> projectQuestion;

  JobScreenEvent3({this.projectType, this.projectQuestion});
}

class JobScreenEvent4 extends JobEvent {
  String freelancerType;
  var editingPlatform, editingSoftware;

  JobScreenEvent4(
      {this.freelancerType, this.editingPlatform, this.editingSoftware});
}

class JobScreenEvent5 extends JobEvent {
  String jobState, freelancerQuantity, talentType;

  JobScreenEvent5({this.jobState, this.freelancerQuantity, this.talentType});
}

class JobScreenEvent6 extends JobEvent {
  String projectDuration, projectRate, projectPaymentType;

  JobScreenEvent6(
      {this.projectDuration, this.projectRate, this.projectPaymentType});
}

class PreviewPostJob extends JobEvent {
  String englishLevel, timeRequirement;

  PreviewPostJob({this.englishLevel, this.timeRequirement});
}

class SubmitEvent extends JobEvent {}


