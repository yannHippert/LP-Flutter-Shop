import 'package:flutter/foundation.dart';
import 'package:flutter_sweater_shop/Models/product_category.dart';
import 'package:flutter_sweater_shop/redux/actions/category.dart';

List<ProductCategory> categoryReducer(
    List<ProductCategory> categories, action) {
  if (action is SetCategoriesAction) {
    if (kDebugMode) {
      print(
          "[CATEGORY-REDUCER] Setting categories: ${action.payload.length} categories");
    }

    return action.payload;
  }

  return categories;
}
