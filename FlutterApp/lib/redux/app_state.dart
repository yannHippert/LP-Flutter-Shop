import 'package:flutter_sweater_shop/Models/order.dart';
import 'package:flutter_sweater_shop/Models/product_category.dart';
import 'package:flutter_sweater_shop/Models/shopping_item.dart';
import 'package:flutter_sweater_shop/Models/variable_product.dart';
import 'package:flutter_sweater_shop/Models/user_info.dart';
import 'package:collection/collection.dart';

class AppState {
  final UserInfo userInfo;
  final List<VariableProduct> products;
  final List<ShoppingItem> wishlist;
  final List<ShoppingItem> basket;
  final List<Order> orders;
  final List<ProductCategory> categories;

  AppState({
    required this.userInfo,
    required this.products,
    required this.wishlist,
    required this.orders,
    required this.basket,
    required this.categories,
  });

  AppState.initialState({
    this.products = const [],
    this.userInfo = const UserInfo(),
    this.wishlist = const [],
    this.orders = const [],
    this.basket = const [],
    this.categories = const [],
  });

  VariableProduct? getProductById(String id) {
    return products.firstWhereOrNull((element) => element.id == id);
  }
}
