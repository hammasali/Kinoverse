part of 'job_bloc.dart';

abstract class JobState {}

class JobInitial extends JobState {}

class JobLoadingState extends JobState {}

class JobSuccessfulState extends JobState {
  var data;

  JobSuccessfulState([this.data]);
}

class JobUnSuccessfulState extends JobState {
  String message;

  JobUnSuccessfulState([this.message]);
}
