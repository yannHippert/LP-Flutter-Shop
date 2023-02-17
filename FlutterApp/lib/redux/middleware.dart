import 'dart:async';

import 'package:flutter_sweater_shop/Exceptions/ApiException.dart';
import 'package:flutter_sweater_shop/Models/order.dart';
import 'package:flutter_sweater_shop/Models/product.dart';
import 'package:flutter_sweater_shop/Utilities/api_client.dart';
import 'package:flutter_sweater_shop/redux/actions/authentication.dart';
import 'package:flutter_sweater_shop/redux/actions/order.dart';
import 'package:flutter_sweater_shop/redux/actions/product.dart';
import 'package:flutter_sweater_shop/redux/app_state.dart';
import 'package:redux_thunk/redux_thunk.dart';
import 'package:redux/redux.dart';

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

ThunkAction<AppState> fetchProducts(Completer completer) {
  return (Store<AppState> store) async {
    try {
      List<Product> products = await ApiClient.fetchProducts();
      store.dispatch(AddProductsAction(products));
      completer.complete();
    } on ApiException catch (e) {
      completer.completeError(e);
    }
  };
}

ThunkAction<AppState> fetchOrders(Completer completer) {
  return (Store<AppState> store) async {
    try {
      List<Order> orders = await ApiClient.fetchOrders();
      store.dispatch(SetOrdersAction(orders));
      completer.complete();
    } on ApiException catch (e) {
      completer.completeError(e);
    }
  };
}
