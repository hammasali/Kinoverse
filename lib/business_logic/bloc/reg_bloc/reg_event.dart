part of 'reg_bloc.dart';

abstract class RegEvent {}

class SignUpButtonPressedEvent extends RegEvent {
  String email, password;

  SignUpButtonPressedEvent({@required this.email, @required this.password});
}

class LogInButtonPressedEvent extends RegEvent {
  String email, password;

  LogInButtonPressedEvent({@required this.email, @required this.password});
}

class GoogleSignInEvent extends RegEvent {}
class GoogleLoginEvent extends RegEvent{}

class CreateAccountEvent extends RegEvent {
  String email, name, username, password, country, profileState,profilePhoto;
  bool anonymousSignIn,check1,check2;
  CreateAccountEvent(
      {this.country,
      this.profileState,
      this.email,
      this.name,
      this.username,
      this.password,
      this.anonymousSignIn,
      this.check1,
      this.check2});
}
