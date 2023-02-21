import 'package:flutter_sweater_shop/Exceptions/api_exception.dart';
import 'package:flutter_sweater_shop/Models/order.dart';
import 'package:flutter_sweater_shop/Models/shopping_item.dart';
import 'package:flutter_sweater_shop/Models/variable_product.dart';
import 'package:flutter_sweater_shop/Utilities/fixtures.dart';

class ApiClient {
  static Future<void> dummy(dynamic any) async {
    int statusCode = await Future.delayed(
      const Duration(seconds: 1),
      () => 200,
    );
    if (statusCode == 200) return;

    throw ApiException(statusCode);
  }

  static Future<bool> autheticate(String email, String password) async {
    int statusCode = await Future.delayed(
      const Duration(seconds: 2),
      () => email == "sweater@shop.com" && password == "password" ? 200 : 409,
    );
    if (statusCode == 200) return true;

    throw ApiException(statusCode);
  }

  static Future<bool> logout() async {
    int statusCode =
        await Future.delayed(const Duration(seconds: 2), () => 200);
    if (statusCode == 200) return true;

    throw ApiException(statusCode);
  }

  static Future<List<VariableProduct>> fetchProducts(
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

  static Future<List<ShoppingItem>> fetchBasket() async {
    int statusCode =
        await Future.delayed(const Duration(seconds: 1), () => 200);
    if (statusCode == 200) return getBasketItems();

    throw ApiException(statusCode);
  }

  static Future<bool> addBasketItem(ShoppingItem item) async {
    int statusCode =
        await Future.delayed(const Duration(seconds: 1), () => 200);
    if (statusCode == 200) return true;

    throw ApiException(statusCode);
  }

  static Future<bool> deleteBasketItem(String itemId) async {
    int statusCode =
        await Future.delayed(const Duration(seconds: 1), () => 200);
    if (statusCode == 200) return true;

    throw ApiException(statusCode);
  }
}
