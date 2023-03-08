import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter_sweater_shop/Exceptions/api_exception.dart';
import 'package:flutter_sweater_shop/Exceptions/register_exception.dart';
import 'package:flutter_sweater_shop/Models/order.dart' as ShopOrder;
import 'package:flutter_sweater_shop/Models/product_category.dart';
import 'package:flutter_sweater_shop/Models/shopping_item.dart';
import 'package:flutter_sweater_shop/Models/variable_product.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_sweater_shop/data/gloves.dart';
import 'package:flutter_sweater_shop/data/hats.dart';
import 'package:flutter_sweater_shop/data/sweater.dart';
import 'package:uuid/uuid.dart';

class ApiClient {
  static Future<void> generateSampleData() async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;

    // Define an array of sample products
    List<Map<String, dynamic>> products = [...sweaters, ...hats, ...gloves];

    try {
      // Loop through the array and add each product to Firestore
      for (var product in products) {
        await firestore.collection('products').doc(product['id']).set(product);
      }

      print('Sample data added to Firestore');
    } catch (e) {
      print('Error adding sample data to Firestore: $e');
    }
  }

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

  static Future<void> updateWishlist(List<ShoppingItem> items) async {
    try {
      final firestore = FirebaseFirestore.instance;
      final user = FirebaseAuth.instance.currentUser;

      if (user == null) throw ApiException(401);

      final batch = firestore.batch();

      // Delete existing items
      final existingItems = await firestore
          .collection('wishlists')
          .doc(user.uid)
          .collection('items')
          .get();
      for (final doc in existingItems.docs) {
        batch.delete(doc.reference);
      }

      // Add new items
      for (final item in items) {
        batch.set(
          firestore
              .collection('wishlists')
              .doc(user.uid)
              .collection('items')
              .doc(item.itemId),
          item.toJson(),
        );
      }

      await batch.commit();
    } catch (e) {
      throw ApiException(500);
    }
  }

  static Future<List<ShoppingItem>> fetchWishlist() async {
    try {
      final firestore = FirebaseFirestore.instance;
      final user = FirebaseAuth.instance.currentUser;

      if (user == null) throw ApiException(401);

      final querySnapshot = await firestore
          .collection('wishlists')
          .doc(user.uid)
          .collection('items')
          .get();

      return querySnapshot.docs
          .map((doc) => ShoppingItem.fromJson(doc.data()))
          .toList();
    } catch (e) {
      throw ApiException(500);
    }
  }

  static Future<String> authenticate(String email, String password) async {
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (kDebugMode) print("[API-CLIENT] Authenticated");
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

  static Query<dynamic>? next;
  //Needed to check if the query changed;
  static String _searchText = "";
  static List<String> _selectedCategories = [];

  static Future<Map<String, dynamic>> fetchProducts({
    String searchText = "",
    List<ProductCategory> categories = const [],
  }) async {
    if (kDebugMode) print("[API_CLIENT] Fetching products");
    const limit = 6;
    Map<String, dynamic> result = {};
    result.putIfAbsent("first", () => false);
    List<String> selectedCategories = categories.map((e) => e.id).toList();
    final firestore = FirebaseFirestore.instance;
    if (_searchText != searchText ||
        !(_selectedCategories.length == selectedCategories.length &&
            _selectedCategories.every(
              (e) => selectedCategories.contains(e),
            ))) {
      _searchText = searchText;
      _selectedCategories = selectedCategories;
      next = null;
      result.update("first", (value) => true);
    }

    var query = firestore.collection('products').orderBy("name").limit(limit);

    if (searchText != "") {
      query = query.where('name', isGreaterThanOrEqualTo: searchText);
    }

    if (selectedCategories.isNotEmpty) {
      query = query.where('category', whereIn: selectedCategories);
    }

    final querySnapshot = next == null ? await query.get() : await next!.get();

    var products = querySnapshot.docs
        .map((doc) => VariableProduct.fromJson(doc.data()))
        .toList();

    if (kDebugMode) {
      print("[API_CLIENT] Fetched products: ${products.length} products");
    }

    if (products.isNotEmpty) {
      next = query.startAfter([products.last.name]);
    }

    result.putIfAbsent("products", () => products);
    return result;
  }

  static Future<VariableProduct> fetchProduct(String id) async {
    final firestore = FirebaseFirestore.instance;
    try {
      final doc = await firestore.collection('products').doc(id).get();
      return VariableProduct.fromJson(doc.data()!);
    } catch (e) {
      throw ApiException(500);
    }
  }

  static Future<List<ShopOrder.Order>> fetchOrders() async {
    final firestore = FirebaseFirestore.instance;
    try {
      final querySnapshot = await firestore
          .collection('orders')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection('details')
          .orderBy("createdAt", descending: true)
          .get();

      var orders = querySnapshot.docs
          .map((doc) => ShopOrder.Order.fromJson(doc.data()))
          .toList();

      return orders;
    } catch (_) {
      throw ApiException(500);
    }
  }

  static Future<void> addOrder(ShopOrder.Order order) async {
    final firestore = FirebaseFirestore.instance;
    try {
      await firestore
          .collection('orders')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection('details')
          .doc(order.id)
          .set(order.toJson());
    } catch (_) {
      throw ApiException(500);
    }
  }

  static Future<List<ShoppingItem>> fetchBasket() async {
    final firestore = FirebaseFirestore.instance;

    try {
      final querySnapshot = await firestore
          .collection('basket')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection('items')
          .orderBy("productId")
          .get();

      if (kDebugMode) {
        print(
            "[API-CLIENT] Fetched basket: ${querySnapshot.docs.length.toString()} items found");
      }
      return querySnapshot.docs
          .map((doc) => ShoppingItem.fromJson(doc.data()))
          .toList();
    } catch (e) {
      throw ApiException(500);
    }
  }

  static Future<void> setBasketItem(ShoppingItem item) async {
    final firestore = FirebaseFirestore.instance;

    try {
      await firestore
          .collection('basket')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection('items')
          .doc(item.itemId)
          .set(item.toJson());

      if (kDebugMode) {
        print("[API-CLIENT] Set the basket-item");
      }
    } catch (_) {
      throw ApiException(500);
    }
  }

  static Future<void> deleteBasketItem(String itemId) async {
    final firestore = FirebaseFirestore.instance;
    try {
      await firestore
          .collection('basket')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection('items')
          .doc(itemId)
          .delete();
    } catch (_) {
      throw ApiException(500);
    }
  }

  static Future<void> clearBasket() async {
    final firestore = FirebaseFirestore.instance;
    try {
      await firestore
          .collection('basket')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection('items')
          .get()
          .then((snapshot) {
        for (DocumentSnapshot ds in snapshot.docs) {
          ds.reference.delete();
        }
      });

      if (kDebugMode) {
        print("[API-CLIENT] Cleared basket");
      }
    } catch (_) {
      throw ApiException(500);
    }
  }

  static Future<List<ProductCategory>> fetchCategories() async {
    final firestore = FirebaseFirestore.instance;

    try {
      final querySnapshot = await firestore.collection('categories').get();

      if (kDebugMode) {
        print(
            "[API-CLIENT] Fetched categories: ${querySnapshot.docs.length.toString()} items found");
      }
      return querySnapshot.docs
          .map((doc) => ProductCategory.fromJson(doc.id, doc.data()))
          .toList();
    } catch (e) {
      throw ApiException(500);
    }
  }
}
