import 'package:flutter_sweater_shop/Models/product.dart';
import 'package:flutter_sweater_shop/Models/product_color.dart';
import 'package:flutter_sweater_shop/Models/product_size.dart';
import 'package:flutter_sweater_shop/Models/variant.dart';

class VariableProduct extends Product {
  final List<ProductVariant> variants;

  VariableProduct(
      super.id, super.name, super.image, super.description, this.variants);

  factory VariableProduct.fromJson(Map<String, dynamic> json) {
    int id = json['id'] as int;
    String name = json['name'];
    String image = json['image'];
    String description = json['description'];
    List<Map<String, dynamic>> variantsJson = json['variants'];
    List<ProductVariant> variants =
        variantsJson.map((e) => ProductVariant.fromJson(e)).toList();

    return VariableProduct(id, name, image, description, variants);
  }

  double get minPrice {
    return variants
        .reduce(
            (value, element) => value.price < element.price ? value : element)
        .price;
  }

  List<ProductColor> get colors =>
      variants.where((e) => e.hasColor).map((e) => e.color!).toSet().toList();

  List<ProductSize> get sizes =>
      variants.where((e) => e.hasSize).map((e) => e.size!).toSet().toList();

  bool get isColorable => colors.isNotEmpty;

  bool get isSizeable => sizes.isNotEmpty;

  ProductVariant? getVariant(
      ProductSize? productSize, ProductColor? productColor) {
    List<ProductVariant> possibleVariants = variants;
    if (isSizeable) {
      possibleVariants =
          possibleVariants.where((e) => e.size == productSize).toList();
    }
    if (isColorable) {
      possibleVariants =
          possibleVariants.where((e) => e.color == productColor).toList();
    }
    return possibleVariants.isEmpty ? null : possibleVariants.elementAt(0);
  }

  double getPrice(ProductSize? productSize, ProductColor? productColor) {
    ProductVariant? productVariant = getVariant(productSize, productColor);
    return productVariant?.price ?? double.infinity;
  }
}
