import 'dart:async';

import 'package:flutter_sweater_shop/Exceptions/api_exception.dart';
import 'package:flutter_sweater_shop/Utilities/api_client.dart';
import 'package:flutter_sweater_shop/redux/actions/authentication.dart';
import 'package:flutter_sweater_shop/redux/app_state.dart';
import 'package:redux_thunk/redux_thunk.dart';
import 'package:redux/redux.dart';

ThunkAction<AppState> authenticate(
  String email,
  String password,
  Completer completer,
) {
  return (Store<AppState> store) async {
    try {
      bool loggedIn = await ApiClient.autheticate(email, password);
      if (loggedIn) store.dispatch(LoginAction(email));
      completer.complete();
    } on ApiException catch (e) {
      completer.completeError(e);
    }
  };
}

ThunkAction<AppState> lougout(
  Completer completer,
) {
  return (Store<AppState> store) async {
    try {
      await ApiClient.logout();
      completer.complete();
    } on ApiException catch (e) {
      completer.completeError(e);
    }
  };
}
