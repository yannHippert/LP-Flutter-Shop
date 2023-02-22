import 'package:flutter_sweater_shop/Exceptions/api_exception.dart';
import 'package:flutter_sweater_shop/Exceptions/register_exception.dart';
import 'package:flutter_sweater_shop/Models/order.dart';
import 'package:flutter_sweater_shop/Models/shopping_item.dart';
import 'package:flutter_sweater_shop/Models/variable_product.dart';
import 'package:flutter_sweater_shop/Utilities/fixtures.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ApiClient {
  static Future<void> dummy(dynamic any) async {
    int statusCode = await Future.delayed(
      const Duration(seconds: 1),
      () => 200,
    );
    if (statusCode == 200) return;

    throw ApiException(statusCode);
  }

  // static Future<bool> autheticate(String email, String password) async {
  //   int statusCode = await Future.delayed(
  //     const Duration(seconds: 2),
  //     () => email == "sweater@shop.com" && password == "password" ? 200 : 409,
  //   );
  //   if (statusCode == 200) return true;

  //   throw ApiException(statusCode);
  // }

  static Future<String> register(String email, String password) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      return userCredential.user!.uid;
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'email-already-in-use':
          throw RegisterException('Email already in use');
        case 'weak-password':
          throw RegisterException('Weak password');
        default:
          throw RegisterException('Unknown error');
      }
    } catch (e) {
      throw ApiException(500);
    }
  }

  static Future<String> authenticate(String email, String password) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      return userCredential.user!.uid;
    } on Exception catch (_) {
      throw ApiException(409);
    }
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
