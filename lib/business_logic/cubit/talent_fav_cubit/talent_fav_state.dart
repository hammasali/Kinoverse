part of 'talent_fav_cubit.dart';

abstract class TalentFavState {}

class TalentFavInitial extends TalentFavState {}

class TalentFavSuccessfulState extends TalentFavState {}

class TalentFavUnSuccessfulState extends TalentFavState {
  String message;

  TalentFavUnSuccessfulState({this.message});
}
