import 'package:flutter/foundation.dart';
import 'package:flutter_sweater_shop/Models/shopping_item.dart';
import 'package:flutter_sweater_shop/redux/actions/basket.dart';
import 'package:flutter_sweater_shop/redux/actions/order.dart';

List<ShoppingItem> basketReducer(List<ShoppingItem> basket, action) {
  if (action is SetBasketAction) {
    if (kDebugMode) {
      print(
          "[BASKET-REDUCER] Setting basket: ${action.payload.length} basket-items");
    }

    return action.payload;
  }

  if (action is UpdateBasketItemAction) {
    if (kDebugMode) print("[BASKET-REDUCER] Updating basket-item");

    return basket
        .map((e) => e.itemId == action.item.id ? action.item : e)
        .toList();
  }

  if (action is AddBasketItemAction) {
    if (kDebugMode) print("[BASKET-REDUCER] Adding basket-item");

    bool found = false;
    List<ShoppingItem> newBasket = basket.map((e) {
      if (e.itemId == action.basketItem.itemId) {
        e.quantity++;
        found = true;
      }
      return e;
    }).toList();

    return found ? newBasket : [...basket, action.basketItem];
  }

  if (action is IncrementQuantityAction) {
    if (kDebugMode) print("[BASKET-REDUCER] Incrementing basket-item");

    return basket.map((element) {
      if (element.itemId == action.itemId) element.quantity++;
      return element;
    }).toList();
  }

  if (action is DecrementQuantityAction) {
    if (kDebugMode) print("[BASKET-REDUCER] Decrementing basket-item");

    return basket.map((element) {
      if (element.itemId == action.itemId) element.quantity--;
      return element;
    }).toList();
  }

  if (action is DeleteBasketItemAction) {
    if (kDebugMode) print("[BASKET-REDUCER] Deleting basket-item");

    return basket.where((element) => element.itemId != action.itemId).toList();
  }

  if (action is AddOrderAction) {
    if (kDebugMode) print("[BASKET-REDUCER] Clearing basket");

    return [];
  }

  return basket;
}
