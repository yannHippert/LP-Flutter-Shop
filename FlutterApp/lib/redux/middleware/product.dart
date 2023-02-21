import 'dart:async';

import 'package:flutter_sweater_shop/Exceptions/api_exception.dart';
import 'package:flutter_sweater_shop/Models/variable_product.dart';
import 'package:flutter_sweater_shop/Utilities/api_client.dart';
import 'package:flutter_sweater_shop/redux/actions/product.dart';
import 'package:flutter_sweater_shop/redux/app_state.dart';
import 'package:redux_thunk/redux_thunk.dart';
import 'package:redux/redux.dart';

ThunkAction<AppState> fetchProducts(Completer completer) {
  return (Store<AppState> store) async {
    try {
      List<VariableProduct> products = await ApiClient.fetchProducts();
      store.dispatch(AddProductsAction(products));
      completer.complete();
    } on ApiException catch (e) {
      completer.completeError(e);
    }
  };
}
