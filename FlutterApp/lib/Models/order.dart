import 'package:flutter_sweater_shop/Models/shopping_item.dart';
import 'package:flutter_sweater_shop/Models/variable_product.dart';
import 'package:flutter_sweater_shop/Models/variant.dart';

class Order {
  final int id;
  final double totalPrice;
  final Map<ShoppingItem, int> items;
  final DateTime date;

  Order(
      {required this.id,
      required this.totalPrice,
      required this.items,
      required this.date});

  factory Order.fromJson(Map<String, dynamic> json) {
    List<Map<String, dynamic>> itemsJson = json['items'];
    Map<ShoppingItem, int> orderItems = {};
    for (var itemJson in itemsJson) {
      orderItems.putIfAbsent(ShoppingItem.fromJson(itemJson['variant']),
          () => itemJson["quantity"] as int);
    }

    return Order(
        id: json['id'],
        totalPrice: json['name'],
        items: orderItems,
        date: json['base_price']);
  }
}
