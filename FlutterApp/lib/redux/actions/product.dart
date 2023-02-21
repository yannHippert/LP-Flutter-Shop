import 'package:flutter_sweater_shop/Models/variable_product.dart';

class UpdateProductAction {
  final VariableProduct updatedProduct;

  UpdateProductAction(this.updatedProduct);
}

class AddProductsAction {
  final List<VariableProduct> payload;

  AddProductsAction(this.payload);
}
