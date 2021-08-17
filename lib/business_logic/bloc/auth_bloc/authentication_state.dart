part of 'authentication_bloc.dart';


abstract class AuthenticationState {}

class AuthenticationInitial extends AuthenticationState {}

class AuthenticateUser extends AuthenticationState {
  User user ;
  AuthenticateUser({this.user});
}

class UnAuthenticateUser extends AuthenticationState {}
