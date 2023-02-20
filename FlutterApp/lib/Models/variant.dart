import 'package:flutter_sweater_shop/Models/product_color.dart';
import 'package:flutter_sweater_shop/Models/size.dart';

class ProductVariant {
  final int _id;
  final double _price;
  final Size? _size;
  final ProductColor? _productColor;

  ProductVariant(this._id, this._price, this._size, this._productColor);

  factory ProductVariant.fromJson(Map<String, dynamic> json) =>
      ProductVariant(json['id'], json['price'], json['size'], json['color']);

  int get id => _id;

  double get price => _price;

  Size? get size => _size;

  ProductColor? get color => _productColor;

  bool get hasSize => size != null;
}
