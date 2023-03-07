import 'package:flutter_sweater_shop/Models/variable_product.dart';

class AddProductsAction {
  final List<VariableProduct> payload;

  AddProductsAction(this.payload);
}

class SetProductsAction {
  final List<VariableProduct> payload;

  SetProductsAction(this.payload);
}
