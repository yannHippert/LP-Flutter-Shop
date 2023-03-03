import 'package:flutter_sweater_shop/Models/shopping_item.dart';
import 'package:flutter_sweater_shop/Models/variable_product.dart';
import 'package:flutter_sweater_shop/Models/user_info.dart';
import 'package:flutter_sweater_shop/redux/actions/authentication.dart';
import 'package:flutter_sweater_shop/redux/actions/basket.dart';
import 'package:flutter_sweater_shop/redux/actions/order.dart';
import 'package:flutter_sweater_shop/redux/actions/product.dart';
import 'package:flutter_sweater_shop/redux/actions/wishlist.dart';
import 'package:flutter_sweater_shop/redux/app_state.dart';

AppState updateProductsReducer(AppState state, dynamic action) {
  if (action is LoginAction) {
    return AppState.fromAppState(
      state,
      userInfo: UserInfo(email: action.email),
    );
  }

  if (action is LogoutAction) {
    return AppState.fromAppState(
      state,
      userInfo: const UserInfo(email: ""),
    );
  }

  if (action is AddProductsAction) {
    return AppState.fromAppState(
      state,
      products: [...state.products, ...action.payload],
    );
  }

  if (action is SetOrdersAction) {
    return AppState.fromAppState(
      state,
      orders: action.payload,
    );
  }

  if (action is SetWishlistAction) {
    return AppState.fromAppState(
      state,
      favorites: action.payload,
    );
  }

  if (action is SetBasketAction) {
    return AppState.fromAppState(
      state,
      basket: action.payload,
    );
  }

  if (action is AddBasketItemAction) {
    bool found = false;
    List<ShoppingItem> newBasket = state.basket.map((e) {
      if (e.itemId == action.basketItem.itemId) {
        e.quantity++;
        found = true;
      }
      return e;
    }).toList();

    if (!found) newBasket = [...state.basket, action.basketItem];

    return AppState.fromAppState(
      state,
      basket: newBasket,
    );
  }

  if (action is UpdateBasketItemAction) {
    List<ShoppingItem> newBasket = state.basket
        .map((e) => e.itemId == action.item.id ? action.item : e)
        .toList();

    return AppState.fromAppState(
      state,
      basket: newBasket,
    );
  }

  if (action is IncrementQuantityAction) {
    List<ShoppingItem> newBasket = state.basket.map((element) {
      if (element.itemId == action.itemId) element.quantity++;
      return element;
    }).toList();

    return AppState.fromAppState(
      state,
      basket: newBasket,
    );
  }

  if (action is DecrementQuantityAction) {
    List<ShoppingItem> newBasket = state.basket.map((element) {
      if (element.itemId == action.itemId) element.quantity--;
      return element;
    }).toList();

    return AppState.fromAppState(
      state,
      basket: newBasket,
    );
  }

  if (action is DeleteBasketItemAction) {
    List<ShoppingItem> newBasket = state.basket
        .where((element) => element.itemId != action.itemId)
        .toList();

    return AppState.fromAppState(
      state,
      basket: newBasket,
    );
  }

  if (action is AddWishlistItemAction) {
    bool found = false;
    List<ShoppingItem> newWishlist = state.favorites.map((e) {
      if (e.itemId == action.wishlistItem.itemId) {
        e.quantity++;
        found = true;
      }
      return e;
    }).toList();

    if (!found) newWishlist = [...state.favorites, action.wishlistItem];

    return AppState.fromAppState(
      state,
      favorites: newWishlist,
    );
  }

  if (action is RemoveWishlistItemAction) {
    List<ShoppingItem> newWishlist = state.favorites
        .where((element) => element.itemId != action.wishlistItem.itemId)
        .toList();

    return AppState.fromAppState(
      state,
      favorites: newWishlist,
    );
  }

  throw Exception("$action not implemented!");
}
