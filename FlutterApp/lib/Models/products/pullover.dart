import 'package:flutter_sweater_shop/Models/product.dart';
import 'package:flutter_sweater_shop/Models/product_color.dart';
import 'package:flutter_sweater_shop/Models/size.dart';
import 'package:flutter_sweater_shop/Models/variant.dart';

class Pullover extends Product {
  Pullover(
      {required int id,
      required String name,
      required String image,
      required List<ProductVariant> variants})
      : super(id, name, image, variants);

  factory Pullover.fromJson(Map<String, dynamic> json) {
    int id = json['id'];
    String name = json['name'];
    String image = json['image'];
    List<ProductVariant> variants = [];

    return Pullover(id: id, name: name, image: image, variants: variants);
  }

  @override
  double get minPrice {
    ProductVariant min = super
        .variants
        .reduce((min, element) => element.price < min.price ? element : min);
    return min.price;
  }

  @override
  List<ProductColor> get colors => [];

  @override
  List<Size> get sizes {
    return variants.where((e) => e.hasSize).map((e) => e.size).toSet().toList()
        as List<Size>;
  }
}
