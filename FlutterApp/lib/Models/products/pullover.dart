import 'package:flutter_sweater_shop/Models/interfaces/sizeable.dart';
import 'package:flutter_sweater_shop/Models/product.dart';

class Pullover extends Product implements Sizeable {
  final List<String> _sizes;

  Pullover(
      {required String id,
      required String name,
      required String image,
      required double basePrice,
      required List<String> sizes})
      : _sizes = sizes,
        super(id: id, name: name, basePrice: basePrice, image: image);

  @override
  List<String> get sizes {
    return _sizes;
  }
}
