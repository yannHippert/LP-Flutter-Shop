import 'package:flutter_sweater_shop/Models/category.dart';
import 'package:flutter_sweater_shop/Models/product_color.dart';
import 'package:flutter_sweater_shop/Models/products/pullover.dart';
import 'package:flutter_sweater_shop/Models/size.dart';
import 'package:flutter_sweater_shop/Models/variant.dart';

abstract class Product {
  final int id;
  final String name;
  final String image;
  final List<ProductVariant> variants;

  Product(this.id, this.name, this.image, this.variants);

  /*factory Product.named(
          {required int id,
          required String name,
          required String image,
          required List<ProductVariant> varianrs}) =>
      Product(id, name, image, varianrs);*/

  factory Product.fromJson(Map<String, dynamic> json) {
    if (Category.fromJson(json['category']).name == "Pullover") {
      return Pullover.fromJson(json);
    }
    return Pullover.fromJson(json);
    //return Product(json['id'], json['name'], json['image'], []);
  }

  double get minPrice;

  List<ProductColor> get colors;

  List<Size> get sizes;

  bool get isColorable => colors.isEmpty;

  bool get isSizeable => sizes.isEmpty;
}
