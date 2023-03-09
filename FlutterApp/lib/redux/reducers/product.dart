import 'package:flutter/foundation.dart';
import 'package:flutter_sweater_shop/Models/variable_product.dart';
import 'package:flutter_sweater_shop/redux/actions/product.dart';

List<VariableProduct> productsReducer(List<VariableProduct> products, action) {
  if (action is AddProductsAction) {
    if (kDebugMode) {
      print(
          "[PRODUCT-REDUCER] Adding products: ${action.payload.length} products");
    }

    return [...products, ...action.payload];
  }

  if (action is SetProductsAction) {
    if (kDebugMode) {
      print(
          "[PRODUCT-REDUCER] Setting products: ${action.payload.length} products");
    }

    return action.payload;
  }

  return products;
}
