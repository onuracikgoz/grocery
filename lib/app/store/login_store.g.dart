// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$LoginStore on LoginStoreBase, Store {
  final _$signStateAtom = Atom(name: 'LoginStoreBase.signState');

  @override
  SignState get signState {
    _$signStateAtom.reportRead();
    return super.signState;
  }

  @override
  set signState(SignState value) {
    _$signStateAtom.reportWrite(value, super.signState, () {
      super.signState = value;
    });
  }

  final _$loginStateAtom = Atom(name: 'LoginStoreBase.loginState');

  @override
  LoginState get loginState {
    _$loginStateAtom.reportRead();
    return super.loginState;
  }

  @override
  set loginState(LoginState value) {
    _$loginStateAtom.reportWrite(value, super.loginState, () {
      super.loginState = value;
    });
  }

  final _$grocerAtom = Atom(name: 'LoginStoreBase.grocer');

  @override
  bool get grocer {
    _$grocerAtom.reportRead();
    return super.grocer;
  }

  @override
  set grocer(bool value) {
    _$grocerAtom.reportWrite(value, super.grocer, () {
      super.grocer = value;
    });
  }

  final _$userAtom = Atom(name: 'LoginStoreBase.user');

  @override
  User? get user {
    _$userAtom.reportRead();
    return super.user;
  }

  @override
  set user(User? value) {
    _$userAtom.reportWrite(value, super.user, () {
      super.user = value;
    });
  }

  final _$appStartPageAsyncAction = AsyncAction('LoginStoreBase.appStartPage');

  @override
  Future appStartPage() {
    return _$appStartPageAsyncAction.run(() => super.appStartPage());
  }

  final _$signUpAsyncAction = AsyncAction('LoginStoreBase.signUp');

  @override
  Future signUp({required String email, required String password}) {
    return _$signUpAsyncAction
        .run(() => super.signUp(email: email, password: password));
  }

  final _$signInAsyncAction = AsyncAction('LoginStoreBase.signIn');

  @override
  Future signIn({required String email, required String password}) {
    return _$signInAsyncAction
        .run(() => super.signIn(email: email, password: password));
  }

  final _$signOutAsyncAction = AsyncAction('LoginStoreBase.signOut');

  @override
  Future signOut() {
    return _$signOutAsyncAction.run(() => super.signOut());
  }

  final _$LoginStoreBaseActionController =
      ActionController(name: 'LoginStoreBase');

  @override
  dynamic toggleGrocer() {
    final _$actionInfo = _$LoginStoreBaseActionController.startAction(
        name: 'LoginStoreBase.toggleGrocer');
    try {
      return super.toggleGrocer();
    } finally {
      _$LoginStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic toggleSignState() {
    final _$actionInfo = _$LoginStoreBaseActionController.startAction(
        name: 'LoginStoreBase.toggleSignState');
    try {
      return super.toggleSignState();
    } finally {
      _$LoginStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setLoginState(LoginState loginState) {
    final _$actionInfo = _$LoginStoreBaseActionController.startAction(
        name: 'LoginStoreBase.setLoginState');
    try {
      return super.setLoginState(loginState);
    } finally {
      _$LoginStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
signState: ${signState},
loginState: ${loginState},
grocer: ${grocer},
user: ${user}
    ''';
  }
}
