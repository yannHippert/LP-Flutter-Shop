import 'package:flutter_sweater_shop/Models/interfaces/colorable.dart';
import 'package:flutter_sweater_shop/Models/interfaces/sizeable.dart';
import 'package:flutter_sweater_shop/Models/product.dart';
import 'package:flutter_sweater_shop/Models/product_color.dart';

class Bonnet extends Product implements Colorable {
  final List<ProductColor> _colors;

  Bonnet(
      {required String id,
      required String name,
      required String image,
      required double basePrice,
      required List<ProductColor> colors})
      : _colors = colors,
        super(id: id, name: name, basePrice: basePrice, image: image);

  @override
  List<ProductColor> get colors {
    return _colors;
  }
}
