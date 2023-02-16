import 'package:flutter_sweater_shop/Models/product.dart';

class Order {
  final String _id;
  final double _totalPrice;
  final List<Product> _products;
  final DateTime _date;

  Order(
      {required String id,
      required double totalPrice,
      required List<Product> products,
      required DateTime date})
      : _id = id,
        _totalPrice = totalPrice,
        _products = products,
        _date = date;

  factory Order.fromJson(Map<String, dynamic> json) {
    List<Map<String, dynamic>> productsJson = json['image'];
    List<Product> products = productsJson
        .map((productJson) => Product.fromJson(productJson))
        .toList();

    return Order(
        id: json['id'],
        totalPrice: json['name'],
        products: products,
        date: json['base_price']);
  }

  String get id {
    return _id;
  }

  double get totalPrice {
    return _totalPrice;
  }

  List<Product> get products {
    return _products;
  }

  DateTime get date {
    return _date;
  }
}
