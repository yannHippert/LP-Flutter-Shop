import 'dart:async';

import 'package:flutter_sweater_shop/Exceptions/api_exception.dart';
import 'package:flutter_sweater_shop/Models/product_category.dart';
import 'package:flutter_sweater_shop/Utilities/api_client.dart';
import 'package:flutter_sweater_shop/redux/actions/category.dart';
import 'package:flutter_sweater_shop/redux/app_state.dart';
import 'package:redux_thunk/redux_thunk.dart';
import 'package:redux/redux.dart';

ThunkAction<AppState> fetchCategories(
  Completer completer,
) {
  return (Store<AppState> store) async {
    try {
      List<ProductCategory> categories = await ApiClient.fetchCategories();
      store.dispatch(SetCategoriesAction(categories));
      completer.complete();
    } on ApiException catch (e) {
      completer.completeError(e);
    }
  };
}
