import 'dart:async';
import 'package:flutter_sweater_shop/Exceptions/api_exception.dart';
import 'package:flutter_sweater_shop/Utilities/api_client.dart';
import 'package:flutter_sweater_shop/redux/actions/wishlist.dart';
import 'package:redux_thunk/redux_thunk.dart';
import 'package:flutter_sweater_shop/Models/shopping_item.dart';
import 'package:flutter_sweater_shop/redux/app_state.dart';
import 'package:redux/redux.dart';

ThunkAction<AppState> fetchWishlist(Completer completer) {
  return (Store<AppState> store) async {
    try {
      List<ShoppingItem> wishlist = await ApiClient.fetchWishlist();
      store.dispatch(SetWishlistAction(wishlist));
      completer.complete();
    } on ApiException catch (e) {
      completer.completeError(e);
    }
  };
}

ThunkAction<AppState> addWishlistItem(
  ShoppingItem item,
  Completer completer,
) {
  return (Store<AppState> store) async {
    try {
      store.dispatch(AddWishlistItemAction(item));
      ApiClient.updateWishlist(store.state.whishlist);
      completer.complete();
    } on ApiException catch (e) {
      completer.completeError(e);
    }
  };
}

ThunkAction<AppState> removeWishlistItem(
  ShoppingItem item,
  Completer completer,
) {
  return (Store<AppState> store) async {
    try {
      store.dispatch(RemoveWishlistItemAction(item));
      ApiClient.updateWishlist(store.state.whishlist);
      completer.complete();
    } on ApiException catch (e) {
      completer.completeError(e);
    }
  };
}

ThunkAction<AppState> updateWishList(
  List<ShoppingItem> wishlist,
  Completer completer,
) {
  return (Store<AppState> store) async {
    try {
      store.dispatch(SetWishlistAction(wishlist));
      await ApiClient.updateWishlist(wishlist);
      completer.complete();
    } on ApiException catch (e) {
      completer.completeError(e);
    }
  };
}
