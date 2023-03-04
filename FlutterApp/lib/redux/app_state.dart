import 'package:flutter_sweater_shop/Models/order.dart';
import 'package:flutter_sweater_shop/Models/shopping_item.dart';
import 'package:flutter_sweater_shop/Models/variable_product.dart';
import 'package:flutter_sweater_shop/Models/user_info.dart';
import 'package:collection/collection.dart';

class AppState {
  final UserInfo userInfo;
  final List<VariableProduct> products;
  final List<ShoppingItem> whishlist;
  final List<ShoppingItem> basket;
  final List<Order> orders;

  AppState({
    required this.userInfo,
    required this.products,
    required this.whishlist,
    required this.orders,
    required this.basket,
  });

  factory AppState.fromAppState(
    AppState oldState, {
    UserInfo? userInfo,
    List<VariableProduct>? products,
    List<ShoppingItem>? whishlist,
    List<ShoppingItem>? basket,
    List<Order>? orders,
  }) {
    return AppState(
      userInfo: userInfo ?? oldState.userInfo,
      products: products ?? oldState.products,
      whishlist: whishlist ?? oldState.whishlist,
      orders: orders ?? oldState.orders,
      basket: basket ?? oldState.basket,
    );
  }

  AppState.initialState({
    this.products = const [],
    this.userInfo = const UserInfo(),
    this.whishlist = const [],
    this.orders = const [],
    this.basket = const [],
  });

  double get basketPrice {
    double value = 0;
    for (var element in basket) {
      value += element.price;
    }
    return value;
  }

  VariableProduct? getProductById(String id) {
    return products.firstWhereOrNull((element) => element.id == id);
  }
}
