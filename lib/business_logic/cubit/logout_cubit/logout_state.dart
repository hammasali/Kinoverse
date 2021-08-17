part of 'logout_cubit.dart';

abstract class LogoutState {}

class LogoutInitial extends LogoutState {}

class LogoutLoadingState extends LogoutState {}


class LogoutSuccessState extends LogoutState {}

class LogoutUnSuccessState extends LogoutState {
  String message;

  LogoutUnSuccessState({this.message});
}
