part of 'fields_bloc.dart';

abstract class FieldsState {}

class FieldsInitial extends FieldsState {}
class FieldLoadingState extends FieldsState {}


class FieldSuccessfulState extends FieldsState {
  var data;

  FieldSuccessfulState([this.data]);
}


class FieldUnsuccessfulState extends FieldsState {
  String message;

  FieldUnsuccessfulState({this.message});
}
