import 'package:flutter_sweater_shop/Models/product.dart';
import 'package:flutter_sweater_shop/Models/user_info.dart';

class AppState {
  final UserInfo userInfo;
  final List<Product> products;

  AppState({this.products = const [], this.userInfo = const UserInfo()});
}
