import 'package:flutter_sweater_shop/Models/product.dart';

class UpdateProductAction {
  final Product updatedProduct;

  UpdateProductAction(this.updatedProduct);
}

class LoginAction {
  final String email;

  LoginAction(this.email);
}

class LogoutAction {
  LogoutAction();
}
