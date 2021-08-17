import 'dart:async';


import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kinoverse/backend_service/repo/firebase_repo.dart';


part 'authentication_event.dart';

part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  AuthenticationBloc() : super(AuthenticationInitial());

  @override
  Stream<AuthenticationState> mapEventToState(
    AuthenticationEvent event,
  ) async* {
    try {
      if (event is AuthAppStartedEvent) {
        var isSignIn = await FirebaseRepo.instance.authSignIn();
        if (isSignIn) {
          var user = FirebaseRepo.instance.getCurrentUser();
          yield (AuthenticateUser(user: user));
        } else
          yield (UnAuthenticateUser());
      }
    } catch (e) {
      throw UnAuthenticateUser();
    }
  }
}
