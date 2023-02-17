import 'package:flutter_sweater_shop/Models/order.dart';
import 'package:flutter_sweater_shop/Models/product.dart';
import 'package:flutter_sweater_shop/Models/user_info.dart';

class AppState {
  final UserInfo userInfo;
  final List<Product> products;
  final List<Product> favorites;
  final List<Order> orders;

  AppState(
      {required this.products,
      required this.userInfo,
      required this.favorites,
      required this.orders});

  AppState.initialState(
      {this.products = const [],
      this.userInfo = const UserInfo(),
      this.favorites = const [],
      this.orders = const []});
}
