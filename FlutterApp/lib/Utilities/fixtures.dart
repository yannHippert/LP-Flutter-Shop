import 'package:flutter/material.dart';
import 'package:flutter_sweater_shop/Models/order.dart';
import 'package:flutter_sweater_shop/Models/price.dart';
import 'package:flutter_sweater_shop/Models/product.dart';
import 'package:flutter_sweater_shop/Models/product_color.dart';

Iterable<int> range(int low, int high) sync* {
  for (int i = low; i < high; ++i) {
    yield i;
  }
}

Product bonnet = Product(
  id: "b-001",
  name: "Bonnet",
  basePrice: 19.99,
  image:
      "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRiGS_GuN-9xgH1B9U9HzCkkEa67BTdlpdeOw&usqp=CAU",
  colors: [
    PropertyPrice(0, ProductColor.fromColor(name: "Red", color: Colors.red)),
    PropertyPrice(
        0, ProductColor.fromColor(name: "Green", color: Colors.green)),
    PropertyPrice(1, ProductColor.fromColor(name: "Blue", color: Colors.blue)),
  ],
);

Product sweater = Product(
  id: "s-001",
  name: "Sweater",
  basePrice: 29.99,
  image:
      "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSlHelq5ROszBU8HOaG6qV_KeWZYkEwI9MEnQ&usqp=CAU",
  sizes: [
    PropertyPrice(-1, "S"),
    PropertyPrice(0, "M"),
    PropertyPrice(1, "L"),
    PropertyPrice(2, "XL")
  ],
);

List<Product> getPorudctList({int count = 10}) {
  List<Product> products = [];
  for (int _ in range(1, 12)) {
    products.add(bonnet);
    products.add(sweater);
  }
  return products;
}

Order order = Order(
    id: "o-001", totalPrice: 99.99, products: [sweater], date: DateTime.now());

List<Order> getOrderList({int count = 10}) {
  List<Order> orders = [];
  for (int _ in range(1, 12)) {
    orders.add(order);
  }
  return orders;
}
