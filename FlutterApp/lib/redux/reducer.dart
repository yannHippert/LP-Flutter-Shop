import 'package:flutter_sweater_shop/Models/variable_product.dart';
import 'package:flutter_sweater_shop/Models/user_info.dart';
import 'package:flutter_sweater_shop/redux/actions/authentication.dart';
import 'package:flutter_sweater_shop/redux/actions/basket.dart';
import 'package:flutter_sweater_shop/redux/actions/order.dart';
import 'package:flutter_sweater_shop/redux/actions/product.dart';
import 'package:flutter_sweater_shop/redux/app_state.dart';

AppState updateProductsReducer(AppState state, dynamic action) {
  if (action is LoginAction) {
    return AppState.fromAppState(
      state,
      userInfo: UserInfo(email: action.email),
    );
  }

  if (action is LogoutAction) {
    return AppState.fromAppState(
      state,
      userInfo: const UserInfo(email: ""),
    );
  }

  if (action is UpdateProductAction) {
    List<VariableProduct> newProducts = state.products
        .map((product) => product.id == action.updatedProduct.id
            ? action.updatedProduct
            : product)
        .toList();

    return AppState.fromAppState(state, products: newProducts);
  }

  if (action is AddProductsAction) {
    return AppState.fromAppState(
      state,
      products: [...state.products, ...action.payload],
    );
  }

  if (action is SetOrdersAction) {
    return AppState.fromAppState(
      state,
      orders: action.payload,
    );
  }

  if (action is AddBasketItemAction) {
    return AppState.fromAppState(
      state,
      basket: [...state.basket, action.basketItem],
    );
  }

  if (action is DeleteBasketItemAction) {
    return AppState.fromAppState(
      state,
      basket: state.basket
          .where((element) => element.itemId != action.itemId)
          .toList(),
    );
  }

  return state;
}
