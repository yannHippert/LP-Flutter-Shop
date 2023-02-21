import 'dart:async';

import 'package:flutter_sweater_shop/Exceptions/api_exception.dart';
import 'package:flutter_sweater_shop/Models/order.dart';
import 'package:flutter_sweater_shop/Utilities/api_client.dart';
import 'package:flutter_sweater_shop/redux/actions/order.dart';
import 'package:flutter_sweater_shop/redux/app_state.dart';
import 'package:redux_thunk/redux_thunk.dart';
import 'package:redux/redux.dart';

ThunkAction<AppState> fetchOrders(Completer completer) {
  return (Store<AppState> store) async {
    try {
      List<Order> orders = await ApiClient.fetchOrders();
      store.dispatch(SetOrdersAction(orders));
      completer.complete();
    } on ApiException catch (e) {
      completer.completeError(e);
    }
  };
}
