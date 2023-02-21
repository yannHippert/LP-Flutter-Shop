import 'package:flutter_sweater_shop/Models/product_color.dart';
import 'package:flutter_sweater_shop/Models/product_size.dart';

class ProductVariant {
  final String id;
  final double price;
  final ProductSize? size;
  final ProductColor? color;

  ProductVariant(this.id, this.price, this.size, this.color);

  factory ProductVariant.fromJson(Map<String, dynamic> json) {
    ProductSize? productSize =
        json['size'] != null ? ProductSize.fromJson(json['size']) : null;
    ProductColor? productColor =
        json['color'] != null ? ProductColor.fromJson(json['color']) : null;

    return ProductVariant(
      json['id'],
      json['price'] as double,
      productSize,
      productColor,
    );
  }

  bool get hasSize => size != null;

  bool get hasColor => color != null;
}
