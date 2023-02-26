import 'package:flutter_sweater_shop/Models/product.dart';
import 'package:flutter_sweater_shop/Models/product_color.dart';
import 'package:flutter_sweater_shop/Models/product_size.dart';
import 'package:flutter_sweater_shop/Models/variable_product.dart';
import 'package:flutter_sweater_shop/Models/variant.dart';

class ShoppingItem extends Product {
  final String itemId;
  final double price;
  int quantity = 1;
  final ProductColor? productColor;
  final ProductSize? productSize;

  ShoppingItem(
    super.id,
    super.name,
    super.image,
    super.description,
    this.itemId,
    this.price, {
    this.productColor,
    this.productSize,
  });

  factory ShoppingItem.fromJson(Map<String, dynamic> json) {
    String productId = json['productId'];
    String name = json['name'];
    String image = json['image'];
    String description = json['description'];
    String id = json["id"];
    double price = json['price'] as double;
    ProductColor? productColor =
        json['color'] != null ? ProductColor.fromJson(json['color']) : null;
    ProductSize? productSize =
        json['size'] != null ? ProductSize.fromJson(json['size']) : null;

    return ShoppingItem(productId, name, image, description, id, price,
        productColor: productColor, productSize: productSize);
  }

  factory ShoppingItem.fromProduct(VariableProduct product,
      ProductSize? productSize, ProductColor? productColor) {
    ProductVariant? variant = product.getVariant(productSize, productColor);
    if (variant == null) throw Exception("Invalid product variant!");
    return ShoppingItem(
      product.id,
      product.name,
      product.image,
      product.description,
      variant.id,
      variant.price,
      productSize: variant.size,
      productColor: variant.color,
    );
  }

  bool get hasColor => productColor != null;

  bool get hasSize => productSize != null;

  // toJson method is used to convert the object into a Map<String, dynamic>

  Map<String, dynamic> toJson() {
    return {
      'productId': id,
      'name': name,
      'image': image,
      'description': description,
      'id': itemId,
      'price': price,
      'color': productColor?.toJson(),
      'size': productSize?.toJson(),
    };
  }
}
