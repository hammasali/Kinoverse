part of 'fields_photo_cubit.dart';

@immutable
abstract class FieldsPhotoState {}

class FieldsPhotoInitial extends FieldsPhotoState {}

class FieldsPhotoLoading extends FieldsPhotoState {}

class FieldsPhotoSuccessfulState extends FieldsPhotoState {}

class FieldsPhotoUnsuccessfulState extends FieldsPhotoState {
  final String message;

  FieldsPhotoUnsuccessfulState({this.message});
}
