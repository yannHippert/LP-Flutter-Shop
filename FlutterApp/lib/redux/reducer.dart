import 'package:flutter_sweater_shop/redux/app_state.dart';
import 'package:flutter_sweater_shop/redux/reducers/basket.dart';
import 'package:flutter_sweater_shop/redux/reducers/category.dart';
import 'package:flutter_sweater_shop/redux/reducers/order.dart';
import 'package:flutter_sweater_shop/redux/reducers/product.dart';
import 'package:flutter_sweater_shop/redux/reducers/user_info.dart';
import 'package:flutter_sweater_shop/redux/reducers/wishlist.dart';

AppState appStateReducer(AppState state, dynamic action) {
  return AppState(
    userInfo: userInfoReducer(state.userInfo, action),
    products: productsReducer(state.products, action),
    wishlist: wishlistReducer(state.wishlist, action),
    basket: basketReducer(state.basket, action),
    orders: orderReducer(state.orders, action),
    categories: categoryReducer(state.categories, action),
  );
}
