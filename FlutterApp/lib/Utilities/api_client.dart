import 'package:flutter_sweater_shop/Exceptions/ApiException.dart';
import 'package:flutter_sweater_shop/Models/order.dart';
import 'package:flutter_sweater_shop/Models/product.dart';
import 'package:flutter_sweater_shop/Utilities/fixtures.dart';

class ApiClient {
  static Future<bool> autheticate(String email, String password) async {
    //final response = await autheticate(email: email, password: password);
    //if (response.statusCode == 200) {
    int statusCode = await Future.delayed(
        const Duration(seconds: 2),
        () =>
            email == "sweater@shop.com" && password == "password" ? 200 : 409);
    if (statusCode == 200) return true;

    throw ApiException(statusCode);
  }

  static Future<List<Product>> fetchProducts(
      {int offset = 0, int limit = 10}) async {
    int statusCode =
        await Future.delayed(const Duration(seconds: 2), () => 200);
    if (statusCode == 200) return getPorudctList(count: limit);

    throw ApiException(statusCode);
  }

  static Future<List<Order>> fetchOrders() async {
    int statusCode =
        await Future.delayed(const Duration(seconds: 1), () => 200);
    if (statusCode == 200) return getOrderList();

    throw ApiException(statusCode);
  }
}
