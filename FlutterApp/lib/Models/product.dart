import 'package:flutter_sweater_shop/Models/price.dart';
import 'package:flutter_sweater_shop/Models/product_color.dart';

class Product {
  final String _id;
  final String _name;
  final double _basePrice;
  final String _image;
  final List<PropertyPrice<ProductColor>> _colors;
  final List<PropertyPrice<String>> _sizes;
  bool isSelected = false;

  Product(
      {required String id,
      required String name,
      required String image,
      required double basePrice,
      List<PropertyPrice<ProductColor>>? colors,
      List<PropertyPrice<String>>? sizes})
      : _id = id,
        _name = name,
        _basePrice = basePrice,
        _image = image,
        _colors = colors ?? [],
        _sizes = sizes ?? [];

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
        id: json['id'],
        name: json['name'],
        image: json['image'],
        basePrice: json['base_price']);
  }

  String get id {
    return _id;
  }

  String get name {
    return _name;
  }

  double get basePrice {
    return _basePrice;
  }

  String get image {
    return _image;
  }

  List<ProductColor> get colors {
    return _colors.map((c) => c.property).toList();
  }

  bool get isColorable {
    return _colors.isNotEmpty;
  }

  List<String> get sizes {
    return _sizes.map((s) => s.property).toList();
  }

  double getPrice({String? size, ProductColor? color}) {
    double sizeVariation = size != null
        ? _sizes
            .firstWhere((element) => element.property == size)
            .priceVariation
        : 0;
    double colorVariation = color != null
        ? _colors
            .firstWhere((element) => element.property == color)
            .priceVariation
        : 0;
    return _basePrice + sizeVariation + colorVariation;
  }
}
