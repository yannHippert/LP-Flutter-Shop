import 'package:flutter/material.dart';
import 'package:flutter_sweater_shop/Models/order.dart';
import 'package:flutter_sweater_shop/Models/product_color.dart';
import 'package:flutter_sweater_shop/Models/product_size.dart';
import 'package:flutter_sweater_shop/Models/shopping_item.dart';
import 'package:flutter_sweater_shop/Models/variable_product.dart';
import 'package:uuid/uuid.dart';
import 'dart:math';

const uuid = Uuid();

Iterable<int> range(int low, int high) sync* {
  for (int i = low; i < high; ++i) {
    yield i;
  }
}

const _chars = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
Random _rnd = Random();

String getRandomString({int length = 24}) =>
    String.fromCharCodes(Iterable.generate(
        length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));

Map<String, dynamic> redJson = {
  "id": 1,
  "name": "Red",
  "r": Colors.red.red,
  "g": Colors.red.green,
  "b": Colors.red.blue
};
var redColor = ProductColor.fromJson(redJson);

Map<String, dynamic> blueJson = {
  "id": 2,
  "name": "Blue",
  "r": Colors.blue.red,
  "g": Colors.blue.green,
  "b": Colors.blue.blue
};
var blueColor = ProductColor.fromJson(blueJson);

Map<String, dynamic> greenJson = {
  "id": 3,
  "name": "Green",
  "r": Colors.green.red,
  "g": Colors.green.green,
  "b": Colors.green.blue
};
var greenColor = ProductColor.fromJson(greenJson);

Map<String, dynamic> blackJson = {
  "id": 4,
  "name": "Black",
  "r": Colors.black.red,
  "g": Colors.black.green,
  "b": Colors.black.blue
};
var blackColor = ProductColor.fromJson(blackJson);

Map<String, dynamic> xsJson = {"id": uuid.v4(), "name": "XS"};
var xsSize = ProductSize.fromJson(xsJson);

Map<String, dynamic> sJson = {"id": uuid.v4(), "name": "S"};
var sSize = ProductSize.fromJson(sJson);

Map<String, dynamic> mJson = {"id": uuid.v4(), "name": "M"};
var mSize = ProductSize.fromJson(mJson);

Map<String, dynamic> lJson = {"id": uuid.v4(), "name": "L"};
var lSize = ProductSize.fromJson(lJson);

Map<String, dynamic> xlJson = {"id": uuid.v4(), "name": "XL"};
var xlSize = ProductSize.fromJson(xlJson);

Map<String, dynamic> pulloverJson = {
  "id": uuid.v4(),
  "name": "Ugly sweater",
  "image":
      "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSlHelq5ROszBU8HOaG6qV_KeWZYkEwI9MEnQ&usqp=CAU",
  "description": "This is the description for the product with the id: 1",
  "category": {"id": 1, "name": "Pullover"},
  "variants": [
    {"id": getRandomString(), "price": 19.99, "size": xsJson},
    {"id": getRandomString(), "price": 19.99, "size": sJson},
    {"id": getRandomString(), "price": 20.99, "size": mJson},
    {"id": getRandomString(), "price": 21.99, "size": lJson},
    {"id": getRandomString(), "price": 25.99, "size": xlJson}
  ]
};

Map<String, dynamic> bonnetJson = {
  "id": uuid.v4(),
  "name": "Bonnet",
  "image":
      "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRiGS_GuN-9xgH1B9U9HzCkkEa67BTdlpdeOw&usqp=CAU",
  "description": "This is the description for the product with the id: 2",
  "category": {"id": 2, "name": "Hat"},
  "variants": [
    {"id": getRandomString(), "price": 9.99, "color": redJson},
    {"id": getRandomString(), "price": 10.99, "color": blackJson},
    {"id": getRandomString(), "price": 10.99, "color": greenJson},
    {"id": getRandomString(), "price": 10.99, "color": blueJson},
  ]
};

Map<String, dynamic> gloveJson = {
  "id": uuid.v4(),
  "name": "Glove",
  "image":
      "https://www.wollwerkstatt.at/media/3e/7e/c9/1649330166/fingerhandschuhe_weinrot.jpg",
  "description": "This is the description for the product with the id: 3",
  "category": {"id": 3, "name": "Glove"},
  "variants": [
    {"id": getRandomString(), "price": 9.99, "color": blackJson, "size": mJson},
    {"id": getRandomString(), "price": 9.99, "color": blackJson, "size": lJson},
    {
      "id": getRandomString(),
      "price": 9.99,
      "color": blackJson,
      "size": xlJson
    },
    {"id": getRandomString(), "price": 10.99, "color": redJson, "size": mJson},
    {"id": getRandomString(), "price": 10.99, "color": redJson, "size": lJson},
  ]
};

var sweater = VariableProduct.fromJson(pulloverJson);
var bonnet = VariableProduct.fromJson(bonnetJson);
var glove = VariableProduct.fromJson(gloveJson);

List<VariableProduct> getPorudctList({int count = 10}) {
  List<VariableProduct> products = [];
  for (int _ in range(0, (count / 2).floor())) {
    //products.add(bonnet);
    products.add(sweater);
    products.add(bonnet);
    products.add(glove);
  }
  return products;
}

Order order = Order(id: 1, totalPrice: 99.99, items: {}, date: DateTime.now());

List<Order> getOrderList({int count = 10}) {
  List<Order> orders = [];
  for (int _ in range(1, count)) {
    orders.add(order);
  }
  return orders;
}

List<ShoppingItem> getBasketItems({int count = 5}) {
  List<ShoppingItem> basket = [];
  for (int _ in range(1, 12)) {
    basket.add(ShoppingItem.fromProduct(
        sweater, sweater.variants.elementAt(0).size, null));
  }
  return basket;
}
