import 'package:flutter_sweater_shop/Models/shopping_item.dart';
import 'package:flutter_sweater_shop/Utilities/fixtures.dart';

class Order {
  final String id;
  final double subtotal;
  final double shipping;
  final double total;
  final int itemQuantity;
  final List<ShoppingItem> items;
  final DateTime createdAt;

  Order({
    required this.subtotal,
    required this.shipping,
    required this.total,
    required this.itemQuantity,
    required this.items,
    String? id,
    DateTime? createdAt,
  })  : this.id = id ?? uuid.v4(),
        this.createdAt = createdAt ?? DateTime.now();

  factory Order.fromJson(Map<String, dynamic> json) {
    List<dynamic> itemsJson = json['items'];
    List<ShoppingItem> orderItems =
        itemsJson.map((itemJson) => ShoppingItem.fromJson(itemJson)).toList();

    return Order(
        id: json['id'],
        subtotal: json['subtotal'],
        shipping: json['shipping'],
        total: json['total'],
        itemQuantity: json['itemQuantity'],
        items: orderItems,
        createdAt: DateTime.fromMillisecondsSinceEpoch(json['createdAt']));
  }

  factory Order.fromBasket(List<ShoppingItem> basket) {
    double subtotal = 0;
    int itemQuantity = 0;
    for (var item in basket) {
      subtotal += item.price * item.quantity;
      itemQuantity += item.quantity;
    }
    double shippingFee = itemQuantity * 2 - 1;
    double total = subtotal + shippingFee;

    return Order(
      subtotal: subtotal,
      shipping: shippingFee,
      total: total,
      itemQuantity: itemQuantity,
      items: basket,
    );
  }

  Map<String, dynamic> toJson() {
    var orderItems = items.map((item) => item.toJson()).toList();
    return {
      'id': id,
      'items': orderItems,
      'subtotal': subtotal,
      'shipping': shipping,
      'itemQuantity': itemQuantity,
      'total': total,
      'createdAt': DateTime.now().millisecondsSinceEpoch
    };
  }
}
