import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

import 'package:sigma_assigment/app/store/firebase/firebase_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:sigma_assigment/core/enum/login_state_enum.dart';
import 'package:sigma_assigment/core/services/locator_service.dart';
import 'package:sigma_assigment/core/services/navigation_service.dart';

part 'login_store.g.dart';

class LoginStore = LoginStoreBase with _$LoginStore;

abstract class LoginStoreBase with Store {
  FirebaseService _firebaseService = FirebaseService();
  @observable
  SignState signState = SignState.signin;

  @observable
  LoginState loginState = LoginState.initial;
  @observable
  bool grocer = false;

  @observable
  User? user;

  @action
  toggleGrocer() {
    grocer = !grocer;
  }

  @action
  toggleSignState() {
    if (signState == SignState.signin) {
      signState = SignState.signup;
    } else {
      signState = SignState.signin;
    }
  }

  @action
  setLoginState(LoginState loginState) {
    loginState = loginState;
  }

  @action
  appStartPage() async {
    NavigationService _navigationService = locator<NavigationService>();

    user = _firebaseService.auth.currentUser;

    if (user != null) {
      _firebaseService.firebaseUser = user!;
      await _firebaseService.firestore
          .collection('Grocer')
          .where(FieldPath.documentId, isEqualTo: user!.uid)
          .get()
          .then((value) {
        if (value.docs.isNotEmpty) {
          grocer = true;
        } else {
          grocer = false;
        }
      });
      loginState = LoginState.authanticate;
    } else {
      loginState = LoginState.unauthanticate;
    }

    if (loginState == LoginState.unauthanticate) {
      _navigationService.pushAndRemoveAll('/welcome');
    } else if (loginState == LoginState.authanticate && grocer) {
      _navigationService.pushAndRemoveAll('/grocerHome');
    } else if (loginState == LoginState.authanticate && !grocer) {
      _navigationService.pushAndRemoveAll('/userHome');
    }
  }

  @action
  signUp({required String email, required String password}) async {
    loginState = LoginState.pending;

    UserCredential? userCredential =
        await _firebaseService.signUpService(email: email, password: password);
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      if (grocer) {
        await _firebaseService.addGrocer(user);
      } else {
        await _firebaseService.addUser(user);
      }

      loginState = LoginState.authanticate;

      appStartPage();
    } else {
      loginState = LoginState.initial;
    }
  }

  @action
  signIn({required String email, required String password}) async {
    loginState = LoginState.pending;

    UserCredential? userCredential =
        await _firebaseService.signInService(email: email, password: password);

    if (userCredential != null) {
      await appStartPage();
    } else {
      loginState = LoginState.initial;
    }
  }

  @action
  signOut() async {
    await _firebaseService.signOutService();

    loginState = LoginState.unauthanticate;

    await appStartPage();
    //await locator.reset();
  }
}
