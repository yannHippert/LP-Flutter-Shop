import 'package:flutter_sweater_shop/Models/product.dart';
import 'package:flutter_sweater_shop/Models/user_info.dart';
import 'package:flutter_sweater_shop/redux/actions.dart';
import 'package:flutter_sweater_shop/redux/app_state.dart';

AppState updateProductsReducer(AppState state, dynamic action) {
  if (action is AuthenticateAction) {}

  if (action is LoginAction) {
    return AppState(
        userInfo: UserInfo(email: action.email), products: state.products);
  }

  if (action is LogoutAction) {
    return AppState(
        userInfo: const UserInfo(email: ""), products: state.products);
  }

  if (action is UpdateProductAction) {
    List<Product> newProducts = state.products
        .map((product) => product.id == action.updatedProduct.id
            ? action.updatedProduct
            : product)
        .toList();

    return AppState(userInfo: state.userInfo, products: newProducts);
  }

  return state;
}
