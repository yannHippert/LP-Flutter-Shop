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
  Completer completer,
) {
  return (Store<AppState> store) async {
    try {
      var items = store.state.basket.where((e) => e.itemId == item.itemId);
      if (items.isEmpty) {
        await ApiClient.setBasketItem(item);
      } else {
        var storeItem = items.elementAt(0);
        storeItem.quantity++;
        await ApiClient.setBasketItem(storeItem);
      }
      List<ShoppingItem> basket = await ApiClient.fetchBasket();
      store.dispatch(SetBasketAction(basket));
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
      var item = store.state.basket.firstWhere((e) => e.itemId == itemId);
      item.quantity++;
      await ApiClient.setBasketItem(item);
      List<ShoppingItem> basket = await ApiClient.fetchBasket();
      store.dispatch(SetBasketAction(basket));
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
      var item = store.state.basket.firstWhere((e) => e.itemId == itemId);
      item.quantity--;
      await ApiClient.setBasketItem(item);
      List<ShoppingItem> basket = await ApiClient.fetchBasket();
      store.dispatch(SetBasketAction(basket));
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
