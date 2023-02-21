import 'dart:async';

import 'package:flutter_sweater_shop/Exceptions/api_exception.dart';
import 'package:flutter_sweater_shop/Models/shopping_item.dart';
import 'package:flutter_sweater_shop/Utilities/api_client.dart';
import 'package:flutter_sweater_shop/redux/actions/basket.dart';
import 'package:flutter_sweater_shop/redux/app_state.dart';
import 'package:redux_thunk/redux_thunk.dart';
import 'package:redux/redux.dart';

ThunkAction<AppState> fetchBasket(Completer completer) {
  return (Store<AppState> store) async {
    try {
      List<ShoppingItem> basket = await ApiClient.fetchBasket();
      store.dispatch(SetBasketAction(basket));
      completer.complete();
    } on ApiException catch (e) {
      completer.completeError(e);
    }
  };
}

ThunkAction<AppState> addBasketItem(
  ShoppingItem item,
  int quantity,
  Completer completer,
) {
  return (Store<AppState> store) async {
    try {
      await ApiClient.addBasketItem(item);
      store.dispatch(AddBasketItemAction(item));
      completer.complete();
    } on ApiException catch (e) {
      completer.completeError(e);
    }
  };
}

ThunkAction<AppState> incrementQuantity(
  String itemId,
  Completer completer,
) {
  return (Store<AppState> store) async {
    try {
      await ApiClient.dummy(itemId);
      store.dispatch(IncrementQuantityAction(itemId));
      completer.complete();
    } on ApiException catch (e) {
      completer.completeError(e);
    }
  };
}

ThunkAction<AppState> decrementQuantity(
  String itemId,
  Completer completer,
) {
  return (Store<AppState> store) async {
    try {
      await ApiClient.dummy(itemId);
      store.dispatch(DecrementQuantityAction(itemId));
      completer.complete();
    } on ApiException catch (e) {
      completer.completeError(e);
    }
  };
}

ThunkAction<AppState> deleteBasketItem(
  String itemId,
  Completer completer,
) {
  return (Store<AppState> store) async {
    try {
      await ApiClient.deleteBasketItem(itemId);
      store.dispatch(DeleteBasketItemAction(itemId));
      completer.complete();
    } on ApiException catch (e) {
      completer.completeError(e);
    }
  };
}
