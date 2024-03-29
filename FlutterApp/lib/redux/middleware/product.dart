import 'dart:async';

import 'package:flutter_sweater_shop/Exceptions/api_exception.dart';
import 'package:flutter_sweater_shop/Models/product_category.dart';
import 'package:flutter_sweater_shop/Utilities/api_client.dart';
import 'package:flutter_sweater_shop/redux/actions/product.dart';
import 'package:flutter_sweater_shop/redux/app_state.dart';
import 'package:redux_thunk/redux_thunk.dart';
import 'package:redux/redux.dart';

ThunkAction<AppState> fetchProducts(
  Completer completer, {
  String searchText = "",
  List<ProductCategory> categories = const [],
}) {
  return (Store<AppState> store) async {
    try {
      Map<String, dynamic> result = await ApiClient.fetchProducts(
        searchText: searchText,
        categories: categories,
      );
      if (result["first"]) {
        store.dispatch(SetProductsAction(result["products"]));
      } else {
        store.dispatch(AddProductsAction(result["products"]));
      }
      completer.complete();
    } on ApiException catch (e) {
      completer.completeError(e);
    }
  };
}
