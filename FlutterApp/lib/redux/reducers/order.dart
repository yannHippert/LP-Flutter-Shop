import 'package:flutter_sweater_shop/Models/order.dart';
import 'package:flutter_sweater_shop/redux/actions/order.dart';

List<Order> orderReducer(List<Order> orders, action) {
  if (action is SetOrdersAction) {
    return action.payload;
  }

  if (action is AddOrderAction) {
    return [action.payload, ...orders];
  }

  return orders;
}
