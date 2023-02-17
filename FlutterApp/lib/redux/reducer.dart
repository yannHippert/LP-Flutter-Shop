import 'package:flutter_sweater_shop/Models/product.dart';
import 'package:flutter_sweater_shop/Models/user_info.dart';
import 'package:flutter_sweater_shop/redux/actions/authentication.dart';
import 'package:flutter_sweater_shop/redux/actions/order.dart';
import 'package:flutter_sweater_shop/redux/actions/product.dart';
import 'package:flutter_sweater_shop/redux/app_state.dart';

AppState updateProductsReducer(AppState state, dynamic action) {
  if (action is LoginAction) {
    return AppState(
      orders: state.orders,
      favorites: state.favorites,
      products: state.products,
      userInfo: UserInfo(email: action.email),
    );
  }

  if (action is LogoutAction) {
    return AppState(
      orders: state.orders,
      favorites: state.favorites,
      products: state.products,
      userInfo: const UserInfo(email: ""),
    );
  }

  if (action is UpdateProductAction) {
    List<Product> newProducts = state.products
        .map((product) => product.id == action.updatedProduct.id
            ? action.updatedProduct
            : product)
        .toList();

    return AppState(
      userInfo: state.userInfo,
      orders: state.orders,
      favorites: state.favorites,
      products: newProducts,
    );
  }

  if (action is AddProductsAction) {
    return AppState(
      userInfo: state.userInfo,
      orders: state.orders,
      favorites: state.favorites,
      products: [...state.products, ...action.payload],
    );
  }

  if (action is SetOrdersAction) {
    return AppState(
      userInfo: state.userInfo,
      favorites: state.favorites,
      products: state.products,
      orders: action.payload,
    );
  }

  return state;
}
