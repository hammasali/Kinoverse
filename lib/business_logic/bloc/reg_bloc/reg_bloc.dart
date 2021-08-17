import 'dart:async';

import 'package:bloc/bloc.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:kinoverse/backend_service/models/user_info.dart';
import 'package:kinoverse/backend_service/repo/firebase_repo.dart';
import 'package:kinoverse/core/utils.dart';
import 'package:meta/meta.dart';

part 'reg_event.dart';

part 'reg_state.dart';

class RegBloc extends Bloc<RegEvent, RegState> {
  RegBloc() : super(RegInitial());

  @override
  Stream<RegState> mapEventToState(
    RegEvent event,
  ) async* {
    try {
      //======================LogIn Event============================
      if (event is LogInButtonPressedEvent) {
        yield RegLoadingState();

        var user =
            await FirebaseRepo.instance.signInUser(event.email, event.password);

        yield RegSuccessfulState(user: user);
      }

      //=====================Google SignIn Event=======================
      else if (event is GoogleSignInEvent) {
        yield RegLoadingState();

        var userCredential = await FirebaseRepo.instance.signInWithGoogle();

        if (userCredential.user != null) {
          yield RegSuccessfulState(user: userCredential.user);
        }
      }

      //=====================Google LogIn Event=======================
      else if (event is GoogleLoginEvent) {
        yield RegLoadingState();

        var userCredential = await FirebaseRepo.instance.signInWithGoogle();
        var isNewer =
            await FirebaseRepo.instance.authenticateUser(userCredential.user);

        if (!isNewer) {
          yield RegSuccessfulState(user: userCredential.user);
        } else
          throw ("Please create an account");
      }
      //======================Create Account Event=========================
      else if (event is CreateAccountEvent) {
        yield RegLoadingState();
        String _dateTime =
            DateFormat('hh:mm a').format(DateTime.now());
        if (event.check2 == true) {
          ///Sign In With Email and Password
          if (event.anonymousSignIn == true) {
            if (event.username.isNotEmpty) {
              var isUnique = await FirebaseRepo.instance
                  .authenticateUniqueUserName(event.username);
              print('${event.username}  this is user name');
              if (isUnique) {
                var user = await FirebaseRepo.instance
                    .createUser(event.email, event.password);
                if (user != null) {
                  await user.sendEmailVerification();

                  UserInfoModel userInfo = UserInfoModel(
                      uid: user.uid,
                      name: event.name,
                      email: event.email,
                      profilePhoto: event.profilePhoto,
                      userName: event.username,
                      country: event.country,
                      profileState: event.profileState,
                      signUpCheckForEmail: event.check1,
                      createdAt: _dateTime,
                      companyContacts: null);

                  await FirebaseRepo.instance
                      .addAuthenticatedDataToDB(userInfoModel: userInfo);

                  yield RegSuccessfulState(user: user);
                }
              } else
                throw ('Please provide a unique username');
            } else
              throw ('Please provide a username');
          }

          ///Sign In with Google
          else {
            var current = FirebaseRepo.instance.getCurrentUser();
            var userName = Utils.getUserName(current.email);
            var isNewer = await FirebaseRepo.instance
                .authenticateUniqueUserName(userName);
            if (isNewer) {
              await current.sendEmailVerification();

              UserInfoModel userInfo = UserInfoModel(
                  uid: current.uid,
                  name: current.displayName,
                  email: current.email,
                  profilePhoto: current.photoURL,
                  userName: userName,
                  country: event.country,
                  profileState: event.profileState,
                  signUpCheckForEmail: event.check1,
                  createdAt: _dateTime,
                  companyContacts: null);

              await FirebaseRepo.instance
                  .addAuthenticatedDataToDB(userInfoModel: userInfo);

              yield RegSuccessfulState(user: current);
            } else
              throw ("The account already exists for that email.");
          }
        } else
          throw ("Please agree to the terms");
      }
    }

    //==================Errors=======================
    on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        yield RegUnsuccessfulState(
            message: 'The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        yield RegUnsuccessfulState(
            message: 'The account already exists for that email.');
      } else if (e.code == 'user-not-found') {
        yield RegUnsuccessfulState(message: 'No user found for that email.');
      } else if (e.code == 'wrong-password') {
        yield RegUnsuccessfulState(
            message: 'Wrong password provided for that user.');
      } else if (e.message == 'Given String is empty or null')
        yield RegUnsuccessfulState(message: 'Please provide credentials');
      else
        yield RegUnsuccessfulState(message: e.code);
    } on PlatformException catch (e) {
      yield RegUnsuccessfulState(message: e.code);
    } on String catch (e) {
      emit(RegUnsuccessfulState(message: e));
    }
  }
}
