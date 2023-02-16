import 'package:flutter_sweater_shop/Models/order.dart';
import 'package:flutter_sweater_shop/Models/product.dart';
import 'package:flutter_sweater_shop/Models/user_info.dart';

class AppState {
  final UserInfo userInfo;
  final List<Product> products;
  final List<Product> wishlist;
  final List<Order> orders;

  AppState(
      {this.products = const [],
      this.userInfo = const UserInfo(),
      this.wishlist = const [],
      this.orders = const []});
}
