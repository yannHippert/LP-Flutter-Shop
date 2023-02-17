import 'package:flutter_sweater_shop/Models/product.dart';

class UpdateProductAction {
  final Product updatedProduct;

  UpdateProductAction(this.updatedProduct);
}

class AddProductsAction {
  final List<Product> payload;

  AddProductsAction(this.payload);
}
