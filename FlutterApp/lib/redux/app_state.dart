import 'package:flutter_sweater_shop/Models/order.dart';
import 'package:flutter_sweater_shop/Models/shopping_item.dart';
import 'package:flutter_sweater_shop/Models/variable_product.dart';
import 'package:flutter_sweater_shop/Models/user_info.dart';

class AppState {
  final UserInfo userInfo;
  final List<VariableProduct> products;
  final List<ShoppingItem> favorites;
  final List<ShoppingItem> basket;
  final List<Order> orders;

  AppState({
    required this.userInfo,
    required this.products,
    required this.favorites,
    required this.orders,
    required this.basket,
  });

  factory AppState.fromAppState(
    AppState oldState, {
    UserInfo? userInfo,
    List<VariableProduct>? products,
    List<ShoppingItem>? favorites,
    List<ShoppingItem>? basket,
    List<Order>? orders,
  }) {
    return AppState(
        userInfo: userInfo ?? oldState.userInfo,
        products: products ?? oldState.products,
        favorites: favorites ?? oldState.favorites,
        orders: orders ?? oldState.orders,
        basket: basket ?? oldState.basket);
  }

  AppState.initialState(
      {this.products = const [],
      this.userInfo = const UserInfo(),
      this.favorites = const [],
      this.orders = const [],
      this.basket = const []});
}
