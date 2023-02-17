import 'dart:async';

import 'package:flutter_sweater_shop/Exceptions/ApiException.dart';
import 'package:flutter_sweater_shop/Models/product.dart';
import 'package:flutter_sweater_shop/Utilities/api_client.dart';
import 'package:flutter_sweater_shop/redux/app_state.dart';
import 'package:redux_thunk/redux_thunk.dart';
import 'package:redux/redux.dart';

class UpdateProductAction {
  final Product updatedProduct;

  UpdateProductAction(this.updatedProduct);
}

class LoginAction {
  final String email;

  LoginAction(this.email);
}

ThunkAction<AppState> authenticate(
    String email, String password, Completer completer) {
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

class LogoutAction {
  LogoutAction();
}

class AuthenticateAction {
  final String email;
  final String password;

  AuthenticateAction(this.email, this.password);
}
