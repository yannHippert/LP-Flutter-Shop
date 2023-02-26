import 'package:flutter_sweater_shop/Exceptions/api_exception.dart';
import 'package:flutter_sweater_shop/Exceptions/register_exception.dart';
import 'package:flutter_sweater_shop/Models/order.dart' as my_order;
import 'package:flutter_sweater_shop/Models/shopping_item.dart';
import 'package:flutter_sweater_shop/Models/variable_product.dart';
import 'package:flutter_sweater_shop/Utilities/fixtures.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:uuid/uuid.dart';

class ApiClient {
  static Future<void> dummy(dynamic any) async {
    int statusCode = await Future.delayed(
      const Duration(seconds: 1),
      () => 200,
    );
    if (statusCode == 200) return;

    throw ApiException(statusCode);
  }

  static Future<void> generateSampleData() async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    const uuid = Uuid();

    // Define an array of sample products
    List<Map<String, dynamic>> products = [
      {
        "id": uuid.v4(),
        "name": "Product 1",
        "variants": [
          {
            "id": uuid.v4(),
            "name": "Variant 1",
            "color": {"id": uuid.v4(), "name": "Red", "r": 255, "g": 0, "b": 0},
            "size": {"id": uuid.v4(), "name": "Small"},
            "price": 10.99
          },
          {
            "id": uuid.v4(),
            "name": "Variant 2",
            "color": {
              "id": uuid.v4(),
              "name": "Blue",
              "r": 0,
              "g": 0,
              "b": 255
            },
            "size": {"id": uuid.v4(), "name": "Medium"},
            "price": 12.99
          }
        ],
        "description": "This is a sample product",
        "image":
            "https://imgcdn.carhartt.com/is/image/Carhartt//EU_A18_G99?\$pdp-primary-image-static-emea\$",
        "category": {"id": uuid.v4(), "name": "Category 1"}
      },
      {
        "id": uuid.v4(),
        "name": "Product 2",
        "variants": [
          {
            "id": uuid.v4(),
            "name": "Variant 1",
            "color": {
              "id": uuid.v4(),
              "name": "Green",
              "r": 0,
              "g": 255,
              "b": 0
            },
            //"size": {"id": uuid.v4(), "name": "Small"},
            "price": 9.99
          },
          {
            "id": uuid.v4(),
            "name": "Variant 2",
            "color": {"id": uuid.v4(), "name": "Black", "r": 0, "g": 0, "b": 0},
            //"size": {"id": uuid.v4(), "name": "Large"},
            "price": 14.99
          }
        ],
        "description": "This is another sample product",
        "image":
            "https://hestra-products.imgix.net/images/679_86d72eebdf-63660-390-1-original.jpg?&fit=clip&w=992&fm=jpg&bg=var(--beige1)&auto=compress,format",
        "category": {"id": uuid.v4(), "name": "Category 2"}
      }
    ];

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

  static Future<void> addToWishlist(ShoppingItem item) async {
    try {
      final firestore = FirebaseFirestore.instance;
      final user = FirebaseAuth.instance.currentUser;

      if (user == null) throw ApiException(401);

      await firestore
          .collection('whislists')
          .doc(user.uid)
          .collection('items')
          .doc(item.id)
          .set(item.toJson());
    } catch (e) {
      throw ApiException(500);
    }
  }

  static Future<void> removeFromWishlist(String itemId) async {
    try {
      final firestore = FirebaseFirestore.instance;
      final user = FirebaseAuth.instance.currentUser;

      if (user == null) throw ApiException(401);

      await firestore
          .collection('whislists')
          .doc(user.uid)
          .collection('items')
          .doc(itemId)
          .delete();
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
          .collection('whislists')
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
      {int maxItems = 10}) async {
    final firestore = FirebaseFirestore.instance;

    try {
      final querySnapshot =
          await firestore.collection('products').limit(maxItems).get();

      return querySnapshot.docs
          .map((doc) => VariableProduct.fromJson(doc.data()))
          .toList();
    } catch (_) {
      throw ApiException(500);
    }
  }

  static Future<List<my_order.Order>> fetchOrders() async {
    int statusCode =
        await Future.delayed(const Duration(seconds: 1), () => 200);
    if (statusCode == 200) return getOrderList();

    throw ApiException(statusCode);
  }

  static Future<List<ShoppingItem>> fetchBasket() async {
    final firestore = FirebaseFirestore.instance;

    try {
      final querySnapshot = await firestore
          .collection('basket')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection('items')
          .get();

      return querySnapshot.docs
          .map((doc) => ShoppingItem.fromJson(doc.data()))
          .toList();
    } catch (_) {
      throw ApiException(500);
    }
  }

  static Future<void> addBasketItem(ShoppingItem item) async {
    final firestore = FirebaseFirestore.instance;

    try {
      await firestore
          .collection('basket')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection('items')
          .doc(uuid.v4())
          .set(item.toJson());
    } catch (_) {
      throw ApiException(500);
    }
  }

  static Future<bool> deleteBasketItem(String itemId) async {
    final firestore = FirebaseFirestore.instance;
    try {
      await firestore
          .collection('basket')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection('items')
          .doc(itemId)
          .delete();

      return true;
    } catch (_) {
      throw ApiException(500);
    }
  }
}
